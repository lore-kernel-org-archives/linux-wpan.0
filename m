Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD46C433EF
	for <linux-wpan@archiver.kernel.org>; Wed, 18 May 2022 00:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbiERAwv (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 17 May 2022 20:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbiERAwv (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 17 May 2022 20:52:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80B0F53B60
        for <linux-wpan@vger.kernel.org>; Tue, 17 May 2022 17:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652835168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S9mad11/WKyJ8qtJwe6UAYP1am6w3wILeYCMPsK0T8Q=;
        b=OUEJEx7L4VdF8gc8YvU7ThQ9qOzTKyWzlSGwEbeEKze4t42zqMCcLFJIyTaI5Vl91LfmcM
        Hzn9jwJVL/a22yx7oAqhtaOsmakuFdXPvBvWboyf2V3QfGIcIrEDLlwTUj6vinnGAWYo3b
        Hu7SbA8zXfBC/cx2G/P8FOtagG02Ock=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-108-0vKztDKlMEG_kBu6nkgI5w-1; Tue, 17 May 2022 20:52:47 -0400
X-MC-Unique: 0vKztDKlMEG_kBu6nkgI5w-1
Received: by mail-qk1-f197.google.com with SMTP id o18-20020a05620a2a1200b006a0cc3d8463so451458qkp.4
        for <linux-wpan@vger.kernel.org>; Tue, 17 May 2022 17:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S9mad11/WKyJ8qtJwe6UAYP1am6w3wILeYCMPsK0T8Q=;
        b=3ZwvMJMuHMVc2xd3Pi6yg26PV3lw9MQ/MJk1lYZ4uT/HY4HIDnl5OvLw5qL7QLBGKZ
         Dl96IQVFpQSTSg0RDkkVo9l9oUmf3FWyVrkIpDyQkfuI/tmYpuBQmCepTvgH/gzL7zXe
         93g6huWp23F2OwsHqlGTj4gBFNYOWlIeALqQ8rdOellFoy/cCJ0xwyh5oC0tN44RA63d
         iun5W90b3QGtwpKhiHBx/akwtEDLJjIFyLercMw+jeeg6QTZT/8/zbHHaodzX5H41QlL
         pZ97/Ue/bAMkC3uIKqDOVkH6Vp9LFoLX1/r0aBTNNpfoEF5A8cw1ll5W4yXElM6IhTKl
         zVvw==
X-Gm-Message-State: AOAM530VUG21nKvSSyRW3U9YvfBHGQsIXfcZodOAEHbLOrnJ2m0VdEXV
        0Da8nm4mfgHFdJ6laYAu3g+ni2wG8tN0T/LC1n3d/Lptcn6vlhL0q6o9E0v9qVrjnEpgtMVv774
        5svyZhbP/Kc3dlZ+cCRNB3QPDJ8gTGiPtemy3Sw==
X-Received: by 2002:a05:620a:40c2:b0:6a0:2b1b:2b86 with SMTP id g2-20020a05620a40c200b006a02b1b2b86mr18374822qko.80.1652835166683;
        Tue, 17 May 2022 17:52:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwj5CgY3t/X6jWl5mD6OgnYRUwIXUSh+pKul9iwwO4sgu7eTlEHEdWngGAKINHo2zh9bC3tDB7N/laKZy7XqGo=
X-Received: by 2002:a05:620a:40c2:b0:6a0:2b1b:2b86 with SMTP id
 g2-20020a05620a40c200b006a02b1b2b86mr18374813qko.80.1652835166496; Tue, 17
 May 2022 17:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220517163450.240299-1-miquel.raynal@bootlin.com> <20220517163450.240299-12-miquel.raynal@bootlin.com>
In-Reply-To: <20220517163450.240299-12-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 17 May 2022 20:52:35 -0400
Message-ID: <CAK-6q+hPWRUobMATaxD6rZ1zfQUnS_6pMacr+rKVHRAWe1xzSQ@mail.gmail.com>
Subject: Re: [PATCH wpan-next v3 11/11] net: mac802154: Add a warning in the
 slow path
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
> In order to be able to detect possible conflicts between the net
> interface core and the ieee802154 core, let's add a warning in the slow
> path: we want to be sure that whenever we start an asynchronous MLME
> transmission (which can be fully asynchronous) the net core somehow
> agrees that this transmission is possible, ie. the device was not
> stopped. Warning in this case would allow us to track down more easily
> possible issues with the MLME logic if we ever get reports.
>
> Unlike in the hot path, such a situation cannot be handled.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  net/mac802154/tx.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
> index e36aca788ea2..53a8be822e33 100644
> --- a/net/mac802154/tx.c
> +++ b/net/mac802154/tx.c
> @@ -132,6 +132,25 @@ int ieee802154_sync_and_hold_queue(struct ieee802154_local *local)
>         return ret;
>  }
>
> +static bool ieee802154_netif_is_down(struct ieee802154_local *local)
> +{
> +       struct ieee802154_sub_if_data *sdata;
> +       bool is_down = true;
> +
> +       rcu_read_lock();
> +       list_for_each_entry_rcu(sdata, &local->interfaces, list) {
> +               if (!sdata->dev)
> +                       continue;
> +
> +               is_down = !(sdata->dev->flags & IFF_UP);
> +               if (is_down)
> +                       break;

I thought that the helper would be "netif_running()". It seems there
are multiple ways to check if an interface is up.

> +       }
> +       rcu_read_unlock();
> +
> +       return is_down;
> +}
> +
>  static int ieee802154_mlme_op_pre(struct ieee802154_local *local)
>  {
>         return ieee802154_sync_and_hold_queue(local);
> @@ -150,6 +169,12 @@ static int ieee802154_mlme_tx(struct ieee802154_local *local, struct sk_buff *sk
>         if (!local->open_count)
>                 return -EBUSY;
>
> +       /* Warn if the ieee802154 core thinks MLME frames can be sent while the
> +        * net interface expects this cannot happen.
> +        */
> +       if (WARN_ON_ONCE(ieee802154_netif_is_down(local)))
> +               return -EHOSTDOWN;

maybe also ENETDOWN? Also there is a missing rtnl_unlock().

- Alex

