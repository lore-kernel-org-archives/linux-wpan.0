Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F4AEE6441
	for <linux-wpan@archiver.kernel.org>; Tue, 19 Sep 2023 07:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjISHO3 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 19 Sep 2023 03:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjISHO1 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Sep 2023 03:14:27 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F13102;
        Tue, 19 Sep 2023 00:14:20 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 480FE60003;
        Tue, 19 Sep 2023 07:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695107659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q/l6e1g7s+stIU++yB3rvtk24THhxw3ngPa5W19YaV0=;
        b=X4C/yxSC23VIzIuozz1ygE1Z25wRYmvqTiHDMKnlq1Wm/QiGMB5IJlymvQmZeRnflpNsm+
        thSAPtD16x0mhbdbxgHqrOAspQUMAUat64+uYTUcLC1V5s+tf0vQcvK4E9LJK0vd5OJ+jN
        bGwky8sxD9dHyl+uZqI6q0Izn6qhBpAHQrbIxHDslJJ+CBJ0ftcZRpOGBjS2SVWnh++6UD
        8u687IP6O0xBIFIxocHmbqSRlEtkdxuZXgwAh0+2CTIz2XdnJtA5oWZsX8Y2R0QBPI0Mvj
        ZoyP0eAfDM1CjGvIeIkFkXpdecOCHBlwp4TeARs2f872u65Oq1ZQ6xdheF6ERA==
Date:   Tue, 19 Sep 2023 09:14:15 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
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
Subject: Re: [PATCH wpan-next v2 02/11] ieee802154: Internal PAN management
Message-ID: <20230919091415.786a8200@xps-13>
In-Reply-To: <CAK-6q+g5d=LNfqTLpFTTPcscjHqoGGyUOtb+M9unTbE-Jpwxbg@mail.gmail.com>
References: <20230901170501.1066321-1-miquel.raynal@bootlin.com>
        <20230901170501.1066321-3-miquel.raynal@bootlin.com>
        <32cfbf0f-7ac8-5a4c-d9cd-9650a64fc0ea@datenfreihafen.org>
        <CAK-6q+h1rbG+6=M+ZZfUznHq9GxOwtA1i0c=C9dgQH1qC7sQ=A@mail.gmail.com>
        <20230918110102.19a43db1@xps-13>
        <CAK-6q+gcqr=Sgswgzd1pzMQoPEV1jG=_0m51+HsKU_=1b7NYUg@mail.gmail.com>
        <20230918161502.69818794@xps-13>
        <CAK-6q+g5d=LNfqTLpFTTPcscjHqoGGyUOtb+M9unTbE-Jpwxbg@mail.gmail.com>
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

aahringo@redhat.com wrote on Mon, 18 Sep 2023 19:01:14 -0400:

> Hi,
>=20
> On Mon, Sep 18, 2023 at 10:15=E2=80=AFAM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> >
> > Hi Alexander,
> >
> > =20
> > > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > > +/*
> > > > > > > + * IEEE 802.15.4 PAN management
> > > > > > > + *
> > > > > > > + * Copyright (C) 2021 Qorvo US, Inc
> > > > > > > + * Authors:
> > > > > > > + *   - David Girault <david.girault@qorvo.com>
> > > > > > > + *   - Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > > > + */
> > > > > > > +
> > > > > > > +#include <linux/kernel.h>
> > > > > > > +#include <net/cfg802154.h>
> > > > > > > +#include <net/af_ieee802154.h>
> > > > > > > +
> > > > > > > +static bool cfg802154_same_addr(struct ieee802154_pan_device=
 *a,
> > > > > > > +                             struct ieee802154_addr *b)
> > > > > > > +{
> > > > > > > +     if (!a || !b)
> > > > > > > +             return false;
> > > > > > > +
> > > > > > > +     switch (b->mode) {
> > > > > > > +     case IEEE802154_ADDR_SHORT:
> > > > > > > +             return a->short_addr =3D=3D b->short_addr;
> > > > > > > +     case IEEE802154_ADDR_LONG:
> > > > > > > +             return a->extended_addr =3D=3D b->extended_addr;
> > > > > > > +     default:
> > > > > > > +             return false;
> > > > > > > +     }
> > > > > > > +} =20
> > > > > >
> > > > > > Don't we already have such a helper already? =20
> > > > >
> > > > > There must also be a check on (a->mode !=3D b->mode) because shor=
t_addr
> > > > > and extended_addr share memory in this struct. =20
> > > >
> > > > True.
> > > >
> > > > Actually the ieee802154_addr structure uses an enum to store either
> > > > the short address or the extended addres, while at the MAC level I'd
> > > > like to compare with what I call a ieee802154_pan_device: the PAN
> > > > device is part of a list defining the associated neighbors and cont=
ains
> > > > both an extended address and a short address once associated.
> > > >
> > > > I do not want to compare the PAN ID here and I do not need to compa=
re
> > > > if the modes are different because the device the code is running on
> > > > is known to have both an extended address and a short address field
> > > > which have been initialized.
> > > > =20
> > >
> > > I see, so it is guaranteed that the mode value is the same? =20
> >
> > I looked more carefully at the code of the association section,
> > we will always know the extended address of the devices which are
> > associated to us, however there may be situations where the second
> > device to compare with this list only comes with a short address and pan
> > ID, so your initial comment needs to be addressed.
> > =20
> > > > With all these constraints, I think it would require more code to
> > > > re-use that small function than just writing a slightly different o=
ne
> > > > here which fully covers the "under association/disassociation" case=
, no?
> > > > =20
> > >
> > > I am questioning here currently myself if it's enough to uniquely
> > > identify devices with only short or extended. For extended I would say
> > > yes, for short I would say no. =20
> >
> > As long as we know the PAN ID, it should be fine.
> > =20
>=20
> yep, so you will add a check of panid when mode is short address type?

The above sentence was meant "in the common case". But here we are in a
very specific location which does not really apply to the common case.

During associations (because this is all what this is about), the stack
always saves the extended address, and when it is known, the short
address as well.

When I need these comparisons, it is because a device (parent or
children) has requested an association or a disassociation, and I want
to find the local "structure" which matches it. I looked again at the
specification, it says:
- In the case of an association request, the device will use its
  extended address only.
- In the case of a disassociation notification, the device will also
  use its extended address only and will address it to the
  coordinator using the right PAN ID. So actually, on one side, the
  "we might use the short address" never applies and on the other
  side, checking the PAN ID *here* is not relevant either as it
  should be done earlier (and the disassociation canceled if the wrong
  PAN ID is used).

So in v4 I will just error out if one uses short addressing in this
function, because it would make no sense at all. I will also check the
PAN ID in the disassociation procedure.

Thanks,
Miqu=C3=A8l
