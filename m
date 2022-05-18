Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F636C433F5
	for <linux-wpan@archiver.kernel.org>; Wed, 18 May 2022 00:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbiERAl7 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 17 May 2022 20:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiERAl6 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 17 May 2022 20:41:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35F322B262
        for <linux-wpan@vger.kernel.org>; Tue, 17 May 2022 17:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652834516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wERJ4wgK47PAcOyrRzert8+bNoC3QWGPRosED/fCVhI=;
        b=ED5n+CgaMpEplkfGl9v5QHVMX3aDw2LobbWJC8vEDqjurxDinae8wjesfotZPZGMZeTuSF
        0YG7DqsCd3Svuo8ErZAWDDwrsw7zNbV4p3vhljmPCCJLaDCIHkMNsC7Yc0JxZ7ZHziWVj8
        9/J6AiCUWHfiQiBOHV2gDcNTEkuMNvg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-0oKjj1sgPxyGsL6pfBG1Uw-1; Tue, 17 May 2022 20:41:53 -0400
X-MC-Unique: 0oKjj1sgPxyGsL6pfBG1Uw-1
Received: by mail-qv1-f71.google.com with SMTP id fw9-20020a056214238900b0043522aa5b81so399228qvb.21
        for <linux-wpan@vger.kernel.org>; Tue, 17 May 2022 17:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wERJ4wgK47PAcOyrRzert8+bNoC3QWGPRosED/fCVhI=;
        b=FD0EMZcsU+PLLTMm9Ec895qa9fWGzjYdrvJcTwacdDIaz5OVg6EM2Q5CvrHlU46bsC
         IbID6rSoXbjTq+6/zp4XPTP+Xy288mB/NMGbh3MQ8iWWjnjjyEc4cnD/W4RPm4Wy4zrK
         TIn+GeDlc+1/5GVIzRFmaF5mD1ChfnKNxO4fI2KzPrZS3ZnFGXh+3GrG2HGmjZtisKq6
         gEJMa+/eGev/XsIL5UOlMl87ksu8u4CXk6xOG77zdUauH3ww6sob+Pz2HLnnGC6SLSwG
         pq7NpPJvGm/oBGJ5BHBcZUN7cT0kjBdvEx+jujIWJz6L4GODSiuZhkOrIwavnTZrPD2Q
         SwTA==
X-Gm-Message-State: AOAM5323FvxiMV1jJv9LqgxaqLNfqiCONwPijCTv2VIrLPe+GUfwcHqJ
        Ax0+AhqEhnJGdRr8fPRgZOypsf22HmyVAQ9kJIN74kuhBCEEaIJoPFYXPnhOCmRUHRYTaAcPPKd
        NjbvtfgykYT1LRuU7NCUeiHVFxZbtcxprGuEO3A==
X-Received: by 2002:a05:6214:23c9:b0:461:c9e7:9cd6 with SMTP id hr9-20020a05621423c900b00461c9e79cd6mr12932334qvb.116.1652834512517;
        Tue, 17 May 2022 17:41:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyadn0My3D3HBXaGPzhfxj2ad+FiESM98CzYwZnx8PPV1iTmsc17Wmp8wgMacF/ZISfTXzy4MvZ3P4PnTmAgi4=
X-Received: by 2002:a05:6214:23c9:b0:461:c9e7:9cd6 with SMTP id
 hr9-20020a05621423c900b00461c9e79cd6mr12932324qvb.116.1652834512298; Tue, 17
 May 2022 17:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220517163450.240299-1-miquel.raynal@bootlin.com> <20220517163450.240299-10-miquel.raynal@bootlin.com>
In-Reply-To: <20220517163450.240299-10-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 17 May 2022 20:41:41 -0400
Message-ID: <CAK-6q+jQL7cFJrL6XjuaJnNDggtO1d_sB+T+GrY9yT+Y+KC0oA@mail.gmail.com>
Subject: Re: [PATCH wpan-next v3 09/11] net: mac802154: Introduce a
 synchronous API for MLME commands
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
> This is the slow path, we need to wait for each command to be processed
> before continuing so let's introduce an helper which does the
> transmission and blocks until it gets notified of its asynchronous
> completion. This helper is going to be used when introducing scan
> support.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  net/mac802154/ieee802154_i.h |  1 +
>  net/mac802154/tx.c           | 46 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>
> diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
> index a057827fc48a..b42c6ac789f5 100644
> --- a/net/mac802154/ieee802154_i.h
> +++ b/net/mac802154/ieee802154_i.h
> @@ -125,6 +125,7 @@ extern struct ieee802154_mlme_ops mac802154_mlme_wpan;
>  void ieee802154_rx(struct ieee802154_local *local, struct sk_buff *skb);
>  void ieee802154_xmit_sync_worker(struct work_struct *work);
>  int ieee802154_sync_and_hold_queue(struct ieee802154_local *local);
> +int ieee802154_mlme_tx_one(struct ieee802154_local *local, struct sk_buff *skb);
>  netdev_tx_t
>  ieee802154_monitor_start_xmit(struct sk_buff *skb, struct net_device *dev);
>  netdev_tx_t
> diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
> index 38f74b8b6740..6cc4e5c7ba94 100644
> --- a/net/mac802154/tx.c
> +++ b/net/mac802154/tx.c
> @@ -128,6 +128,52 @@ int ieee802154_sync_and_hold_queue(struct ieee802154_local *local)
>         return ieee802154_sync_queue(local);
>  }
>
> +static int ieee802154_mlme_op_pre(struct ieee802154_local *local)
> +{
> +       return ieee802154_sync_and_hold_queue(local);
> +}
> +
> +static int ieee802154_mlme_tx(struct ieee802154_local *local, struct sk_buff *skb)
> +{
> +       int ret;
> +
> +       /* Avoid possible calls to ->ndo_stop() when we asynchronously perform
> +        * MLME transmissions.
> +        */
> +       rtnl_lock();
> +
> +       /* Ensure the device was not stopped, otherwise error out */
> +       if (!local->open_count)
> +               return -EBUSY;
> +

No -EBUSY here, use ?-ENETDOWN?. You forgot rtnl_unlock() here.

- Alex

