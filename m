Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D09ECAAD5
	for <linux-wpan@archiver.kernel.org>; Mon, 29 Aug 2022 00:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiH2AQh (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 28 Aug 2022 20:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiH2AQg (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 28 Aug 2022 20:16:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE552A96F
        for <linux-wpan@vger.kernel.org>; Sun, 28 Aug 2022 17:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661732193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SzkAkorlo+AmttOHZ6iqjGEde1HkM0doNAcGjEIWZ4o=;
        b=UgpOLiMhLm2QiGP+kik5FokYWZQ1uJ1WpQDfo48pGtywOBFSlIoE9dSHfe5MF7kkMQBTHX
        mD8j5H9RhR3KCERfymdZbohYQHYfd8MsmnsTQVkKzepZL71wJM4zEVLwtiGWSHDf7lt+7L
        2ADqL+jG9ZdD+Oa/6IcqDLgNdfo5xJY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-39-7D7plrk1PWycyVS6SC70EA-1; Sun, 28 Aug 2022 20:16:31 -0400
X-MC-Unique: 7D7plrk1PWycyVS6SC70EA-1
Received: by mail-qv1-f70.google.com with SMTP id dn8-20020a056214094800b00498f685a1b3so2043590qvb.6
        for <linux-wpan@vger.kernel.org>; Sun, 28 Aug 2022 17:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=SzkAkorlo+AmttOHZ6iqjGEde1HkM0doNAcGjEIWZ4o=;
        b=J7Rj7p854OsOFu8iLXYr9C2MaWN+4cPyAdeebH+ruANOYmBpF8DFWEFegdJGByzYux
         kIBKPYNkVq9UrRjmbC6hMPeHQQ8ys3+NCFgUlqxIkXakgo5rcA2FrEYtD9/CX5pOXLxB
         nnGNb1hMhbSFAOzIvwZKGAWyZyI5/wkkbMHkjcXccunFBvP4BBeS92n8rtf0Og4wd1kP
         4+c6h4ukSP3kcgtERPu+SP0eM5OjyEVT6n4P/uyjcpq1wrbwutiLTJ9JdTfAdifvkcpa
         vRnZzbVBQ2gR07I32qID7VbDkSQoDiuewiSo8KZUToqccQKt4QUPEo66IgFUyM+nu+4o
         fRPw==
X-Gm-Message-State: ACgBeo2iPJm44tsHChDhkPGogcwB0P1YZYUpfuFhvn2VbyMc8X1pLrJi
        RRQrl0aJ6sBaxv4uaJ0YN4M9rTQ3OfeEHa+Ht9BB5GrzKND8nmubIwe5bbCvhW2/9auIb8JqSi+
        uy53JbFxxCSHugRvQkjpcCYqsWTX/wcL0EPOcEA==
X-Received: by 2002:a05:622a:1302:b0:344:8a9d:817d with SMTP id v2-20020a05622a130200b003448a9d817dmr8364117qtk.339.1661732191501;
        Sun, 28 Aug 2022 17:16:31 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6YH2nJIo0b6SviiSUMGBKXXeJaHL95jdsa0u6iUg5nlt6EWo3hqWiTPzDu5EZVS+GBLuTCvNVZOaiGzM0z1Ys=
X-Received: by 2002:a05:622a:1302:b0:344:8a9d:817d with SMTP id
 v2-20020a05622a130200b003448a9d817dmr8364092qtk.339.1661732191317; Sun, 28
 Aug 2022 17:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220826142954.254853-1-miquel.raynal@bootlin.com>
In-Reply-To: <20220826142954.254853-1-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 28 Aug 2022 20:16:20 -0400
Message-ID: <CAK-6q+imPjpBxSZG7e5nxYYgtkrM5pfncxza9=vA+sq+eFQsUw@mail.gmail.com>
Subject: Re: [PATCH] net: mac802154: Fix a condition in the receive path
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Fri, Aug 26, 2022 at 10:31 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Upon reception, a packet must be categorized, either it's destination is
> the host, or it is another host. A packet with no destination addressing
> fields may be valid in two situations:
> - the packet has no source field: only ACKs are built like that, we
>   consider the host as the destination.
> - the packet has a valid source field: it is directed to the PAN
>   coordinator, as for know we don't have this information we consider we
>   are not the PAN coordinator.
>
> There was likely a copy/paste error made during a previous cleanup
> because the if clause is now containing exactly the same condition as in
> the switch case, which can never be true. In the past the destination
> address was used in the switch and the source address was used in the
> if, which matches what the spec says.
>
> Cc: stable@vger.kernel.org
> Fixes: ae531b9475f6 ("ieee802154: use ieee802154_addr instead of *_sa variants")
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  net/mac802154/rx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
> index b8ce84618a55..c439125ef2b9 100644
> --- a/net/mac802154/rx.c
> +++ b/net/mac802154/rx.c
> @@ -44,7 +44,7 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
>
>         switch (mac_cb(skb)->dest.mode) {
>         case IEEE802154_ADDR_NONE:
> -               if (mac_cb(skb)->dest.mode != IEEE802154_ADDR_NONE)
> +               if (hdr->source.mode != IEEE802154_ADDR_NONE)
>                         /* FIXME: check if we are PAN coordinator */
>                         skb->pkt_type = PACKET_OTHERHOST;
>                 else


This patch looks okay but it should not be addressed to stable. Leave
of course the fixes tag.

Wpan sends pull requests to net and they have their own way to get
into the stable tree when they are in net.

Thanks.

- Alex

