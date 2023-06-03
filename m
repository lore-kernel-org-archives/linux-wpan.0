Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867E2C77B73
	for <linux-wpan@archiver.kernel.org>; Sat,  3 Jun 2023 11:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjFCL3a (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 3 Jun 2023 07:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjFCL33 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 3 Jun 2023 07:29:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0F0180
        for <linux-wpan@vger.kernel.org>; Sat,  3 Jun 2023 04:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685791721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qc19+AkncC4nxIEryKXqxdYJw3SDpS86Yjih3aznMXw=;
        b=LXU6xiuDWKmP6Q5KmNExh51Vax4CUQrvYdsOhlJjfvbFICLpSyyegiCZatrj2M1lVTBEFS
        qM7AUXy3VZIL0eBaNRMYINCMMb+tzCDwS2Hp+bXyedlE02M9ouaHVSSWvucNC7YYIZ/M/c
        yRBup7iTfHU+5N3smg2q3/fQCx+rvKA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-U-JRRgNzPVCCKLZD4vnCyQ-1; Sat, 03 Jun 2023 07:28:40 -0400
X-MC-Unique: U-JRRgNzPVCCKLZD4vnCyQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-974566553ccso170643966b.3
        for <linux-wpan@vger.kernel.org>; Sat, 03 Jun 2023 04:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685791717; x=1688383717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qc19+AkncC4nxIEryKXqxdYJw3SDpS86Yjih3aznMXw=;
        b=TFnJ7YS0xEVwYuXpflhBWp5tScjA8B/YpCKpBULj+R0uBgnZNdM/EgejOnfBgq8+uy
         w0PC9oC33yQ6/t1VyuyleKo2FbOWsod+sErlckOtEjA0ZvPmmgeoPJtIabvgUPVsQKM8
         lhl6ZV0IdOkL+PVqszC0kKi/u2CVdVG5WIjfOZCDMXRKAgkv/WQ9U6A8bQMpdTgsn1gc
         af2eIDCU2qN0sMphjH9jZSTIKrZ6pAVwHXPutIbjs6tx3YX5ozGASCg3vg+x2EXROE7S
         IS2GOgxNSpsDHWh/gz4Up1z1F0+nmsrDKsI0ZQIngpjPKuwrAWDttDaN3M2m8suiPCge
         W3sw==
X-Gm-Message-State: AC+VfDyji3O9+GUYSR+fYATHObYwetMup9y2VhFQeFJbBYKRCTm8sYKW
        PVvjX4EUH5EPOey94xs+4ok2vckGExDwXyRUgWsfKibawrdcigZ0t9yBm748F+YReqTz5xzRIw0
        vrt9sis71POJsC6UxBDI4nvbhrln5Z1NmVMxB7clrjl7XFA==
X-Received: by 2002:a17:907:6e89:b0:974:218d:c048 with SMTP id sh9-20020a1709076e8900b00974218dc048mr1489945ejc.26.1685791716868;
        Sat, 03 Jun 2023 04:28:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7SFTJhxQKr8PLRQA8DsZIzwnYvrIUM2AN53X2Npmf940OE0B10h0eAoV6UnTTboVoRcZ8rso3+go5zTWvl5xk=
X-Received: by 2002:a17:907:6e89:b0:974:218d:c048 with SMTP id
 sh9-20020a1709076e8900b00974218dc048mr1489927ejc.26.1685791716527; Sat, 03
 Jun 2023 04:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230601154817.754519-1-miquel.raynal@bootlin.com> <20230601154817.754519-8-miquel.raynal@bootlin.com>
In-Reply-To: <20230601154817.754519-8-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sat, 3 Jun 2023 07:28:25 -0400
Message-ID: <CAK-6q+hWsLSy8vx_Hiwo0gRDYsW4Y7U=sQbAi5Na7BXQoOHWhw@mail.gmail.com>
Subject: Re: [PATCH wpan-next 07/11] mac802154: Handle association requests
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

On Thu, Jun 1, 2023 at 11:50=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
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
>  net/ieee802154/pan.c            |  27 ++++++
>  net/mac802154/ieee802154_i.h    |   2 +
>  net/mac802154/rx.c              |   8 ++
>  net/mac802154/scan.c            | 147 ++++++++++++++++++++++++++++++++
>  7 files changed, 204 insertions(+)
>
> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> index 01bc6c2da7b9..4404072365e7 100644
> --- a/include/net/cfg802154.h
> +++ b/include/net/cfg802154.h
> @@ -582,4 +582,11 @@ struct ieee802154_pan_device *
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
> index 8bf01bb7e858..39674db64336 100644
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
>         if (wpan_dev->parent)
>                 kfree(wpan_dev->parent);
>
> +       list_for_each_entry_safe(child, tmp, &wpan_dev->children, node) {
> +               list_del(&child->node);
> +               kfree(child);
> +       }
> +
>         wpan_dev->association_generation++;
>
>         mutex_unlock(&wpan_dev->association_lock);
> diff --git a/net/ieee802154/pan.c b/net/ieee802154/pan.c
> index 477e8dad0cf0..7756906c201d 100644
> --- a/net/ieee802154/pan.c
> +++ b/net/ieee802154/pan.c
> @@ -66,3 +66,30 @@ cfg802154_device_is_child(struct wpan_dev *wpan_dev,
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

This is combined with the max associations setting? I am not sure if
this is the best way to get free values from a u16 value where we have
some data structure of "given" addresses to a node. I recently was
looking into idr/xarray data structure... maybe we can use something
from there.

- Alex

