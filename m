Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D0CC433EF
	for <linux-wpan@archiver.kernel.org>; Mon, 20 Jun 2022 00:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbiFTAZE (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 19 Jun 2022 20:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbiFTAZD (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 19 Jun 2022 20:25:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9F316160
        for <linux-wpan@vger.kernel.org>; Sun, 19 Jun 2022 17:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655684701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=US7qenfy4xTqnJqJ4FXH2SXINmqQKvIojVigmxTRfwY=;
        b=G+pyWdVqAkWrGsZVql4zP8qPfbpQzCGPt+VQwsTAKo++pXluVHaM7Ko21Dzs88IYiBpGhN
        1daWGwiJUmK7V+PQYjUBQDw9nrtaVr49CCsaidfq2lbbqxcNdVCELghvgZ+7e3NgMB5RAT
        41VIEGaMA1ZcXm5jt7MvTcWP+ywuAb0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-GzyFOmaKPISWxEIwyLJZVw-1; Sun, 19 Jun 2022 20:25:00 -0400
X-MC-Unique: GzyFOmaKPISWxEIwyLJZVw-1
Received: by mail-qv1-f72.google.com with SMTP id jt10-20020a05621427ea00b0046e41613270so10380487qvb.5
        for <linux-wpan@vger.kernel.org>; Sun, 19 Jun 2022 17:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=US7qenfy4xTqnJqJ4FXH2SXINmqQKvIojVigmxTRfwY=;
        b=HhhdC30f+SxJp+esrI3+sxcKE/OnxBMMSdqg6fnjmUnqleTOtGVvzlztGkBa4e1ynK
         agCgvebyv4VEBxA4a01OzaXRYqlqsgP83SaMP9NRGWFRGg+ItP6EYjo7FQxRwf50XaJ5
         1jSMwrL7pJxI4wUrcSXoLdoVNw5BFne4xH00Xfik3WNX6BCMQX/jp1/XYpWeZ+sKZXEZ
         Q8hhRBWP+TzBBHg7D7wVYO5Uoks5GEq0y2m6hZ36bkjXU/hTmU9aPHT6wFpU3pTLKUL3
         p4Qc3ICBL4ym/dfKWHbflAbm+bLWtfEz4Tb8E8ep5pzX5c/2OL/Nv8JgmFBE3iiuUImL
         l7Ow==
X-Gm-Message-State: AJIora9jm4owm1lKSPzlMGO8yO0lMnR1qw5kTcOd33EQY9qTYEd1KYr8
        JqGdxsw6sHtw7p51qpR8kY4R7KUptX0vZuyJoIqbtwgnVWrm2gFIFoKi9HH6Ho18BuZnGKdUXWY
        jbE+YX4i6oewR3CwfDyAUh/IQ527mJ35aPoEF/A==
X-Received: by 2002:ac8:5dd2:0:b0:304:ea09:4688 with SMTP id e18-20020ac85dd2000000b00304ea094688mr18078098qtx.526.1655684699897;
        Sun, 19 Jun 2022 17:24:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v/kJVYb5JelpoZw9BhE31t8P/bFnXcZc6jqa4YRq6VQHrBY7W7uK1bYHZE6SmiWKKJhfLkWdAVk9UE9dYDKMs=
X-Received: by 2002:ac8:5dd2:0:b0:304:ea09:4688 with SMTP id
 e18-20020ac85dd2000000b00304ea094688mr18078094qtx.526.1655684699722; Sun, 19
 Jun 2022 17:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220617193254.1275912-1-miquel.raynal@bootlin.com> <20220617193254.1275912-3-miquel.raynal@bootlin.com>
In-Reply-To: <20220617193254.1275912-3-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 19 Jun 2022 20:24:48 -0400
Message-ID: <CAK-6q+iJaZvtxXsFTPsYyWsDYmKhgVsMHKcDUCrCqmUR2YpEjg@mail.gmail.com>
Subject: Re: [PATCH wpan-next v2 2/6] net: ieee802154: Ensure only FFDs can
 become PAN coordinators
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

On Fri, Jun 17, 2022 at 3:35 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> This is a limitation clearly listed in the specification. Now that we
> have device types,let's ensure that only FFDs can become PAN
> coordinators.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  net/ieee802154/nl802154.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
> index 638bf544f102..0c6fc3385320 100644
> --- a/net/ieee802154/nl802154.c
> +++ b/net/ieee802154/nl802154.c
> @@ -924,6 +924,9 @@ static int nl802154_new_interface(struct sk_buff *skb, struct genl_info *info)
>                         return -EINVAL;
>         }
>
> +       if (type == NL802154_IFTYPE_COORD && !cfg802154_is_ffd(rdev))
> +               return -EINVAL;
> +

Look at my other mail regarding why the user needs to set this device
capability, change the errno to "EOPNOTSUPP"... it would be nice to
have an identically nl80211 handling like nl80211 to see which
interfaces are supported. Please look how wireless is doing that and
probably we should not take the standard about those "wording" too
seriously. What I mean is that according to FFD or RFD it's implied on
what interfaces you can create on.

- Alex

