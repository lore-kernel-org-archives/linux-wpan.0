Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33190 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbbDIHV5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 9 Apr 2015 03:21:57 -0400
Received: by wiax7 with SMTP id x7so48751205wia.0
        for <linux-wpan@vger.kernel.org>; Thu, 09 Apr 2015 00:21:56 -0700 (PDT)
Date: Thu, 9 Apr 2015 09:21:50 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next] mac802154: fix typo for device
Message-ID: <20150409072147.GA1261@omega>
References: <1428561343-32752-1-git-send-email-varkabhadram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1428561343-32752-1-git-send-email-varkabhadram@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: varkabhadram@gmail.com
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

Hi Varka,

On Thu, Apr 09, 2015 at 12:05:43PM +0530, varkabhadram@gmail.com wrote:
> From: Varka Bhadram <varkab@cdac.in>
> 
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
>  include/net/mac802154.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/mac802154.h b/include/net/mac802154.h
> index d6a809e..56ef97a 100644
> --- a/include/net/mac802154.h
> +++ b/include/net/mac802154.h
> @@ -247,7 +247,7 @@ static inline void ieee802154_le64_to_be64(void *be64_dst, const void *le64_src)
>  	__put_unaligned_memmove64(swab64p(le64_src), be64_dst);
>  }
>  
> -/* Basic interface to register ieee802154 hwice */
> +/* Basic interface to register ieee802154 device */

This typo occured when I did a 's/dev/hw/' in my editor. This replaced
all dev to hw.

I did this because the variable was always named "dev" which was very
confusing to handle between netdev "dev" and this one. Look at commit:

5a50439775853a8d565115edb63a5ab4bb780479 ("ieee802154: rename
ieee802154_dev to ieee802154_hw")

For keeping the wireless naming conventation.

This also means that calling this "device" is wrong and "hw" is correct.
So we should change the comment to:

/* Basic interface to register ieee802154 hw */

or

/* Basic interface to register ieee802154 hardware */

>  struct ieee802154_hw *
>  ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops);

This comment is also some kind of useless. What I mean is the comment
describes a "basic interface for register ...", better would be a
comment above each function like.

/**
 *	ieee802154_register_hw - register the ieee802154 hardware
 *	@hw: ieee802154 hardware
 *
 * Registers the ieee802154 hw struct into the mac802154 subsystem.
 */
... ieee802154_register_hw ...

/**
 *	ieee802154_free_hw - your imagination
 *	@hw: ieee802154 hardware
 *
 * Your imagination ... the ieee802154_hw should called
 * ieee802154_unregister_hw before.
 */
... ieee802154_register_hw ...


Something like that, if you want to change the typo, I am also fine
with that. :-)

For general comment style I simple lookup:

include/linux/netdevice.h - how "real" netdev coreapi deals with
comments.

btw: I think the most important comments would be for the nl802154
header.

>  void ieee802154_free_hw(struct ieee802154_hw *hw);

- Alex
