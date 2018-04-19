Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:45085 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753581AbeDSXmX (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 19 Apr 2018 19:42:23 -0400
Received: by mail-ua0-f193.google.com with SMTP id j18so4587429uae.12
        for <linux-wpan@vger.kernel.org>; Thu, 19 Apr 2018 16:42:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180419205303.30035-1-aring@mojatatu.com>
References: <20180419205303.30035-1-aring@mojatatu.com>
From: Alexander Aring <aring@mojatatu.com>
Date: Thu, 19 Apr 2018 19:42:21 -0400
Message-ID: <CAOHTApiq_PNEWbD6xgrWRyUVvVw9DSWL+mmwc3Uf2=9vkV-n1w@mail.gmail.com>
Subject: Re: [PATCH wpan] net: cfg802154: mark ieee802154_addr as packed
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>, kernel@mojatatu.com, Alexander Aring <aring@mojatatu.com>

Hi,

On Thu, Apr 19, 2018 at 4:53 PM, Alexander Aring <aring@mojatatu.com> wrote:
> This patch marks ieee802154_addr as packed as it used by memcmp to
> compare this struct for rhashtable in fragmentation api.
>
> Fixes: 648700f76b03 ("inet: frags: use rhashtables for reassembly units")
> Reported-by: Stefan Schmidt <stefan@osg.samsung.com>
> Signed-off-by: Alexander Aring <aring@mojatatu.com>
> ---
>  include/net/cfg802154.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> index 795ca4008f72..fc5dab9c798e 100644
> --- a/include/net/cfg802154.h
> +++ b/include/net/cfg802154.h
> @@ -242,7 +242,7 @@ struct ieee802154_addr {
>                 __le16 short_addr;
>                 __le64 extended_addr;
>         };
> -};
> +} __packed;
>

Stefan drop this one, it was somehow to fix my issue at first... but
its not the real solution.
I just did a hexdump on the key and saw that the length doesn't fit
what sizeof tells me so I did that and was too happy that it worked.

The real fix would be to figure out why I have some "random" bits in
this structure... something need to have memset to zero before... I
need to check, so far I see it only in FRAG1 I guess it's related to
uncompression...

This fix will work so far... but you will get issues in short address
handling which will be filled with more padding bytes and this should
be zero, so it's all the same...

Sorry.

- Alex
