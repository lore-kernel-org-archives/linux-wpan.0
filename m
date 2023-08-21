Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21250EE4996
	for <linux-wpan@archiver.kernel.org>; Mon, 21 Aug 2023 08:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbjHUIxJ (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 21 Aug 2023 04:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjHUIxI (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Aug 2023 04:53:08 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB511BB;
        Mon, 21 Aug 2023 01:53:06 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E45E71BF212;
        Mon, 21 Aug 2023 08:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692607985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2u3cwdVeZNhkOv9TOWa0j73za+v+76Zl0BGUHMHrVGY=;
        b=Pw6nSFfdiOisSj+WMY5M3ZsEMgxPS6eI8NcjgqJFyD8ZOW/TclklJJI628KQ+02hU41BX/
        a22UYSqill8y0F7ygScE2M9RrCD1kiA8Wrf48+TEIm6hXxjVbt4wYb+3my0PhS30hOyXrd
        kagQ6ccVMC9ipD8C0DxkX3VYZa1iU55JYINksiVlZjuvz1L/ydBZqMIUNHQQGYXPipH5VP
        xRJ/qpqo/280+oFKdV/WqpW8GQVa+N9bFpBULsk+/0zWZsKYf7Bjjn0ekzZPQKiT4NhiqP
        QqSlJgVJt0s5aJ6+BDMNg0qJh6tCsoDowgZyKBPiyZ/CEDldoaq2fBbZYQbLTQ==
Date:   Mon, 21 Aug 2023 10:52:59 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <aahringo@redhat.com>
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
Subject: Re: [PATCH wpan-next 07/11] mac802154: Handle association requests
 from peers
Message-ID: <20230821105259.4659dd74@xps-13>
In-Reply-To: <CAK-6q+hWsLSy8vx_Hiwo0gRDYsW4Y7U=sQbAi5Na7BXQoOHWhw@mail.gmail.com>
References: <20230601154817.754519-1-miquel.raynal@bootlin.com>
 <20230601154817.754519-8-miquel.raynal@bootlin.com>
 <CAK-6q+hWsLSy8vx_Hiwo0gRDYsW4Y7U=sQbAi5Na7BXQoOHWhw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Alexander,

aahringo@redhat.com wrote on Sat, 3 Jun 2023 07:28:25 -0400:

> Hi,
>=20
> On Thu, Jun 1, 2023 at 11:50=E2=80=AFAM Miquel Raynal <miquel.raynal@boot=
lin.com> wrote:
> >
> > Coordinators may have to handle association requests from peers which
> > want to join the PAN. The logic involves:
> > - Acknowledging the request (done by hardware)
> > - If requested, a random short address that is free on this PAN should
> >   be chosen for the device.
> > - Sending an association response with the short address allocated for
> >   the peer and expecting it to be ack'ed.
> >
> > If anything fails during this procedure, the peer is considered not
> > associated.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  include/net/cfg802154.h         |   7 ++
> >  include/net/ieee802154_netdev.h |   6 ++
> >  net/ieee802154/core.c           |   7 ++
> >  net/ieee802154/pan.c            |  27 ++++++
> >  net/mac802154/ieee802154_i.h    |   2 +
> >  net/mac802154/rx.c              |   8 ++
> >  net/mac802154/scan.c            | 147 ++++++++++++++++++++++++++++++++
> >  7 files changed, 204 insertions(+)
> >
> > diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> > index 01bc6c2da7b9..4404072365e7 100644
> > --- a/include/net/cfg802154.h
> > +++ b/include/net/cfg802154.h
> > @@ -582,4 +582,11 @@ struct ieee802154_pan_device *
> >  cfg802154_device_is_child(struct wpan_dev *wpan_dev,
> >                           struct ieee802154_addr *target);
> >
> > +/**
> > + * cfg802154_get_free_short_addr - Get a free address among the known =
devices
> > + * @wpan_dev: the wpan device
> > + * @return: a random short address expectedly unused on our PAN
> > + */
> > +__le16 cfg802154_get_free_short_addr(struct wpan_dev *wpan_dev);
> > +
> >  #endif /* __NET_CFG802154_H */
> > diff --git a/include/net/ieee802154_netdev.h b/include/net/ieee802154_n=
etdev.h
> > index 16194356cfe7..4de858f9929e 100644
> > --- a/include/net/ieee802154_netdev.h
> > +++ b/include/net/ieee802154_netdev.h
> > @@ -211,6 +211,12 @@ struct ieee802154_association_req_frame {
> >         struct ieee802154_assoc_req_pl assoc_req_pl;
> >  };
> >
> > +struct ieee802154_association_resp_frame {
> > +       struct ieee802154_hdr mhr;
> > +       struct ieee802154_mac_cmd_pl mac_pl;
> > +       struct ieee802154_assoc_resp_pl assoc_resp_pl;
> > +};
> > +
> >  struct ieee802154_disassociation_notif_frame {
> >         struct ieee802154_hdr mhr;
> >         struct ieee802154_mac_cmd_pl mac_pl;
> > diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
> > index 8bf01bb7e858..39674db64336 100644
> > --- a/net/ieee802154/core.c
> > +++ b/net/ieee802154/core.c
> > @@ -200,11 +200,18 @@ EXPORT_SYMBOL(wpan_phy_free);
> >
> >  static void cfg802154_free_peer_structures(struct wpan_dev *wpan_dev)
> >  {
> > +       struct ieee802154_pan_device *child, *tmp;
> > +
> >         mutex_lock(&wpan_dev->association_lock);
> >
> >         if (wpan_dev->parent)
> >                 kfree(wpan_dev->parent);
> >
> > +       list_for_each_entry_safe(child, tmp, &wpan_dev->children, node)=
 {
> > +               list_del(&child->node);
> > +               kfree(child);
> > +       }
> > +
> >         wpan_dev->association_generation++;
> >
> >         mutex_unlock(&wpan_dev->association_lock);
> > diff --git a/net/ieee802154/pan.c b/net/ieee802154/pan.c
> > index 477e8dad0cf0..7756906c201d 100644
> > --- a/net/ieee802154/pan.c
> > +++ b/net/ieee802154/pan.c
> > @@ -66,3 +66,30 @@ cfg802154_device_is_child(struct wpan_dev *wpan_dev,
> >         return NULL;
> >  }
> >  EXPORT_SYMBOL_GPL(cfg802154_device_is_child);
> > +
> > +__le16 cfg802154_get_free_short_addr(struct wpan_dev *wpan_dev)
> > +{
> > +       struct ieee802154_pan_device *child;
> > +       __le16 addr;
> > +
> > +       lockdep_assert_held(&wpan_dev->association_lock);
> > +
> > +       do {
> > +               get_random_bytes(&addr, 2); =20
>=20
> This is combined with the max associations setting? I am not sure if
> this is the best way to get free values from a u16 value where we have
> some data structure of "given" addresses to a node. I recently was
> looking into idr/xarray data structure... maybe we can use something
> from there.

I actually thought about using an increasing index, but the pseudo
random generator seemed appropriate because of its "unpredictability",
but there is not real use for that (besides maybe testing purposes). I
can definitely switch to another solution.

Thanks,
Miqu=C3=A8l
