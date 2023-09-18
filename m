Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3F2CD37B0
	for <linux-wpan@archiver.kernel.org>; Mon, 18 Sep 2023 15:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjIRPun (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 18 Sep 2023 11:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIRPum (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 18 Sep 2023 11:50:42 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [IPv6:2001:4b98:dc4:8::240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDA81720;
        Mon, 18 Sep 2023 08:47:24 -0700 (PDT)
Received: from relay3-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::223])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 75A89C3D0C;
        Mon, 18 Sep 2023 14:15:07 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8C0566000B;
        Mon, 18 Sep 2023 14:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695046507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ifw++N/wrKSagoAI3Ql4WyzXOkLc1sHNSg9jooTsU0I=;
        b=Tr1fUX+hNCU9hmhLlTQypMsGMGrKOveY2MafDVRXSMdRIkwXfFKgRDzTkB1RzcXyhR9mtW
        tKNwhGjSYZtfqMeFxvunqkJRAGrEAhurXhZWjfODoMKpjGGC8qf7OnrH4A/Q45lAdl1YSB
        SWU1ycuunJpqt6sbpN4MWGhM0L3Nsn8Zgtw+nQRVej+AjNIKkOd80Ph/cjvk+tnbq60D4J
        KJxg+o0lKhiDgf/Kb9BC+boVsPgwyFUcmRc/Q+psGhwyb+KTONY6D/0ya2vPR5uNkOC0/Y
        KS8ixfvlRgM67E/y0Kz1jEqWCO2A/JRBYuaIxPm4MRq902JJK8U7vdFeW8BgSQ==
Date:   Mon, 18 Sep 2023 16:15:02 +0200
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
Message-ID: <20230918161502.69818794@xps-13>
In-Reply-To: <CAK-6q+gcqr=Sgswgzd1pzMQoPEV1jG=_0m51+HsKU_=1b7NYUg@mail.gmail.com>
References: <20230901170501.1066321-1-miquel.raynal@bootlin.com>
        <20230901170501.1066321-3-miquel.raynal@bootlin.com>
        <32cfbf0f-7ac8-5a4c-d9cd-9650a64fc0ea@datenfreihafen.org>
        <CAK-6q+h1rbG+6=M+ZZfUznHq9GxOwtA1i0c=C9dgQH1qC7sQ=A@mail.gmail.com>
        <20230918110102.19a43db1@xps-13>
        <CAK-6q+gcqr=Sgswgzd1pzMQoPEV1jG=_0m51+HsKU_=1b7NYUg@mail.gmail.com>
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


> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * IEEE 802.15.4 PAN management
> > > > > + *
> > > > > + * Copyright (C) 2021 Qorvo US, Inc
> > > > > + * Authors:
> > > > > + *   - David Girault <david.girault@qorvo.com>
> > > > > + *   - Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > + */
> > > > > +
> > > > > +#include <linux/kernel.h>
> > > > > +#include <net/cfg802154.h>
> > > > > +#include <net/af_ieee802154.h>
> > > > > +
> > > > > +static bool cfg802154_same_addr(struct ieee802154_pan_device *a,
> > > > > +                             struct ieee802154_addr *b)
> > > > > +{
> > > > > +     if (!a || !b)
> > > > > +             return false;
> > > > > +
> > > > > +     switch (b->mode) {
> > > > > +     case IEEE802154_ADDR_SHORT:
> > > > > +             return a->short_addr =3D=3D b->short_addr;
> > > > > +     case IEEE802154_ADDR_LONG:
> > > > > +             return a->extended_addr =3D=3D b->extended_addr;
> > > > > +     default:
> > > > > +             return false;
> > > > > +     }
> > > > > +} =20
> > > >
> > > > Don't we already have such a helper already? =20
> > >
> > > There must also be a check on (a->mode !=3D b->mode) because short_ad=
dr
> > > and extended_addr share memory in this struct. =20
> >
> > True.
> >
> > Actually the ieee802154_addr structure uses an enum to store either
> > the short address or the extended addres, while at the MAC level I'd
> > like to compare with what I call a ieee802154_pan_device: the PAN
> > device is part of a list defining the associated neighbors and contains
> > both an extended address and a short address once associated.
> >
> > I do not want to compare the PAN ID here and I do not need to compare
> > if the modes are different because the device the code is running on
> > is known to have both an extended address and a short address field
> > which have been initialized.
> > =20
>=20
> I see, so it is guaranteed that the mode value is the same?

I looked more carefully at the code of the association section,
we will always know the extended address of the devices which are
associated to us, however there may be situations where the second
device to compare with this list only comes with a short address and pan
ID, so your initial comment needs to be addressed.

> > With all these constraints, I think it would require more code to
> > re-use that small function than just writing a slightly different one
> > here which fully covers the "under association/disassociation" case, no?
> > =20
>=20
> I am questioning here currently myself if it's enough to uniquely
> identify devices with only short or extended. For extended I would say
> yes, for short I would say no.

As long as we know the PAN ID, it should be fine.

> Somehow I don't get it, maybe because
> it's on the setup to be associated and we know the panid already but
> it is not being set at this point?

Yes, this code is used *when* we associate or disassociate.

Thanks,
Miqu=C3=A8l
