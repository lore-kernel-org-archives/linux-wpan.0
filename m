Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8A5CA0FE4
	for <linux-wpan@archiver.kernel.org>; Fri,  1 Sep 2023 15:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350252AbjIAPbQ (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 1 Sep 2023 11:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350271AbjIAPbQ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 1 Sep 2023 11:31:16 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1BD10D2;
        Fri,  1 Sep 2023 08:31:11 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 277081C0002;
        Fri,  1 Sep 2023 15:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693582269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+w+byWYQqXZJ9Sez01ZbkF+4eCxNbTGizWdl7E0uv/Q=;
        b=cuPB34J8/xdRj/wbtIGQ3SJAy7sy6I6EoOnC6Wi3K0ua5PzdLa9Gm5rIlf4yHAFncdmmf5
        UO1wTqLZadfhxYohwAOicB6VqZ7GSNV1Euf138s44HQGtPVdWVEZ6g5hcTuxkkyg05qHAe
        FvjpKpayrw4eqfeiq+KbpTAhp4sjJejN9Ya6ugMYJzFIFOVXlFqwMVXsOcYKaX1HJdA3xp
        Rzt526AobOLtcohIBAJj0G8pD3BPR/cZD/Bpd6cXtAIf8I5Y9aMn9NGP9WFq/QIf472vnh
        WUqeQqAis3i1/OBtCvqTqR9Fux3iKV3FoTbgCGvVktcRTg98e5VqbEWbByuyAw==
Date:   Fri, 1 Sep 2023 17:31:01 +0200
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
Subject: Re: [PATCH wpan-next 04/11] mac802154: Handle associating
Message-ID: <20230901173101.27312bec@xps-13>
In-Reply-To: <CAK-6q+ibbYBbvbGK9ehJJoaJAw4hubh6Ff=q2P4mq+Z07ZgR0A@mail.gmail.com>
References: <20230601154817.754519-1-miquel.raynal@bootlin.com>
 <20230601154817.754519-5-miquel.raynal@bootlin.com>
 <CAK-6q+ibbYBbvbGK9ehJJoaJAw4hubh6Ff=q2P4mq+Z07ZgR0A@mail.gmail.com>
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

> > @@ -293,6 +305,8 @@ static int cfg802154_netdev_notifier_call(struct no=
tifier_block *nb,
> >                 rdev->opencount++;
> >                 break;
> >         case NETDEV_UNREGISTER:
> > +               cfg802154_free_peer_structures(wpan_dev);
> > + =20
>=20
> I think the comment below is not relevant here, but I have also no
> idea if this is still the case.

Yeah, I did not bother with it as it was off topic. I believe the call
above would anyway not be affected.

> >                 /* It is possible to get NETDEV_UNREGISTER
> >                  * multiple times. To detect that, check
> >                  * that the interface is still on the list
> > diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
> > index 5c3cb019f751..89112d2bcee7 100644
> > --- a/net/mac802154/cfg.c
> > +++ b/net/mac802154/cfg.c
> > @@ -315,6 +315,77 @@ static int mac802154_stop_beacons(struct wpan_phy =
*wpan_phy,
> >         return mac802154_stop_beacons_locked(local, sdata);
> >  }
> >
> > +static int mac802154_associate(struct wpan_phy *wpan_phy,
> > +                              struct wpan_dev *wpan_dev,
> > +                              struct ieee802154_addr *coord)
> > +{
> > +       struct ieee802154_local *local =3D wpan_phy_priv(wpan_phy);
> > +       u64 ceaddr =3D swab64((__force u64)coord->extended_addr);
> > +       struct ieee802154_sub_if_data *sdata;
> > +       struct ieee802154_pan_device *parent;
> > +       __le16 short_addr;
> > +       int ret;
> > +
> > +       ASSERT_RTNL();
> > +
> > +       sdata =3D IEEE802154_WPAN_DEV_TO_SUB_IF(wpan_dev);
> > +
> > +       if (wpan_dev->parent) {
> > +               dev_err(&sdata->dev->dev,
> > +                       "Device %8phC is already associated\n", &ceaddr=
);
> > +               return -EPERM;
> > +       }
> > +
> > +       parent =3D kzalloc(sizeof(*parent), GFP_KERNEL);
> > +       if (!parent)
> > +               return -ENOMEM;
> > +
> > +       parent->pan_id =3D coord->pan_id;
> > +       parent->mode =3D coord->mode;
> > +       if (parent->mode =3D=3D IEEE802154_SHORT_ADDRESSING) {
> > +               parent->short_addr =3D coord->short_addr;
> > +               parent->extended_addr =3D cpu_to_le64(IEEE802154_ADDR_L=
ONG_BROADCAST); =20
>=20
> There is no IEEE802154_ADDR_LONG_BROADCAST (extended address) address.
> The broadcast address is always a short address 0xffff. (Talkin about
> destination addresses).

You're totally right, this is misleading. I will just drop this
definition and its use, see below.

> Just to clarify we can have here two different types/length of mac
> addresses being used, whereas the extended address is always present.
> We have the monitor interface set to an invalid extended address
> 0x0...0 (talking about source address) which is a reserved EUI64 (what
> long/extended address is) address, 0xffff...ffff is also being
> reserved. Monitors get their address from the socket interface.
>=20
> If there is a parent, an extended address is always present and known.
> A short address can be set, but is not required as a node to have.
> Sure if a node has a short address, you want to use a short address
> because it saves payload.
> Also remember when an address is unique in the network, an extended
> address (LONG) is always being unique, a short address is unique in
> combination of pan id + short address.

Absolutely.

> If you save some neighbors you want to store the extended and if
> present panid/shortaddress.

The code above was misleading, I will clarify it to only accept NL
association commands with an extended address. In fact the coord
structure is created in the nl802154 layer and it already only accepts
extended addresses (we don't expect the short address through the nl
command) so to answer your request: yes, the extended address will
always be there because we must know it.

Regarding the possibility to provide a short address, as we no longer
keep details about the surrounding devices inside the kernel (we only
keep the associated devices, either the parent or the children) keeping
this information would be useless. I don't see a need for it. The
NL interface can evolve later without breaking the compatibility if we
ever want to provide a short address as well and make something with it
(actually even today one could send the short address, it would simply
be ingored).

One thing however regarding the fact that we might want to store both a
short *and* an extended address in some cases: I created a "PAN device"
structure which allows this (because otherwise we had a union) as we
need to do it when we are parent as we are in charge of allocating the
short addresses:

+/**
+ * struct ieee802154_pan_device - PAN device information
+ * @pan_id: the PAN ID of this device
+ * @mode: the preferred mode to reach the device
+ * @short_addr: the short address of this device
+ * @extended_addr: the extended address of this device
+ * @node: the list node
+ */
+struct ieee802154_pan_device {
+       __le16 pan_id;
+       u8 mode;
+       __le16 short_addr;
+       __le64 extended_addr;
+       struct list_head node;
+};

> Or I do not understand something here?

No no, I think we are fully aligned :-)

> btw: as you probably noticed, the netdev interface dev_addr is an
> extended address (because it's always present). Now there comes the
> ugly part, netdevs cannot deal with other dev_addrs with different
> length, that's why it's stored in the wpan specific dev structure and
> things don't get easy and solutions need to be found how to make it
> working... get prepared to get crazy...

Yeah but I believe once we have proper PAN IDs/short address vs
extended address mappings we could have the translation internally at
least. I haven't investigated this for now.

Thanks,
Miqu=C3=A8l
