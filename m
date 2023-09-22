Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C132FE6FE52
	for <linux-wpan@archiver.kernel.org>; Fri, 22 Sep 2023 15:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjIVPTG (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 22 Sep 2023 11:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjIVPTF (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 22 Sep 2023 11:19:05 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB26A3;
        Fri, 22 Sep 2023 08:18:58 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0092AFF806;
        Fri, 22 Sep 2023 15:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695395937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6A5fKltW6/gSKHcpM0/Tdg4N/kNuuqKCAurZbz737N4=;
        b=fNWcjX6bpDCL+i7ZNsYaMgr078EH++x3NTJnX7WXabc2ULL5pemH/FyDUFTH4DmjHbOxsZ
        9WAUiqfUUFMbev+PF2e5l5Nppzob6bLihQZ3bQfcYoi8sm46PhhFv+4GJvZnSZURxJdKaz
        msdaAP7HoyWTSTcXAdbd8VagWQOMJZ7l0oisCNEDC8CUgc4SpN+czUyB0i5ZEuLnAersmc
        CvtuHdqRkh7A6MMN71EAL006DXqAEo1MeDUH0Wevxoy8PhKtFxzhE7tsUfpbiS3h0EILZG
        egq0LcSpAHOzfDGb0yOgqk4g7dxCbdDKZcL6hgjXyVgSsHmQYnmjQIsL2raiuQ==
Date:   Fri, 22 Sep 2023 17:18:54 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org,
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
Subject: Re: [PATCH wpan-next v3 02/11] ieee802154: Internal PAN management
Message-ID: <20230922171854.52d44c77@xps-13>
In-Reply-To: <d6ac4dbc-a5c1-fbd0-41d5-d8d87ce8e2f9@datenfreihafen.org>
References: <20230918150809.275058-1-miquel.raynal@bootlin.com>
        <20230918150809.275058-3-miquel.raynal@bootlin.com>
        <d6ac4dbc-a5c1-fbd0-41d5-d8d87ce8e2f9@datenfreihafen.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Stefan,

stefan@datenfreihafen.org wrote on Wed, 20 Sep 2023 20:08:56 +0200:

> Hello.
>=20
> On 18.09.23 17:08, Miquel Raynal wrote:
> > Introduce structures to describe peer devices in a PAN as well as a few
> > related helpers. We basically care about:
> > - Our unique parent after associating with a coordinator.
> > - Peer devices, children, which successfully associated with us.
> >=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >   include/net/cfg802154.h | 46 +++++++++++++++++++++++++
> >   net/ieee802154/Makefile |  2 +-
> >   net/ieee802154/core.c   |  2 ++
> >   net/ieee802154/pan.c    | 75 +++++++++++++++++++++++++++++++++++++++++
> >   4 files changed, 124 insertions(+), 1 deletion(-)
> >   create mode 100644 net/ieee802154/pan.c
> >=20
> > diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> > index f79ce133e51a..6c7193b4873c 100644
> > --- a/include/net/cfg802154.h
> > +++ b/include/net/cfg802154.h

[...]

> > @@ -478,6 +494,11 @@ struct wpan_dev { =20
> >   >   	/* fallback for acknowledgment bit setting */ =20
> >   	bool ackreq;
> > +
> > +	/* Associations */
> > +	struct mutex association_lock;
> > +	struct ieee802154_pan_device *parent;
> > +	struct list_head children;
> >   }; =20
> >   >   #define to_phy(_dev)	container_of(_dev, struct wpan_phy, dev) =20
> > @@ -529,4 +550,29 @@ static inline const char *wpan_phy_name(struct wpa=
n_phy *phy)
> >   void ieee802154_configure_durations(struct wpan_phy *phy,
> >   				    unsigned int page, unsigned int channel); =20
> >   > +/** =20
> > + * cfg802154_device_is_associated - Checks whether we are associated t=
o any device
> > + * @wpan_dev: the wpan device
> > + */
> > +bool cfg802154_device_is_associated(struct wpan_dev *wpan_dev); =20
>=20
> The return value still missing in kdoc. Seems you missed this from my las=
t review. :-)

Oops, I marked it done on my side by mistake. Sorry for that mistake.

[...]

> > diff --git a/net/ieee802154/pan.c b/net/ieee802154/pan.c
> > new file mode 100644
> > index 000000000000..012b5e821d54
> > --- /dev/null
> > +++ b/net/ieee802154/pan.c
> > @@ -0,0 +1,75 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * IEEE 802.15.4 PAN management
> > + *
> > + * Copyright (C) 2021 Qorvo US, Inc =20
>=20
> Feel free to extend the copyright years to 2023 as well.

Right, set to 2023.

Thanks,
Miqu=C3=A8l
