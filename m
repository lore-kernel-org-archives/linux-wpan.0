Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4279DC6FA82
	for <linux-wpan@archiver.kernel.org>; Mon,  5 Sep 2022 01:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiIEBer (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 4 Sep 2022 21:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbiIEBer (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 4 Sep 2022 21:34:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE3F10562
        for <linux-wpan@vger.kernel.org>; Sun,  4 Sep 2022 18:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662341685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ETFgaft46ODpaKViq/0Cxuj5XpxgnYE+9qnLqCaNLLY=;
        b=CuVV+fF5VEuRxnntI7qLkS40E27UGGe0F2h9IzoE0q2v+TFaR4vAGxtw+cWPYmIz0G1Agk
        NkV8Hqetqn93NOYqxYL5fv97cmMrHiXjYabZgk7GJd466bPr2+y5G3rfl7yrGmBN6v/ZTk
        gCj0ArJyCQ42FQ3lNlYmn7MYcmFqOHE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-70-Z4u6XjymOtSxBTn6Db3H2w-1; Sun, 04 Sep 2022 21:34:43 -0400
X-MC-Unique: Z4u6XjymOtSxBTn6Db3H2w-1
Received: by mail-qk1-f197.google.com with SMTP id f1-20020a05620a280100b006bc4966f463so5984839qkp.4
        for <linux-wpan@vger.kernel.org>; Sun, 04 Sep 2022 18:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ETFgaft46ODpaKViq/0Cxuj5XpxgnYE+9qnLqCaNLLY=;
        b=lsjmR39JIk2f053FgouOaQR6P3Z/24qO9Qnanyyh6Ks36+z1Z0enF4RpBx/NOks/lN
         kBHvga+4uKa2aodk/yYjNTCAaXp4MJnFg8j3ccINo+iTch8d8DGr1HY47gbvd02bz4jg
         6bgjx3fqu8aPCtYZbtoeARYToc294KQh4cos096Sqx6s4PWBpzsjVRvtZdwV99RiJHVP
         Vh3GEZNTFr72jhKqGE9t9Ofm3sY7ALb5ptjus3BP+6jreaOGUl6AFsGWCAePCnMReuxc
         gR+9u3SPnFyLvHKEjQBl9MVzx46W82QqXM9Zyv02uT+mk2HUE+/5QuUoNrOo2Qt3vszC
         l15Q==
X-Gm-Message-State: ACgBeo3yCIVwR77f2/SDMBAZMn227XHU1mvVlpH9rJGHb15FFqzcxuQh
        G6Ba4KBCbOVmYzKKnho5wbxss3/2ztFzJi/5DIs/Jj6weC8ajtUWhXoYb4TtpRXbV+xk6N+mGX+
        Ac0ocI+uKqz0bS3iJ7hu/LAGsUpvLhyqvwbB3Xg==
X-Received: by 2002:a05:622a:4:b0:344:94b7:a396 with SMTP id x4-20020a05622a000400b0034494b7a396mr36797033qtw.123.1662341683567;
        Sun, 04 Sep 2022 18:34:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6MUrEFU3sxIKdHpQVkbH9ejXtBcvFdTFMTJ4qnE+HjMKJQ/9L4EzX5KkOYGVD0uBZpJV1TVHP/jEDuCjcWr6U=
X-Received: by 2002:a05:622a:4:b0:344:94b7:a396 with SMTP id
 x4-20020a05622a000400b0034494b7a396mr36797022qtw.123.1662341683373; Sun, 04
 Sep 2022 18:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220826144049.256134-1-miquel.raynal@bootlin.com> <20220826144049.256134-3-miquel.raynal@bootlin.com>
In-Reply-To: <20220826144049.256134-3-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 4 Sep 2022 21:34:32 -0400
Message-ID: <CAK-6q+gYTPOiGO5kmqdPUOySwtrL_vaWLav7ehbOWihvKhYevA@mail.gmail.com>
Subject: Re: [PATCH wpan-next v2 02/11] net: mac802154: Drop IEEE802154_HW_RX_DROP_BAD_CKSUM
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Network Development <netdev@vger.kernel.org>,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Fri, Aug 26, 2022 at 10:41 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> This IEEE802154_HW_RX_DROP_BAD_CKSUM flag was only used by hwsim to
> reflect the fact that it would not validate the checksum (FCS). In other
> words, the filtering level of hwsim is always "NONE" while the core
> expects it to be higher.
>
> Now that we have access to real filtering levels, we can actually use
> them and always enforce the "NONE" level in hwsim. Handling this case
> correctly in the receive path permits to drop the above mentioned flag.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/net/ieee802154/mac802154_hwsim.c | 10 +++++++++-
>  include/net/mac802154.h                  |  4 ----
>  net/mac802154/rx.c                       |  6 ++----
>  3 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
> index 38c217bd7c82..d7e4048e8743 100644
> --- a/drivers/net/ieee802154/mac802154_hwsim.c
> +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> @@ -148,6 +148,8 @@ static int hwsim_hw_start(struct ieee802154_hw *hw)
>         struct hwsim_phy *phy = hw->priv;
>
>         phy->suspended = false;
> +       hw->phy->filtering = IEEE802154_FILTERING_NONE;
> +
>         return 0;
>  }
>
> @@ -161,6 +163,9 @@ static void hwsim_hw_stop(struct ieee802154_hw *hw)
>  static int
>  hwsim_set_promiscuous_mode(struct ieee802154_hw *hw, const bool on)
>  {
> +       /* hwsim does not filter anything, so enforce the NONE level */
> +       hw->phy->filtering = IEEE802154_FILTERING_NONE;
> +
>         return 0;
>  }
>
> @@ -791,7 +796,10 @@ static int hwsim_add_one(struct genl_info *info, struct device *dev,
>         phy->idx = idx;
>         INIT_LIST_HEAD(&phy->edges);
>
> -       hw->flags = IEEE802154_HW_PROMISCUOUS | IEEE802154_HW_RX_DROP_BAD_CKSUM;
> +       /* This is a lie, hwsim does not even filter bad FCS, but we need to
> +        * advertize a PROMISCUOUS to be able to create COORD interfaces.
> +        */

I think this is now different because PROMISCUOUS/any disable address
filtering will disable AACK and this is not what we want, or? This
comment was made with the assumption to deal with acks which we can't?

I did not look further into this patch series yet.

- Alex

