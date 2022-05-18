Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB5BC433F5
	for <linux-wpan@archiver.kernel.org>; Wed, 18 May 2022 00:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiERA6f (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 17 May 2022 20:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbiERA6d (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 17 May 2022 20:58:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02CB653E3E
        for <linux-wpan@vger.kernel.org>; Tue, 17 May 2022 17:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652835512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wJkD+7oiHBwfQ5b1c2K9F5TgSK//yqvR5ZJ7NvoECkI=;
        b=f2oxS4jVBNRuwHXLu4L3fpLjwwYj3cC6ueK2S4uf/ug36ukqIEj84Kmvj04bJ5/v+/GgT/
        Z1ORGDrCU5WVIRRhN6pw+OAwsZ7Nd8aeOAViHWaDngKWUSlr+5XL240qoRVmtS9Q9aYq3V
        X8U+dgQxsBWZ0Adp3/gwk8FZHmiLO0o=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-9ltPlhezNxq5EYzlshdRJw-1; Tue, 17 May 2022 20:58:30 -0400
X-MC-Unique: 9ltPlhezNxq5EYzlshdRJw-1
Received: by mail-qv1-f71.google.com with SMTP id j2-20020a0cfd42000000b0045ad9cba5deso469574qvs.5
        for <linux-wpan@vger.kernel.org>; Tue, 17 May 2022 17:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wJkD+7oiHBwfQ5b1c2K9F5TgSK//yqvR5ZJ7NvoECkI=;
        b=qKsn7id4cgtDkC2OR5bxZIMNWnyeDh0DDcQAziGkF5fv3dKskUJ18yk1546jsm1wOc
         N1ThXBish7ScjAfWURUkCRxJ5zFF5UgUwwKoesK88sANGoLJ8Yc1ANJBvZNOFJsalL90
         Bp0IgzQNuaeAEoIzgyuLMYECYqi+WoG9plZrxlZdiiXg733uPp8O+j1sTbYzbR1ZQ7jN
         ZnVmJueKhyymX2zMqGTTTwkqT2IIjRsDbfuLDCCc86eUYvV2nayxqlPtXgtEbmSvr5+T
         WojPqr0OB2YEjm8jB519PkQAcSlvMSinUS8yfTC4Nu56O30ZIlmFCRXPDdmV1GkAGanz
         ijEg==
X-Gm-Message-State: AOAM531dc4qQSzge3afwuGHvtmvfH4/0MlRD/7oI9mh66jHPmGpastAC
        x86WFErsNhbvRWSCA1Y7NibKsgBjNzHIkT4TGSEiTZsi9l/EM8/jPgvcSFal1k+ySirOYlEzW2g
        LuPLxKkkNhs9CC8ihpS+Gb3wZlgix5g3KmS7vLA==
X-Received: by 2002:a05:6214:c29:b0:45a:fedd:7315 with SMTP id a9-20020a0562140c2900b0045afedd7315mr22355454qvd.59.1652835510118;
        Tue, 17 May 2022 17:58:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxg2xsobmhJ0gWNTQvpUgTVzDFpajtyaVVrEIKB3QgnXbi3qDoqkxEKIgNnDwQs+aBbl3JSmsaueD+fg+PJM0s=
X-Received: by 2002:a05:6214:c29:b0:45a:fedd:7315 with SMTP id
 a9-20020a0562140c2900b0045afedd7315mr22355440qvd.59.1652835509965; Tue, 17
 May 2022 17:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220517163450.240299-1-miquel.raynal@bootlin.com> <20220517163450.240299-11-miquel.raynal@bootlin.com>
In-Reply-To: <20220517163450.240299-11-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 17 May 2022 20:58:19 -0400
Message-ID: <CAK-6q+g=9_aqTOmMYxCn6p=Z=uPNyifjVXe4hzC82ZF1QPpLMg@mail.gmail.com>
Subject: Re: [PATCH wpan-next v3 10/11] net: mac802154: Add a warning in the
 hot path
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Tue, May 17, 2022 at 12:35 PM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> We should never start a transmission after the queue has been stopped.
>
> But because it might work we don't kill the function here but rather
> warn loudly the user that something is wrong.
>
> Set an atomic when the queue will remain stopped. Reset this atomic when
> the queue actually gets restarded. Just check this atomic to know if the
> transmission is legitimate, warn if it is not.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  include/net/cfg802154.h |  1 +
>  net/mac802154/tx.c      | 16 +++++++++++++++-
>  net/mac802154/util.c    |  1 +
>  3 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> index 8881b6126b58..f4e7b3fe7cf0 100644
> --- a/include/net/cfg802154.h
> +++ b/include/net/cfg802154.h
> @@ -218,6 +218,7 @@ struct wpan_phy {
>         spinlock_t queue_lock;
>         atomic_t ongoing_txs;
>         atomic_t hold_txs;
> +       unsigned long queue_stopped;

Can we name it something like state_flags (as phy state flags)? Pretty
sure there will be more coming, or internal_flags, no idea...
something_flags...

>         wait_queue_head_t sync_txq;
>
>         char priv[] __aligned(NETDEV_ALIGN);
> diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
> index 6cc4e5c7ba94..e36aca788ea2 100644
> --- a/net/mac802154/tx.c
> +++ b/net/mac802154/tx.c
> @@ -123,9 +123,13 @@ static int ieee802154_sync_queue(struct ieee802154_local *local)
>
>  int ieee802154_sync_and_hold_queue(struct ieee802154_local *local)
>  {
> +       int ret;
> +
>         ieee802154_hold_queue(local);
> +       ret = ieee802154_sync_queue(local);
> +       set_bit(0, &local->phy->queue_stopped);
>

Define the 0 as WPAN_PHY_STATE_QUEUE_STOPPED_BIT or something like
that, above wpan_phy.

- Alex

