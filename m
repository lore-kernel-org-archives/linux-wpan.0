Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE69BCE7A8B
	for <linux-wpan@archiver.kernel.org>; Mon, 25 Sep 2023 00:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjIYAOu (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 24 Sep 2023 20:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjIYAOu (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 24 Sep 2023 20:14:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D596EE
        for <linux-wpan@vger.kernel.org>; Sun, 24 Sep 2023 17:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695600828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OMlOLa6ObmfEOQEX2Js7Va9aoundLiMoHyRwUwKVIKU=;
        b=RYt3GcRvhfzgvqJhPR3cR5db1Gz9+yZPXJc/M4U8wk7FzWKCTyJ1/oKJb098RjCyfxoOve
        I3P7F1tVp2bQI+z9Duunwk9h7uc5EWEUNVU8RVArHrxcB73Y4KmoXxwfRecpfYvREHk9xA
        oyZ2+7kHF2EXoo3KOHkiWe4pGxqjx8A=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-BT3UXHhFOEO-AyEqJLM12A-1; Sun, 24 Sep 2023 20:13:46 -0400
X-MC-Unique: BT3UXHhFOEO-AyEqJLM12A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9b274cc9636so119460666b.0
        for <linux-wpan@vger.kernel.org>; Sun, 24 Sep 2023 17:13:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695600826; x=1696205626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMlOLa6ObmfEOQEX2Js7Va9aoundLiMoHyRwUwKVIKU=;
        b=LlQQHLtAQ3CDmjEvdmd4kcy08MfuTKxTK/ggSAOKkaBbHBax86WXlMfEVD9gZ+ez3F
         BX2XvveGC6MrF08CsxtEmiUT2xIBXr4gYeupsH4tb6d2g1rT9/ikwy74pE9BJX7BPnUk
         4inUc155rswFJiuRP0oMU4ckYRSkwfnL0SlBpxERqUGINVxh1J3AsB99nAr+UyKp/J5M
         1ajJtCkamg1lbdfUC93Dr14Lt/tImfHQPM1BOq9bcJiXFFEbdOPjvb439B/xXUEIt12g
         jW1ACwmJjZIAWAJTTCDQ+VLxe4xIfkUh54KidfNYKfE0xfUM30xT0iGUgzvKTAtxBuQY
         uehg==
X-Gm-Message-State: AOJu0YwLNJwneItIFwTgk8ViiXXQXkcl9McbP0JnIQy9xuloHkDEKK6t
        3NPP/pywIuDYBoSiql33eRJabyqqk5FgNDo8mR6+YoRSWF3trgnr5i1fX+TDtIvqx01QDNZWZAt
        h3C881Ze4n+1RXv0qIx2h/Ct23kxNeSXED1v8Dw==
X-Received: by 2002:a17:906:76c5:b0:9ae:654d:510e with SMTP id q5-20020a17090676c500b009ae654d510emr4319985ejn.5.1695600825814;
        Sun, 24 Sep 2023 17:13:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpgQRdicbeBTmy5R5/eHMbIhCTQW6hjTqqLcBnCdXH2ufH1wmQB+VJTpctj35EDRCcZBY4GvkMFZUFj3kacbw=
X-Received: by 2002:a17:906:76c5:b0:9ae:654d:510e with SMTP id
 q5-20020a17090676c500b009ae654d510emr4319974ejn.5.1695600825530; Sun, 24 Sep
 2023 17:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230922155029.592018-1-miquel.raynal@bootlin.com> <20230922155029.592018-8-miquel.raynal@bootlin.com>
In-Reply-To: <20230922155029.592018-8-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 24 Sep 2023 20:13:34 -0400
Message-ID: <CAK-6q+iTOapHF7ftqtRQBsNUYEKqjS0Mkq4O-A2C2tbupStk0A@mail.gmail.com>
Subject: Re: [PATCH wpan-next v4 07/11] mac802154: Handle association requests
 from peers
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Fri, Sep 22, 2023 at 11:51=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Coordinators may have to handle association requests from peers which
> want to join the PAN. The logic involves:
> - Acknowledging the request (done by hardware)
> - If requested, a random short address that is free on this PAN should
>   be chosen for the device.
> - Sending an association response with the short address allocated for
>   the peer and expecting it to be ack'ed.
>
> If anything fails during this procedure, the peer is considered not
> associated.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  include/net/cfg802154.h         |   7 ++
>  include/net/ieee802154_netdev.h |   6 ++
>  net/ieee802154/core.c           |   7 ++
>  net/ieee802154/pan.c            |  30 +++++++
>  net/mac802154/ieee802154_i.h    |   2 +
>  net/mac802154/rx.c              |   8 ++
>  net/mac802154/scan.c            | 142 ++++++++++++++++++++++++++++++++
>  7 files changed, 202 insertions(+)
>
> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> index 9b036ab20079..c844ae63bc04 100644
> --- a/include/net/cfg802154.h
> +++ b/include/net/cfg802154.h
> @@ -583,4 +583,11 @@ struct ieee802154_pan_device *
>  cfg802154_device_is_child(struct wpan_dev *wpan_dev,
>                           struct ieee802154_addr *target);
>
> +/**
> + * cfg802154_get_free_short_addr - Get a free address among the known de=
vices
> + * @wpan_dev: the wpan device
> + * @return: a random short address expectedly unused on our PAN
> + */
> +__le16 cfg802154_get_free_short_addr(struct wpan_dev *wpan_dev);
> +
>  #endif /* __NET_CFG802154_H */
> diff --git a/include/net/ieee802154_netdev.h b/include/net/ieee802154_net=
dev.h
> index 16194356cfe7..4de858f9929e 100644
> --- a/include/net/ieee802154_netdev.h
> +++ b/include/net/ieee802154_netdev.h
> @@ -211,6 +211,12 @@ struct ieee802154_association_req_frame {
>         struct ieee802154_assoc_req_pl assoc_req_pl;
>  };
>
> +struct ieee802154_association_resp_frame {
> +       struct ieee802154_hdr mhr;
> +       struct ieee802154_mac_cmd_pl mac_pl;
> +       struct ieee802154_assoc_resp_pl assoc_resp_pl;
> +};
> +
>  struct ieee802154_disassociation_notif_frame {
>         struct ieee802154_hdr mhr;
>         struct ieee802154_mac_cmd_pl mac_pl;
> diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
> index a08d75dd56ad..1670a71327a7 100644
> --- a/net/ieee802154/core.c
> +++ b/net/ieee802154/core.c
> @@ -200,11 +200,18 @@ EXPORT_SYMBOL(wpan_phy_free);
>
>  static void cfg802154_free_peer_structures(struct wpan_dev *wpan_dev)
>  {
> +       struct ieee802154_pan_device *child, *tmp;
> +
>         mutex_lock(&wpan_dev->association_lock);
>
>         kfree(wpan_dev->parent);
>         wpan_dev->parent =3D NULL;
>
> +       list_for_each_entry_safe(child, tmp, &wpan_dev->children, node) {
> +               list_del(&child->node);
> +               kfree(child);
> +       }
> +
>         mutex_unlock(&wpan_dev->association_lock);
>  }
>
> diff --git a/net/ieee802154/pan.c b/net/ieee802154/pan.c
> index 9e1f1973c294..e99c64054dcb 100644
> --- a/net/ieee802154/pan.c
> +++ b/net/ieee802154/pan.c
> @@ -73,3 +73,33 @@ cfg802154_device_is_child(struct wpan_dev *wpan_dev,
>         return NULL;
>  }
>  EXPORT_SYMBOL_GPL(cfg802154_device_is_child);
> +
> +__le16 cfg802154_get_free_short_addr(struct wpan_dev *wpan_dev)
> +{
> +       struct ieee802154_pan_device *child;
> +       __le16 addr;
> +
> +       lockdep_assert_held(&wpan_dev->association_lock);
> +
> +       do {
> +               get_random_bytes(&addr, 2);
> +               if (addr =3D=3D cpu_to_le16(IEEE802154_ADDR_SHORT_BROADCA=
ST) ||
> +                   addr =3D=3D cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC)=
)
> +                       continue;
> +
> +               if (wpan_dev->short_addr =3D=3D addr)
> +                       continue;
> +
> +               if (wpan_dev->parent && wpan_dev->parent->short_addr =3D=
=3D addr)
> +                       continue;
> +
> +               list_for_each_entry(child, &wpan_dev->children, node)
> +                       if (child->short_addr =3D=3D addr)
> +                               continue;
> +
> +               break;
> +       } while (1);
> +

I still believe that this random 2 bytes and check if it's already
being used is wrong here. We need something to use the next free
available number according to the data we are storing here.

However it is acceptable and can be changed later...

- Alex

