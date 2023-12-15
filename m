Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8D41A70D;
	Fri, 15 Dec 2023 10:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jeZtRIDv"
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id EB37AC27B4;
	Fri, 15 Dec 2023 10:42:48 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 35B144000D;
	Fri, 15 Dec 2023 10:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702636961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VOegI2nr02yHx10+fDKDl/CpKdi0c6rrkPE4G6vRvZ0=;
	b=jeZtRIDvrO1VWYjZSKXBE3rcGoOx8UYoqKR8JszgLkNWmaKsyf7mQsP5eb1CpzJXsz/GNu
	d1et2dv9bmsEq0w8CKjx/D7RVPgekB7fek2nJeHKA4+AcBLPC8abwqukrPFAYXwdzNj8Eo
	XHzj+zRkfFDaKKpoNF6XDRJ9gr4SJ2e4T2OY/nZIIKoR3zFNAbIK70stTrzciTds5Nk9n0
	inMOSq77PaKeBneZfow1m1sFBUs5d5uXhOCvckttKrfePfaCLUvs1dPNcT+UF8E/1+3LKZ
	KfLRP222gH5m/lUSf7CWIUk6Wi07gEvjDw3LMGH62pJldYxsB1k/F5w/D0f81w==
Date: Fri, 15 Dec 2023 11:42:28 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Aring <aahringo@redhat.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt
 <stefan@datenfreihafen.org>, linux-wpan@vger.kernel.org, David Girault
 <david.girault@qorvo.com>, Romuald Despres <romuald.despres@qorvo.com>,
 Frederic Blain <frederic.blain@qorvo.com>, Nicolas Schodet
 <nico@ni.fr.eu.org>, Guilhem Imberton <guilhem.imberton@qorvo.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH wpan-next 2/5] mac802154: Use the PAN coordinator
 parameter when stamping packets
Message-ID: <20231215114228.35e3a408@xps-13>
In-Reply-To: <CAK-6q+jpmhhARPcjkbfFVR7tRFQqYwXAdngebyUt+BzpFcgUGw@mail.gmail.com>
References: <20231128111655.507479-1-miquel.raynal@bootlin.com>
	<20231128111655.507479-3-miquel.raynal@bootlin.com>
	<CAK-6q+jpmhhARPcjkbfFVR7tRFQqYwXAdngebyUt+BzpFcgUGw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Alexander,

aahringo@redhat.com wrote on Thu, 14 Dec 2023 21:46:06 -0500:

> Hi,
>=20
> On Tue, Nov 28, 2023 at 6:17=E2=80=AFAM Miquel Raynal <miquel.raynal@boot=
lin.com> wrote:
> >
> > ACKs come with the source and destination address empty, this has been
> > clarified already. But there is something else: if the destination
> > address is empty but the source address is valid, it may be a way to
> > reach the PAN coordinator. Either the device receiving this frame is the
> > PAN coordinator itself and should process what it just received
> > (PACKET_HOST) or it is not and may, if supported, relay the packet as it
> > is targeted to another device in the network.
> >
> > Right now we do not support relaying so the packet should be dropped in
> > the first place, but the stamping looks more accurate this way.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  net/mac802154/rx.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
> > index 0024341ef9c5..e40a988d6c80 100644
> > --- a/net/mac802154/rx.c
> > +++ b/net/mac802154/rx.c
> > @@ -156,12 +156,15 @@ ieee802154_subif_frame(struct ieee802154_sub_if_d=
ata *sdata,
> >
> >         switch (mac_cb(skb)->dest.mode) {
> >         case IEEE802154_ADDR_NONE:
> > -               if (hdr->source.mode !=3D IEEE802154_ADDR_NONE)
> > -                       /* FIXME: check if we are PAN coordinator */
> > -                       skb->pkt_type =3D PACKET_OTHERHOST;
> > -               else
> > +               if (hdr->source.mode =3D=3D IEEE802154_ADDR_NONE)
> >                         /* ACK comes with both addresses empty */
> >                         skb->pkt_type =3D PACKET_HOST;
> > +               else if (!wpan_dev->parent)
> > +                       /* No dest means PAN coordinator is the recipie=
nt */
> > +                       skb->pkt_type =3D PACKET_HOST;
> > +               else
> > +                       /* We are not the PAN coordinator, just relayin=
g */
> > +                       skb->pkt_type =3D PACKET_OTHERHOST;
> >                 break;
> >         case IEEE802154_ADDR_LONG:
> >                 if (mac_cb(skb)->dest.pan_id !=3D span && =20
>=20
> So if I understand it correctly, the "wpan_dev->parent" check acts
> like a "forwarding" setting on an IP capable interface here? The

Kind of, yes, in this case having a parent means we are not the top
level PAN coordinator.

> "forwarding" setting changes the interface to act as a router, which
> is fine...=20

I think there is no true "router" role but depending on the frame
construction (dest field) we might sometimes act as a router. This is
not supported in Linux, just a feature of the spec.

> but we have a difference here with the actual hardware and
> the address filtering setting which we don't have in e.g. ethernet. My
> concern is here that this code is probably interface type specific,
> e.g. node vs coordinator type and currently we handle both in one
> receive part.
>=20
> I am fine with that and probably it is just a thing to change in future...

That is true and probably will need adaptations if/when we come to this
feature. What we do here however is just stamping the packet, in a
manner that is more accurate. So in practice all type of interfaces may
want to do that. However the handling of the packet later in the
stack will be interface specific, I agree.

Thanks,
Miqu=C3=A8l
