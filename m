Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB390CD37B0
	for <linux-wpan@archiver.kernel.org>; Mon, 18 Sep 2023 07:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239928AbjIRHJG (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 18 Sep 2023 03:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240058AbjIRHIk (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 18 Sep 2023 03:08:40 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853DB11A;
        Mon, 18 Sep 2023 00:08:14 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DEB1D60004;
        Mon, 18 Sep 2023 07:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695020892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L+CL6faduRR7VdJezKaITusBK0ia1TtmWYYP0Rtbr3k=;
        b=BfX/0TjHkuOnZIWAEiZmsL/9VEtVna0MoPmzwfwdR8DXhm9WLV1TCg6iwUM+RBFNOMPFny
        Eu7iBqTluj5nD34qH8BoJqVRq9x1k3n7DLBTy1+LJ24nY5JmzcPod5zkDO2tQ2QBqeiILl
        bYh/yEeVGPrceYeVAQCLWVF0gsyywl93zkZBIrubRGY1/qbjmLAlX2SyCOwemDwiqwiAgS
        Od82Lh0LehTvXRIjQVzzxzcVaFLCwd8NwQy27wMY1XAZndlygoBItUr7zOYK/631Si5QYN
        D0Zq6lgDgY6SaQc9f8IDlHPMRJPWCk8WlCLjftc1M0+tBhqfEfT4xktsoG/UAg==
Date:   Mon, 18 Sep 2023 09:08:08 +0200
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
Subject: Re: [PATCH wpan-next v2 11/11] ieee802154: Give the user the
 association list
Message-ID: <20230918090808.37d53674@xps-13>
In-Reply-To: <385bff6c-1322-d2ea-16df-6e005888db0b@datenfreihafen.org>
References: <20230901170501.1066321-1-miquel.raynal@bootlin.com>
        <20230901170501.1066321-12-miquel.raynal@bootlin.com>
        <385bff6c-1322-d2ea-16df-6e005888db0b@datenfreihafen.org>
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

stefan@datenfreihafen.org wrote on Sat, 16 Sep 2023 17:36:41 +0200:

> Hello Miquel.
>=20
> On 01.09.23 19:05, Miquel Raynal wrote:
> > Upon request, we must be able to provide to the user the list of
> > associations currently in place. Let's add a new netlink command and
> > attribute for this purpose.
> >=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >   include/net/nl802154.h    |  18 ++++++-
> >   net/ieee802154/nl802154.c | 107 ++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 123 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/include/net/nl802154.h b/include/net/nl802154.h
> > index 8b26faae49e8..4c752f799957 100644
> > --- a/include/net/nl802154.h
> > +++ b/include/net/nl802154.h
> > @@ -81,6 +81,7 @@ enum nl802154_commands {
> >   	NL802154_CMD_ASSOCIATE,
> >   	NL802154_CMD_DISASSOCIATE,
> >   	NL802154_CMD_SET_MAX_ASSOCIATIONS,
> > +	NL802154_CMD_LIST_ASSOCIATIONS, =20
> >   >   	/* add new commands above here */
> >   > @@ -151,6 +152,7 @@ enum nl802154_attrs { =20
> >   	NL802154_ATTR_SCAN_DONE_REASON,
> >   	NL802154_ATTR_BEACON_INTERVAL,
> >   	NL802154_ATTR_MAX_ASSOCIATIONS,
> > +	NL802154_ATTR_PEER, =20
> >   >   	/* add attributes here, update the policy in nl802154.c */
> >   > @@ -389,8 +391,6 @@ enum nl802154_supported_bool_states { =20
> >   	NL802154_SUPPORTED_BOOL_MAX =3D __NL802154_SUPPORTED_BOOL_AFTER_LAST=
 - 1
> >   }; =20
> >   > -#ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL =20
> > -
> >   enum nl802154_dev_addr_modes {
> >   	NL802154_DEV_ADDR_NONE,
> >   	__NL802154_DEV_ADDR_INVALID,
> > @@ -410,12 +410,26 @@ enum nl802154_dev_addr_attrs {
> >   	NL802154_DEV_ADDR_ATTR_SHORT,
> >   	NL802154_DEV_ADDR_ATTR_EXTENDED,
> >   	NL802154_DEV_ADDR_ATTR_PAD,
> > +	NL802154_DEV_ADDR_ATTR_PEER_TYPE, =20
> >   >   	/* keep last */ =20
> >   	__NL802154_DEV_ADDR_ATTR_AFTER_LAST,
> >   	NL802154_DEV_ADDR_ATTR_MAX =3D __NL802154_DEV_ADDR_ATTR_AFTER_LAST -=
 1
> >   }; =20
> >   > +enum nl802154_peer_type { =20
> > +	NL802154_PEER_TYPE_UNSPEC,
> > +
> > +	NL802154_PEER_TYPE_PARENT,
> > +	NL802154_PEER_TYPE_CHILD,
> > +
> > +	/* keep last */
> > +	__NL802154_PEER_TYPE_AFTER_LAST,
> > +	NL802154_PEER_TYPE_MAX =3D __NL802154_PEER_TYPE_AFTER_LAST - 1
> > +};
> > +
> > +#ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
> > +
> >   enum nl802154_key_id_modes {
> >   	NL802154_KEY_ID_MODE_IMPLICIT,
> >   	NL802154_KEY_ID_MODE_INDEX,
> > diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
> > index e16e57fc34d0..e26d7cec02ce 100644
> > --- a/net/ieee802154/nl802154.c
> > +++ b/net/ieee802154/nl802154.c
> > @@ -235,6 +235,7 @@ static const struct nla_policy nl802154_policy[NL80=
2154_ATTR_MAX+1] =3D {
> >   	[NL802154_ATTR_BEACON_INTERVAL] =3D
> >   		NLA_POLICY_MAX(NLA_U8, IEEE802154_ACTIVE_SCAN_DURATION),
> >   	[NL802154_ATTR_MAX_ASSOCIATIONS] =3D { .type =3D NLA_U32 },
> > +	[NL802154_ATTR_PEER] =3D { .type =3D NLA_NESTED }, =20
> >   >   #ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL =20
> >   	[NL802154_ATTR_SEC_ENABLED] =3D { .type =3D NLA_U8, },
> > @@ -1717,6 +1718,107 @@ static int nl802154_set_max_associations(struct=
 sk_buff *skb, struct genl_info *
> >   	return 0;
> >   } =20
> >   > +static int nl802154_send_peer_info(struct sk_buff *msg, =20
> > +				   struct netlink_callback *cb,
> > +				   u32 seq, int flags,
> > +				   struct cfg802154_registered_device *rdev,
> > +				   struct wpan_dev *wpan_dev,
> > +				   struct ieee802154_pan_device *peer,
> > +				   enum nl802154_peer_type type)
> > +{
> > +	struct nlattr *nla;
> > +	void *hdr;
> > +
> > +	ASSERT_RTNL();
> > +
> > +	hdr =3D nl802154hdr_put(msg, NETLINK_CB(cb->skb).portid, seq, flags,
> > +			      NL802154_CMD_LIST_ASSOCIATIONS);
> > +	if (!hdr)
> > +		return -ENOBUFS;
> > +
> > +	genl_dump_check_consistent(cb, hdr);
> > +
> > +	if (nla_put_u32(msg, NL802154_ATTR_GENERATION,
> > +			wpan_dev->association_generation)) =20
>=20
>=20
> This one still confuses me. I only ever see it increasing in the code. Di=
d I miss something?

I think I took inspiration from nl802154_send_wpan_phy() and
and nl802154_send_iface() which both use an increasing counter to tell
userspace the "version" of the data that is being sent. If the
"version" numbers are identical, the user (I guess) can assume nothing
changed and save itself from parsing the whole payload or something
like that.

TBH I just tried here to mimic the existing behavior inside
nl802154_send_peer_info(), but I will drop that counter with no regrets.

Thanks,
Miqu=C3=A8l
