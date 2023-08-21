Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369ADEE4993
	for <linux-wpan@archiver.kernel.org>; Mon, 21 Aug 2023 09:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbjHUJDD (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 21 Aug 2023 05:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjHUJDC (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Aug 2023 05:03:02 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A69C1;
        Mon, 21 Aug 2023 02:03:00 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 28FCE40014;
        Mon, 21 Aug 2023 09:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692608578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9KQXXNZLzlLX2HrjqmF7bZOjW8iU/6pS3p7k7Lc4f1w=;
        b=NaEY4ZFl+BA05rdZcbSDXVl+bOzY5trdijfeCyoj3uMXMZaDfyADEq+x/6R3FD9ldyCRBd
        ynpeJ2li4dmNEytFOrqDhTkiR1jLSyb509MGYgsrLR7vR5k/oUIhEjSpZHm1XRm3fthZBj
        nS/i6XjShT6nQCmyikci+U2RUMemhCxU5kYSkNu/t1ZwvVgkv5bcSBrt3X6Gri5iwXhbxS
        CgZOVP5+5t0eTMz+zBByE4eaEz8j03Lot+su/n8HG+H1U0OFbbGyM5nvlCOcQBPI2u0dA9
        wl3cBrugooSHIFo96UHSvY/VvFN85TnAm9vXGav8t6VEzGPZeVN1Fd0QvFWvgw==
Date:   Mon, 21 Aug 2023 11:02:56 +0200
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
Subject: Re: [PATCH wpan-next 06/11] mac802154: Handle disassociations
Message-ID: <20230821110256.2e658d62@xps-13>
In-Reply-To: <CAK-6q+hWR9cLt2+nbGY9KbtwLSJkN+NF+Q651aPDLCaO1mk1=Q@mail.gmail.com>
References: <20230601154817.754519-1-miquel.raynal@bootlin.com>
        <20230601154817.754519-7-miquel.raynal@bootlin.com>
        <CAK-6q+hWR9cLt2+nbGY9KbtwLSJkN+NF+Q651aPDLCaO1mk1=Q@mail.gmail.com>
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

aahringo@redhat.com wrote on Sat, 3 Jun 2023 07:30:05 -0400:

> Hi,
>=20
> On Thu, Jun 1, 2023 at 11:50=E2=80=AFAM Miquel Raynal <miquel.raynal@boot=
lin.com> wrote:
> >
> > Devices may decide to disassociate from their coordinator for different
> > reasons (device turning off, coordinator signal strength too low, etc),
> > the MAC layer just has to send a disassociation notification.
> >
> > If the ack of the disassociation notification is not received, the
> > device may consider itself disassociated anyway.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  net/ieee802154/pan.c         |   2 +
> >  net/mac802154/cfg.c          | 102 +++++++++++++++++++++++++++++++++++
> >  net/mac802154/ieee802154_i.h |   4 ++
> >  net/mac802154/scan.c         |  60 +++++++++++++++++++++
> >  4 files changed, 168 insertions(+)
> >
> > diff --git a/net/ieee802154/pan.c b/net/ieee802154/pan.c
> > index e2a12a42ba2b..477e8dad0cf0 100644
> > --- a/net/ieee802154/pan.c
> > +++ b/net/ieee802154/pan.c
> > @@ -49,6 +49,7 @@ bool cfg802154_device_is_parent(struct wpan_dev *wpan=
_dev,
> >
> >         return false;
> >  }
> > +EXPORT_SYMBOL_GPL(cfg802154_device_is_parent);
> >
> >  struct ieee802154_pan_device *
> >  cfg802154_device_is_child(struct wpan_dev *wpan_dev,
> > @@ -64,3 +65,4 @@ cfg802154_device_is_child(struct wpan_dev *wpan_dev,
> >
> >         return NULL;
> >  }
> > +EXPORT_SYMBOL_GPL(cfg802154_device_is_child);
> > diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
> > index 89112d2bcee7..c27c05e825ff 100644
> > --- a/net/mac802154/cfg.c
> > +++ b/net/mac802154/cfg.c
> > @@ -386,6 +386,107 @@ static int mac802154_associate(struct wpan_phy *w=
pan_phy,
> >         return ret;
> >  }
> >
> > +static int mac802154_disassociate_from_parent(struct wpan_phy *wpan_ph=
y,
> > +                                             struct wpan_dev *wpan_dev)
> > +{
> > +       struct ieee802154_local *local =3D wpan_phy_priv(wpan_phy);
> > +       struct ieee802154_pan_device *child, *tmp;
> > +       struct ieee802154_sub_if_data *sdata;
> > +       u64 eaddr;
> > +       int ret;
> > +
> > +       sdata =3D IEEE802154_WPAN_DEV_TO_SUB_IF(wpan_dev);
> > +
> > +       /* Start by disassociating all the children and preventing new =
ones to
> > +        * attempt associations.
> > +        */
> > +       list_for_each_entry_safe(child, tmp, &wpan_dev->children, node)=
 {
> > +               ret =3D mac802154_send_disassociation_notif(sdata, chil=
d,
> > +                                                         IEEE802154_CO=
ORD_WISHES_DEVICE_TO_LEAVE);
> > +               if (ret) {
> > +                       eaddr =3D swab64((__force u64)child->extended_a=
ddr); =20
>=20
> Does this pass sparse? I think this needs to be le64_to_cpu()?

I never feel comfortable with sparse given the dozens (hundreds) of
lines it outputs, but I think yes, parse does not seem to complain. To
be honest I think we should keep it this way just because I copy-pasted
it from other locations in the core:

$ git grep -c "swab64((__force u64)" -- net/ieee802154/ net/mac802154/
net/ieee802154/nl-mac.c:1
net/mac802154/cfg.c:4
net/mac802154/llsec.c:1
net/mac802154/rx.c:2
net/mac802154/scan.c:6

So if we ever want to change that, we could easily find them all and
replace them all in one go?

Thanks,
Miqu=C3=A8l
