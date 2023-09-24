Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4448CE7A8A
	for <linux-wpan@archiver.kernel.org>; Sun, 24 Sep 2023 20:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjIXUsM (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 24 Sep 2023 16:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXUsM (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 24 Sep 2023 16:48:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F845E8
        for <linux-wpan@vger.kernel.org>; Sun, 24 Sep 2023 13:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695588438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M/HIpjVFNRXmYmV7yH7GioIrF9AAXyM2hiNW+k+5Bgk=;
        b=PfesqWFeFl7eQ3XPGhN4swC5RJ6D2aoRVZEWYir/ZsmRdtSEzze74H2BOB1KfhVS16vkhN
        LIWcRZRJYND1J+i5wmExuGCG8UHvbluOYoWW8G8U2jxboAkylXo9lZWCnePkulaUMCaW0t
        itmMaYoM1hqp92eHyxKYlVokat/m2HI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-JB5uLBehOmi9p7nrVNqE0g-1; Sun, 24 Sep 2023 16:47:17 -0400
X-MC-Unique: JB5uLBehOmi9p7nrVNqE0g-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-532c1dfebe6so3587620a12.3
        for <linux-wpan@vger.kernel.org>; Sun, 24 Sep 2023 13:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695588436; x=1696193236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/HIpjVFNRXmYmV7yH7GioIrF9AAXyM2hiNW+k+5Bgk=;
        b=dVkuGYvf9HhjY/AKcHSumpGbFJl1n4fWcOazQA/v6Sz8pcTbxMziFaTHv5rtrT3YNQ
         u2Su6lDX7jjxXoTBs/wlws0GpkMpIiBDi7NvE9DVc7XTie7NqoWLaosAoTYziLS1P389
         yvHl+0L4i5ux9AIglivdFIPCiAKQ7XCvgNXFJE/GOFOCnEdn1BWEx9RbYXzJvEJMNFgG
         8ffbnq6jJXAyVH9b6i8jjT4gcysrYUvTUhqEKbdx96K+/OMcTA0VJ0GXcGbx8G4KEbnI
         P/XGHJkMkS/+NTsnNr/zXlI2cXdQrBuwXRSTNDx9ZeAqfVumjrN0FTqmZiihN+5W9idf
         GGIQ==
X-Gm-Message-State: AOJu0Yz9yMEyYYe7aVLV7ky7cGB4wfKDyzXOXdOU9ueW17TaPrbdLbHg
        n5pd7QEqRiV7vD8aXY+QJo/cr2cjO1Ig7XqVbMqytbkQyJuA3UvLcjn5/pYjx/xgKQ90KyBWLcO
        91TpRQSxL0wFH51MsBmYXpCJBj/cpnd7EsV/QiA==
X-Received: by 2002:a50:ee89:0:b0:522:27ea:58b with SMTP id f9-20020a50ee89000000b0052227ea058bmr4325740edr.39.1695588436475;
        Sun, 24 Sep 2023 13:47:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhn1ad6l/uGWMaFlCP7EaffXL4gtfKw2+dB8XbAD/gKtp0DTUTOMQmTk2SbCL53JF/MrAsZUV+GLBMqckxl1s=
X-Received: by 2002:a50:ee89:0:b0:522:27ea:58b with SMTP id
 f9-20020a50ee89000000b0052227ea058bmr4325730edr.39.1695588436213; Sun, 24 Sep
 2023 13:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230922155029.592018-1-miquel.raynal@bootlin.com> <20230922155029.592018-3-miquel.raynal@bootlin.com>
In-Reply-To: <20230922155029.592018-3-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 24 Sep 2023 16:47:05 -0400
Message-ID: <CAK-6q+h_03Gnb+kz3NgumcxS99TV=W_0de2TCLXAk4uPg5W7BA@mail.gmail.com>
Subject: Re: [PATCH wpan-next v4 02/11] ieee802154: Internal PAN management
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

On Fri, Sep 22, 2023 at 11:50=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Introduce structures to describe peer devices in a PAN as well as a few
> related helpers. We basically care about:
> - Our unique parent after associating with a coordinator.
> - Peer devices, children, which successfully associated with us.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  include/net/cfg802154.h | 47 ++++++++++++++++++++++++++
>  net/ieee802154/Makefile |  2 +-
>  net/ieee802154/core.c   |  2 ++
>  net/ieee802154/pan.c    | 73 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 123 insertions(+), 1 deletion(-)
>  create mode 100644 net/ieee802154/pan.c
>
> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> index f79ce133e51a..a89f1c9cea3f 100644
> --- a/include/net/cfg802154.h
> +++ b/include/net/cfg802154.h
> @@ -303,6 +303,22 @@ struct ieee802154_coord_desc {
>         bool gts_permit;
>  };
>
> +/**
> + * struct ieee802154_pan_device - PAN device information
> + * @pan_id: the PAN ID of this device
> + * @mode: the preferred mode to reach the device
> + * @short_addr: the short address of this device
> + * @extended_addr: the extended address of this device
> + * @node: the list node
> + */
> +struct ieee802154_pan_device {
> +       __le16 pan_id;
> +       u8 mode;
> +       __le16 short_addr;
> +       __le64 extended_addr;
> +       struct list_head node;
> +};
> +
>  /**
>   * struct cfg802154_scan_request - Scan request
>   *
> @@ -478,6 +494,11 @@ struct wpan_dev {
>
>         /* fallback for acknowledgment bit setting */
>         bool ackreq;
> +
> +       /* Associations */
> +       struct mutex association_lock;
> +       struct ieee802154_pan_device *parent;
> +       struct list_head children;
>  };
>
>  #define to_phy(_dev)   container_of(_dev, struct wpan_phy, dev)
> @@ -529,4 +550,30 @@ static inline const char *wpan_phy_name(struct wpan_=
phy *phy)
>  void ieee802154_configure_durations(struct wpan_phy *phy,
>                                     unsigned int page, unsigned int chann=
el);
>
> +/**
> + * cfg802154_device_is_associated - Checks whether we are associated to =
any device
> + * @wpan_dev: the wpan device
> + * @return: true if we are associated
> + */
> +bool cfg802154_device_is_associated(struct wpan_dev *wpan_dev);
> +
> +/**
> + * cfg802154_device_is_parent - Checks if a device is our coordinator
> + * @wpan_dev: the wpan device
> + * @target: the expected parent
> + * @return: true if @target is our coordinator
> + */
> +bool cfg802154_device_is_parent(struct wpan_dev *wpan_dev,
> +                               struct ieee802154_addr *target);
> +
> +/**
> + * cfg802154_device_is_child - Checks whether a device is associated to =
us
> + * @wpan_dev: the wpan device
> + * @target: the expected child
> + * @return: the PAN device
> + */
> +struct ieee802154_pan_device *
> +cfg802154_device_is_child(struct wpan_dev *wpan_dev,
> +                         struct ieee802154_addr *target);
> +
>  #endif /* __NET_CFG802154_H */
> diff --git a/net/ieee802154/Makefile b/net/ieee802154/Makefile
> index f05b7bdae2aa..7bce67673e83 100644
> --- a/net/ieee802154/Makefile
> +++ b/net/ieee802154/Makefile
> @@ -4,7 +4,7 @@ obj-$(CONFIG_IEEE802154_SOCKET) +=3D ieee802154_socket.o
>  obj-y +=3D 6lowpan/
>
>  ieee802154-y :=3D netlink.o nl-mac.o nl-phy.o nl_policy.o core.o \
> -                header_ops.o sysfs.o nl802154.o trace.o
> +                header_ops.o sysfs.o nl802154.o trace.o pan.o
>  ieee802154_socket-y :=3D socket.o
>
>  CFLAGS_trace.o :=3D -I$(src)
> diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
> index 57546e07e06a..cd69bdbfd59f 100644
> --- a/net/ieee802154/core.c
> +++ b/net/ieee802154/core.c
> @@ -276,6 +276,8 @@ static int cfg802154_netdev_notifier_call(struct noti=
fier_block *nb,
>                 wpan_dev->identifier =3D ++rdev->wpan_dev_id;
>                 list_add_rcu(&wpan_dev->list, &rdev->wpan_dev_list);
>                 rdev->devlist_generation++;
> +               mutex_init(&wpan_dev->association_lock);
> +               INIT_LIST_HEAD(&wpan_dev->children);
>
>                 wpan_dev->netdev =3D dev;
>                 break;
> diff --git a/net/ieee802154/pan.c b/net/ieee802154/pan.c
> new file mode 100644
> index 000000000000..1677bb89c5ff
> --- /dev/null
> +++ b/net/ieee802154/pan.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * IEEE 802.15.4 PAN management
> + *
> + * Copyright (C) 2023 Qorvo US, Inc
> + * Authors:
> + *   - David Girault <david.girault@qorvo.com>
> + *   - Miquel Raynal <miquel.raynal@bootlin.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <net/cfg802154.h>
> +#include <net/af_ieee802154.h>
> +
> +/* Checks whether a device address matches one from the PAN list.
> + * This helper is meant to be used only during PAN management, when we e=
xpect
> + * extended addresses to be used.
> + */
> +static bool cfg802154_device_in_pan(struct ieee802154_pan_device *pan_de=
v,
> +                                   struct ieee802154_addr *ext_dev)
> +{
> +       if (!pan_dev || !ext_dev)
> +               return false;
> +
> +       if (ext_dev->mode =3D=3D IEEE802154_ADDR_SHORT)
> +               return false;
> +
> +       switch (ext_dev->mode) {
> +       case IEEE802154_ADDR_SHORT:
> +               return pan_dev->short_addr =3D=3D ext_dev->short_addr;

This is dead code now, it will never be reached, it's checked above
(Or I don't see it)? I want to help you here. What exactly do you try
to reach here again?

> +       case IEEE802154_ADDR_LONG:
> +               return pan_dev->extended_addr =3D=3D ext_dev->extended_ad=
dr;
> +       default:
> +               return false;
> +       }
> +}
> +
> +bool cfg802154_device_is_associated(struct wpan_dev *wpan_dev)
> +{
> +       bool is_assoc;
> +
> +       mutex_lock(&wpan_dev->association_lock);
> +       is_assoc =3D !list_empty(&wpan_dev->children) || wpan_dev->parent=
;
> +       mutex_unlock(&wpan_dev->association_lock);
> +
> +       return is_assoc;
> +}
> +
> +bool cfg802154_device_is_parent(struct wpan_dev *wpan_dev,
> +                               struct ieee802154_addr *target)
> +{
> +       lockdep_assert_held(&wpan_dev->association_lock);
> +
> +       if (cfg802154_device_in_pan(wpan_dev->parent, target))
> +               return true;
> +
> +       return false;

return cfg802154_device_in_pan(...); Why isn't checkpatch warning about tha=
t?

- Alex

