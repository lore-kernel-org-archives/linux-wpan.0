Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA3ECD13D2
	for <linux-wpan@archiver.kernel.org>; Mon, 18 Sep 2023 07:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238545AbjIRHlC (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 18 Sep 2023 03:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240434AbjIRHkx (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 18 Sep 2023 03:40:53 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1C230C2;
        Mon, 18 Sep 2023 00:37:07 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8BB8C1C000C;
        Mon, 18 Sep 2023 07:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695022623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kMUXF3i8vZfKK4TTptUJRX/v1cTmR9n/zzTlrk9sT30=;
        b=asePB56APJvEKxXg2/wykZhHucA9qXsW29IS7M3aPZVcYUoS8NiV9wGwSZqFJox37PN5ct
        X6cmoE+pCJ3Csv2IiPARuibGhOiAVsPunAgkkWv4+wI0qpU5FNkGqwQoABj4Wg6lK091C6
        I96m+MaaezZlseSbNfYxbqX3AZjgsv9/+RezEPZMh6lHGlk/4CKwDibrDzE+2XRZqyxpNF
        4vogm0qInZgZTPKtwAr/uG7zLIE/UiMrPLes1Xa3JnESGqEOiOLhrdBA5deXVKHnncTkFG
        wfPUvDs/3sW1uOugSZMKjAtOpMXQ782ZsN2OXcbbggMK9LK40MevTQwQ3Hfq5w==
Date:   Mon, 18 Sep 2023 09:36:59 +0200
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
Subject: Re: [PATCH wpan-next v2 07/11] mac802154: Handle association
 requests from peers
Message-ID: <20230918093659.6488891a@xps-13>
In-Reply-To: <7b9b1b97-7c02-06b3-7a84-db1f33784be3@datenfreihafen.org>
References: <20230901170501.1066321-1-miquel.raynal@bootlin.com>
        <20230901170501.1066321-8-miquel.raynal@bootlin.com>
        <7b9b1b97-7c02-06b3-7a84-db1f33784be3@datenfreihafen.org>
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

> > +static int
> > +mac802154_send_association_resp_locked(struct ieee802154_sub_if_data *=
sdata,
> > +				       struct ieee802154_pan_device *target,
> > +				       struct ieee802154_assoc_resp_pl *assoc_resp_pl)
> > +{
> > +	u64 teaddr =3D swab64((__force u64)target->extended_addr);
> > +	struct ieee802154_association_resp_frame frame =3D {};
> > +	struct ieee802154_local *local =3D sdata->local;
> > +	struct wpan_dev *wpan_dev =3D &sdata->wpan_dev;
> > +	struct sk_buff *skb;
> > +	int ret;
> > +
> > +	frame.mhr.fc.type =3D IEEE802154_FC_TYPE_MAC_CMD;
> > +	frame.mhr.fc.security_enabled =3D 0;
> > +	frame.mhr.fc.frame_pending =3D 0;
> > +	frame.mhr.fc.ack_request =3D 1; /* We always expect an ack here */
> > +	frame.mhr.fc.intra_pan =3D 1;
> > +	frame.mhr.fc.dest_addr_mode =3D IEEE802154_EXTENDED_ADDRESSING;
> > +	frame.mhr.fc.version =3D IEEE802154_2003_STD;
> > +	frame.mhr.fc.source_addr_mode =3D IEEE802154_EXTENDED_ADDRESSING;
> > +	frame.mhr.seq =3D 10; =20
>=20
> Where does the 10 come from and what is the meaning?

Good point, that is a leftover from my earlier WIP versions. A few lines
below this is overwritten by:

	frame.mhr.seq =3D atomic_inc_return(&wpan_dev->dsn) & 0xFF;

I'll of course drop the `seq =3D 10` line.

Thanks,
Miqu=C3=A8l
