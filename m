Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BABC433FE
	for <linux-wpan@archiver.kernel.org>; Tue, 18 Oct 2022 23:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJRX5l (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 18 Oct 2022 19:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiJRX5k (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 18 Oct 2022 19:57:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD61D2CFA
        for <linux-wpan@vger.kernel.org>; Tue, 18 Oct 2022 16:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666137458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PGywE1yLJDCgQD3UKpQDgXpybKsCI0XInRlMdrpJ5nc=;
        b=eHh++HsmV3p9zD93J/+7OuQnn256T2d/YdsX/6a9mHWnyMItQtzDyxjsTC9zsenKTLWww1
        ZOTfR85kZIxN1Sulq6BiWySdjRHplXn8H7cMOTPvAXPEo7dnuICDZ8KpQNTYYFZ8rzvNY/
        DcHAkonRmK/WGljuQRrhf/pbmZf6r5U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-467-Auf2GxdvMAW2v5Z3r6WwiQ-1; Tue, 18 Oct 2022 19:57:31 -0400
X-MC-Unique: Auf2GxdvMAW2v5Z3r6WwiQ-1
Received: by mail-wm1-f71.google.com with SMTP id r81-20020a1c4454000000b003c41e9ae97dso12015995wma.6
        for <linux-wpan@vger.kernel.org>; Tue, 18 Oct 2022 16:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGywE1yLJDCgQD3UKpQDgXpybKsCI0XInRlMdrpJ5nc=;
        b=rCDrctYLrUhWTchWm/tg59+M2+q9K+V7uiJpnwwx1RcnlbEuTRng5SNglxTfVSSHiN
         WWA8Y3ZZBP3dCq6X3q7NE2nf3093JqUhMs4F7FvD5kouGpnEN/mTUT1w/ET1SPRQ5Mf+
         WnjUOX/R9v3vNRT/6pC+OM9J3ItIv0eZlFGI9fs2yat5OVueb6qOFEusFML+6hD9HJ0x
         Kih6JjWarlTF84GlKDjQW+FmCRZdGVsyqziiS8xTx97h6CmM6Cvc/OTb2eEVVQuE2wVO
         Eceozb7GRi8oyNp4ouNXvJ2vMHBufDcwUFAWDb64hQAoNyiZwgHRcHu+6RwONASztQ5z
         3m+w==
X-Gm-Message-State: ACrzQf2tAIG2NvHmZDBRwey9nOEMj5oYcJ7fD46SIT3c3nFuIVwGxR73
        CLBsWD31gdgYEvSns19gLmUQBtG4GHB07PqGPJn2vNjdTJ2GLnz5FFT/W4pUtliN2wV+2Cn6Dom
        8ZwaV3IS53vrTPvSnukSYwky1BdXcTpcjiECUUA==
X-Received: by 2002:adf:ffc8:0:b0:231:ce45:7e02 with SMTP id x8-20020adfffc8000000b00231ce457e02mr3230459wrs.383.1666137450504;
        Tue, 18 Oct 2022 16:57:30 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM673mAv5Or8qOXeGGbw57MF/Oyw1OtQYAUyaz5Pu/u+Rv+MAq01eJhQ7EJdXJPcuijOKZzD6FSzZeRwtXb6ztY=
X-Received: by 2002:adf:ffc8:0:b0:231:ce45:7e02 with SMTP id
 x8-20020adfffc8000000b00231ce457e02mr3230448wrs.383.1666137450257; Tue, 18
 Oct 2022 16:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221018183639.806719-1-miquel.raynal@bootlin.com>
In-Reply-To: <20221018183639.806719-1-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 18 Oct 2022 19:57:19 -0400
Message-ID: <CAK-6q+hoJiLWyHNi90_7kbyGp9h_jV-bvRHYRQDVrEb1u_enEA@mail.gmail.com>
Subject: Re: [PATCH wpan-next] mac802154: Allow the creation of coordinator interfaces
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Tue, Oct 18, 2022 at 2:36 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> As a first strep in introducing proper PAN management and association,
> we need to be able to create coordinator interfaces which might act as
> coordinator or PAN coordinator.
>
> Hence, let's add the minimum support to allow the creation of these
> interfaces. This support will be improved later, in particular regarding
> the filtering.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  net/mac802154/iface.c | 14 ++++++++------
>  net/mac802154/main.c  |  2 ++
>  net/mac802154/rx.c    | 11 +++++++----
>  3 files changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
> index d9b50884d34e..682249f3369b 100644
> --- a/net/mac802154/iface.c
> +++ b/net/mac802154/iface.c
> @@ -262,13 +262,13 @@ ieee802154_check_concurrent_iface(struct ieee802154_sub_if_data *sdata,
>                 if (nsdata != sdata && ieee802154_sdata_running(nsdata)) {
>                         int ret;
>
> -                       /* TODO currently we don't support multiple node types
> -                        * we need to run skb_clone at rx path. Check if there
> -                        * exist really an use case if we need to support
> -                        * multiple node types at the same time.
> +                       /* TODO currently we don't support multiple node/coord
> +                        * types we need to run skb_clone at rx path. Check if
> +                        * there exist really an use case if we need to support
> +                        * multiple node/coord types at the same time.
>                          */
> -                       if (wpan_dev->iftype == NL802154_IFTYPE_NODE &&
> -                           nsdata->wpan_dev.iftype == NL802154_IFTYPE_NODE)
> +                       if (wpan_dev->iftype != NL802154_IFTYPE_MONITOR &&
> +                           nsdata->wpan_dev.iftype != NL802154_IFTYPE_MONITOR)
>                                 return -EBUSY;
>
>                         /* check all phy mac sublayer settings are the same.
> @@ -565,6 +565,7 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata,
>         wpan_dev->short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
>
>         switch (type) {
> +       case NL802154_IFTYPE_COORD:
>         case NL802154_IFTYPE_NODE:
>                 ieee802154_be64_to_le64(&wpan_dev->extended_addr,
>                                         sdata->dev->dev_addr);
> @@ -624,6 +625,7 @@ ieee802154_if_add(struct ieee802154_local *local, const char *name,
>         ieee802154_le64_to_be64(ndev->perm_addr,
>                                 &local->hw.phy->perm_extended_addr);
>         switch (type) {
> +       case NL802154_IFTYPE_COORD:
>         case NL802154_IFTYPE_NODE:
>                 ndev->type = ARPHRD_IEEE802154;
>                 if (ieee802154_is_valid_extended_unicast_addr(extended_addr)) {
> diff --git a/net/mac802154/main.c b/net/mac802154/main.c
> index 40fab08df24b..d03ecb747afc 100644
> --- a/net/mac802154/main.c
> +++ b/net/mac802154/main.c
> @@ -219,6 +219,8 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
>
>         if (hw->flags & IEEE802154_HW_PROMISCUOUS)
>                 local->phy->supported.iftypes |= BIT(NL802154_IFTYPE_MONITOR);
> +       else
> +               local->phy->supported.iftypes &= ~BIT(NL802154_IFTYPE_COORD);
>

So this means if somebody in the driver sets iftype COORD is supported
but then IEEE802154_HW_PROMISCUOUS is not supported it will not
support COORD?

Why is IEEE802154_HW_PROMISCUOUS required for COORD iftype? I thought
IEEE802154_HW_PROMISCUOUS is required to do a scan?

>         rc = wpan_phy_register(local->phy);
>         if (rc < 0)
> diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
> index 2ae23a2f4a09..aca348d7834b 100644
> --- a/net/mac802154/rx.c
> +++ b/net/mac802154/rx.c
> @@ -208,6 +208,7 @@ __ieee802154_rx_handle_packet(struct ieee802154_local *local,
>         int ret;
>         struct ieee802154_sub_if_data *sdata;
>         struct ieee802154_hdr hdr;
> +       struct sk_buff *skb2;
>
>         ret = ieee802154_parse_frame_start(skb, &hdr);
>         if (ret) {
> @@ -217,7 +218,7 @@ __ieee802154_rx_handle_packet(struct ieee802154_local *local,
>         }
>
>         list_for_each_entry_rcu(sdata, &local->interfaces, list) {
> -               if (sdata->wpan_dev.iftype != NL802154_IFTYPE_NODE)
> +               if (sdata->wpan_dev.iftype == NL802154_IFTYPE_MONITOR)
>                         continue;

I guess this will work but I would like to see no logic about if it's
not MONITOR it's NODE or COORD, because introducing others requires
updating those again... however I think it's fine. I would like to see
a different receive path for coord_rx() and node_rx(), but yea
currently I guess they are mostly the same... in future I think they
are required as PACKTE_HOST, etc. will be changed regarding pan
coordinator or just coordinator (so far I understood).

>
>                 if (!ieee802154_sdata_running(sdata))
> @@ -230,9 +231,11 @@ __ieee802154_rx_handle_packet(struct ieee802154_local *local,
>                     sdata->required_filtering == IEEE802154_FILTERING_4_FRAME_FIELDS)
>                         continue;
>
> -               ieee802154_subif_frame(sdata, skb, &hdr);
> -               skb = NULL;
> -               break;
> +               skb2 = skb_clone(skb, GFP_ATOMIC);
> +               if (skb2) {
> +                       skb2->dev = sdata->dev;
> +                       ieee802154_subif_frame(sdata, skb2, &hdr);
> +               }
>         }
>
>         kfree_skb(skb);

If we do the clone above this kfree_skb() should be move to
ieee802154_rx() right after __ieee802154_rx_handle_packet(). This
patch also changes that we deliver one skb to multiple interfaces if
there are more than one and I was not aware that we currently do that.
:/

- Alex

