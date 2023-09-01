Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB59CA0FE5
	for <linux-wpan@archiver.kernel.org>; Fri,  1 Sep 2023 16:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344844AbjIAQZw (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 1 Sep 2023 12:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345362AbjIAQZw (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 1 Sep 2023 12:25:52 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C835172A;
        Fri,  1 Sep 2023 09:25:37 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 816B520007;
        Fri,  1 Sep 2023 16:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693585536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kt2QiyizzACdEhR9lh5A3A+HJ76feO5H+G4qht/znLs=;
        b=hMNmBJimBn8vEkj6zzE0+hDHEQri0w4mIFweGKn7AAcq0OVN9gqGJach0o+dLyNxl4TaaS
        tQfNEEvTD8khm6GxJr8Sg7kIn/OhFF7Jg+vlSPmCCFZW5qtw8eC9mYEEBBrFSVXRKyWUON
        F/EfcEK2N0GKEWjda1q/Vbr33xLItt56Srqs+08YUWsa84eRTxTm3juOLoLoEUtxCpK36A
        WMopVkbKvQzyT46R0S3bSFDlC+qfGs2B0e6OdHSy/L5SYPTH8tCCIpR0UnAfXtkjRHe5xb
        /WNo1RLFx40QTbp9sKZLNzoFt6/L08DV5JbvrU2i6GKKEG/TsDcO1Cnt6LyU1g==
Date:   Fri, 1 Sep 2023 18:25:28 +0200
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
Message-ID: <20230901182528.7c35f71e@xps-13>
In-Reply-To: <20230901174537.50f88d60@xps-13>
References: <20230601154817.754519-1-miquel.raynal@bootlin.com>
        <20230601154817.754519-8-miquel.raynal@bootlin.com>
        <CAK-6q+hWsLSy8vx_Hiwo0gRDYsW4Y7U=sQbAi5Na7BXQoOHWhw@mail.gmail.com>
        <20230821105259.4659dd74@xps-13>
        <20230901174537.50f88d60@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org


miquel.raynal@bootlin.com wrote on Fri, 1 Sep 2023 17:45:37 +0200:

> Hi Alexander,
>=20
> > > > --- a/net/ieee802154/pan.c
> > > > +++ b/net/ieee802154/pan.c
> > > > @@ -66,3 +66,30 @@ cfg802154_device_is_child(struct wpan_dev *wpan_=
dev,
> > > >         return NULL;
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(cfg802154_device_is_child);
> > > > +
> > > > +__le16 cfg802154_get_free_short_addr(struct wpan_dev *wpan_dev)
> > > > +{
> > > > +       struct ieee802154_pan_device *child;
> > > > +       __le16 addr;
> > > > +
> > > > +       lockdep_assert_held(&wpan_dev->association_lock);
> > > > +
> > > > +       do {
> > > > +               get_random_bytes(&addr, 2);     =20
> > >=20
> > > This is combined with the max associations setting? I am not sure if
> > > this is the best way to get free values from a u16 value where we have
> > > some data structure of "given" addresses to a node. I recently was
> > > looking into idr/xarray data structure... maybe we can use something
> > > from there.   =20
> >=20
> > I actually thought about using an increasing index, but the pseudo
> > random generator seemed appropriate because of its "unpredictability",
> > but there is not real use for that (besides maybe testing purposes). I
> > can definitely switch to another solution. =20
>=20
> I looked into this deeper. I didn't felt like idr would be so much
> useful, but I started converting the code to use ida instead (so the
> simplest approach, with no associated pointer). There are actually two
> use cases which clearly match better the random address mechanism.
>=20
> a/ One can freely decide the short address of the coordinator (it is
> freely selectable by the user) but ida has no mechanism to handle this
> with an API which would prevent such "number to be used".
>=20
> In practice, this could be workarounded "easily", even though the
> implementation would be dirty IMHO: getting an IDA, if it matches ours,
> just try again without freeing it. TBH I don't like much this idea.
>=20
> b/ In case we ever want to support master handover, the ida solution
> does not work well...

c/ Technically speaking, leaf devices can connect to a PAN coordinator
which is not the top-level coordinator in case it is out of reach.
So the coordinator receiving the association request needs to allocate
a random address for this leaf device, without knowing all the
addresses the top-level coordinator already allocated. In case the
devices move or a coordinator detects two different devices within the
same PAN with the same short addres, it must trigger a realignment
procedure (not implemented yet). Therefore, following a linear scheme
when allocating children short addresses sounds like an endless source
of conflicts and realignments, whereas random addressing would prevent
most of these situations on regular sized networks?

> For now I've kept the current approach (actually adding a missing
> check), but if you know how to solve that I can either update the
> implementation or make a followup patch, especially since the current
> approach is not bounded (in the theoretical case where we have 65k
> devices in the same PAN).
>=20
> I believe the allocation strategies are not set in stone anyway and can
> easily evolve.
>=20
> Thanks,
> Miqu=C3=A8l
