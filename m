Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5944DCD37B3
	for <linux-wpan@archiver.kernel.org>; Sun, 17 Sep 2023 11:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbjIQLwe (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 17 Sep 2023 07:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjIQLwC (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 17 Sep 2023 07:52:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70979F7
        for <linux-wpan@vger.kernel.org>; Sun, 17 Sep 2023 04:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694951470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KTAUl3MxkxMzRLvthhHrinXr0DGTE9HMQ6lKXfM/moc=;
        b=gvkfN/1HOnouuQCQKmBeccrRPypENrUe9wWC9JlPJJK/NrUbd9/J7Z6IrVEf7zrwNXdrh2
        r7Z356l2sNKvqfIG783lQYrAreBmuQb33YevzQeP91s0YkGGv05XVtod/mMqfx1rs3B6JA
        UKyEXUFNCvdfYYEm9UCYozGUoVwX5N0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-tAwv6k-GOu6V2a21iWpUtQ-1; Sun, 17 Sep 2023 07:51:09 -0400
X-MC-Unique: tAwv6k-GOu6V2a21iWpUtQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-502aafb8ae7so4090964e87.1
        for <linux-wpan@vger.kernel.org>; Sun, 17 Sep 2023 04:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694951467; x=1695556267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTAUl3MxkxMzRLvthhHrinXr0DGTE9HMQ6lKXfM/moc=;
        b=oJv/btxP6XGyAjvlfX3+zzNDyjk8EkaKy3H3Qoh4nO4zhPw9nodsanxyD/uYAg/O2Z
         3TBTSlNcd1ZvnU3w/z8mC3CnTLINYTMlXgP67H2Da+hD5R8QnyQS8qCuei8Ro0iBk9MI
         mZg/QPa4ygNXMVsVCDq5lOuBOaNExsYl0U311wdOfUCPiVMxcknciXEHJJsWF/fHrAJ1
         Z3wf7ZoI1vuXxB23zAhyoyTr2BD7qRqj8j9P+/uiydLe8HV4LBz9t+dmGoMOxXtLA7Hy
         x7Hn9tspPT7ZNd/X3auK5kFuOHfRZHD/xoxfIg0Jq+UmbV5pjD1IsO+TBJh8+U9mpIsu
         Myag==
X-Gm-Message-State: AOJu0Yz30mQm2Wn6BgARBVC1Jh1lpZTU/ssde95WI4mKgE3MEicumoOi
        8yIBeJPzL1abAI4ejeqTKOhCYKd69eNb6hz92B5QKgrq6LlC2YxaGqB20y1gmAUh7+zsCtrfVYO
        N6TZ9OTATE8RHV96kMEMY/wgJ7WIeox1zuavvMA==
X-Received: by 2002:a05:651c:1207:b0:2bf:aba1:d951 with SMTP id i7-20020a05651c120700b002bfaba1d951mr5787698lja.10.1694951467673;
        Sun, 17 Sep 2023 04:51:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvgcuYUeeQvN/TE5OihHoj0Rk8IsxlIiUoWPObpauFRACf4R2FjwLvQlFysf8xsyCHxXvl5ifRFwbsI/vJNr4=
X-Received: by 2002:a05:651c:1207:b0:2bf:aba1:d951 with SMTP id
 i7-20020a05651c120700b002bfaba1d951mr5787689lja.10.1694951467323; Sun, 17 Sep
 2023 04:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230901170501.1066321-1-miquel.raynal@bootlin.com>
 <20230901170501.1066321-3-miquel.raynal@bootlin.com> <32cfbf0f-7ac8-5a4c-d9cd-9650a64fc0ea@datenfreihafen.org>
In-Reply-To: <32cfbf0f-7ac8-5a4c-d9cd-9650a64fc0ea@datenfreihafen.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 17 Sep 2023 07:50:55 -0400
Message-ID: <CAK-6q+h1rbG+6=M+ZZfUznHq9GxOwtA1i0c=C9dgQH1qC7sQ=A@mail.gmail.com>
Subject: Re: [PATCH wpan-next v2 02/11] ieee802154: Internal PAN management
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Alexander Aring <alex.aring@gmail.com>,
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

On Sat, Sep 16, 2023 at 11:39=E2=80=AFAM Stefan Schmidt
<stefan@datenfreihafen.org> wrote:
>
> Hello Miquel.
>
> On 01.09.23 19:04, Miquel Raynal wrote:
> > Introduce structures to describe peer devices in a PAN as well as a few
> > related helpers. We basically care about:
> > - Our unique parent after associating with a coordinator.
> > - Peer devices, children, which successfully associated with us.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >   include/net/cfg802154.h | 46 ++++++++++++++++++++++++++++
> >   net/ieee802154/Makefile |  2 +-
> >   net/ieee802154/core.c   |  2 ++
> >   net/ieee802154/pan.c    | 66 ++++++++++++++++++++++++++++++++++++++++=
+
> >   4 files changed, 115 insertions(+), 1 deletion(-)
> >   create mode 100644 net/ieee802154/pan.c
> >
> > diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> > index f79ce133e51a..6c7193b4873c 100644
> > --- a/include/net/cfg802154.h
> > +++ b/include/net/cfg802154.h
> > @@ -303,6 +303,22 @@ struct ieee802154_coord_desc {
> >       bool gts_permit;
> >   };
> >
> > +/**
> > + * struct ieee802154_pan_device - PAN device information
> > + * @pan_id: the PAN ID of this device
> > + * @mode: the preferred mode to reach the device
> > + * @short_addr: the short address of this device
> > + * @extended_addr: the extended address of this device
> > + * @node: the list node
> > + */
> > +struct ieee802154_pan_device {
> > +     __le16 pan_id;
> > +     u8 mode;
> > +     __le16 short_addr;
> > +     __le64 extended_addr;
> > +     struct list_head node;
> > +};
> > +
> >   /**
> >    * struct cfg802154_scan_request - Scan request
> >    *
> > @@ -478,6 +494,11 @@ struct wpan_dev {
> >
> >       /* fallback for acknowledgment bit setting */
> >       bool ackreq;
> > +
> > +     /* Associations */
> > +     struct mutex association_lock;
> > +     struct ieee802154_pan_device *parent;
> > +     struct list_head children;
> >   };
> >
> >   #define to_phy(_dev)        container_of(_dev, struct wpan_phy, dev)
> > @@ -529,4 +550,29 @@ static inline const char *wpan_phy_name(struct wpa=
n_phy *phy)
> >   void ieee802154_configure_durations(struct wpan_phy *phy,
> >                                   unsigned int page, unsigned int chann=
el);
> >
> > +/**
> > + * cfg802154_device_is_associated - Checks whether we are associated t=
o any device
> > + * @wpan_dev: the wpan device
>
> Missing return value documentation.
>
> > + */
> > +bool cfg802154_device_is_associated(struct wpan_dev *wpan_dev);
> > +
> > +/**
> > + * cfg802154_device_is_parent - Checks if a device is our coordinator
> > + * @wpan_dev: the wpan device
> > + * @target: the expected parent
> > + * @return: true if @target is our coordinator
> > + */
> > +bool cfg802154_device_is_parent(struct wpan_dev *wpan_dev,
> > +                             struct ieee802154_addr *target);
> > +
> > +/**
> > + * cfg802154_device_is_child - Checks whether a device is associated t=
o us
> > + * @wpan_dev: the wpan device
> > + * @target: the expected child
> > + * @return: the PAN device
> > + */
> > +struct ieee802154_pan_device *
> > +cfg802154_device_is_child(struct wpan_dev *wpan_dev,
> > +                       struct ieee802154_addr *target);
> > +
> >   #endif /* __NET_CFG802154_H */
> > diff --git a/net/ieee802154/Makefile b/net/ieee802154/Makefile
> > index f05b7bdae2aa..7bce67673e83 100644
> > --- a/net/ieee802154/Makefile
> > +++ b/net/ieee802154/Makefile
> > @@ -4,7 +4,7 @@ obj-$(CONFIG_IEEE802154_SOCKET) +=3D ieee802154_socket.=
o
> >   obj-y +=3D 6lowpan/
> >
> >   ieee802154-y :=3D netlink.o nl-mac.o nl-phy.o nl_policy.o core.o \
> > -                header_ops.o sysfs.o nl802154.o trace.o
> > +                header_ops.o sysfs.o nl802154.o trace.o pan.o
> >   ieee802154_socket-y :=3D socket.o
> >
> >   CFLAGS_trace.o :=3D -I$(src)
> > diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
> > index 57546e07e06a..cd69bdbfd59f 100644
> > --- a/net/ieee802154/core.c
> > +++ b/net/ieee802154/core.c
> > @@ -276,6 +276,8 @@ static int cfg802154_netdev_notifier_call(struct no=
tifier_block *nb,
> >               wpan_dev->identifier =3D ++rdev->wpan_dev_id;
> >               list_add_rcu(&wpan_dev->list, &rdev->wpan_dev_list);
> >               rdev->devlist_generation++;
> > +             mutex_init(&wpan_dev->association_lock);
> > +             INIT_LIST_HEAD(&wpan_dev->children);
> >
> >               wpan_dev->netdev =3D dev;
> >               break;
> > diff --git a/net/ieee802154/pan.c b/net/ieee802154/pan.c
> > new file mode 100644
> > index 000000000000..e2a12a42ba2b
> > --- /dev/null
> > +++ b/net/ieee802154/pan.c
> > @@ -0,0 +1,66 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * IEEE 802.15.4 PAN management
> > + *
> > + * Copyright (C) 2021 Qorvo US, Inc
> > + * Authors:
> > + *   - David Girault <david.girault@qorvo.com>
> > + *   - Miquel Raynal <miquel.raynal@bootlin.com>
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <net/cfg802154.h>
> > +#include <net/af_ieee802154.h>
> > +
> > +static bool cfg802154_same_addr(struct ieee802154_pan_device *a,
> > +                             struct ieee802154_addr *b)
> > +{
> > +     if (!a || !b)
> > +             return false;
> > +
> > +     switch (b->mode) {
> > +     case IEEE802154_ADDR_SHORT:
> > +             return a->short_addr =3D=3D b->short_addr;
> > +     case IEEE802154_ADDR_LONG:
> > +             return a->extended_addr =3D=3D b->extended_addr;
> > +     default:
> > +             return false;
> > +     }
> > +}
>
> Don't we already have such a helper already?

There must also be a check on (a->mode !=3D b->mode) because short_addr
and extended_addr share memory in this struct.

We have something "similar" [0] to this with also checks on panid,
however it depends what Miquel tries to do here. I can imagine that we
extend the helper with an enum opt about what to compare.

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/include/net/ieee802154_netdev.h?h=3Dv6.6-rc1#n232

