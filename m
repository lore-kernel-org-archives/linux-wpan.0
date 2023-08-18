Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C881C7113C
	for <linux-wpan@archiver.kernel.org>; Fri, 18 Aug 2023 14:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239055AbjHROSY (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 18 Aug 2023 10:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377748AbjHROSI (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 18 Aug 2023 10:18:08 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D103C3D;
        Fri, 18 Aug 2023 07:17:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5BD6A1C0004;
        Fri, 18 Aug 2023 14:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692368275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q8+h2LpE+Bx8EbOcnBEwlOM0f0VIsBmwJpKxKZpYLtQ=;
        b=eeq8HvLU89rVnmXO7saCaDy5iSBM9vQ6qlX2tKcsfoL6JDnFN+53UP/ayejXezn19X9Y8x
        E3qGFBPHUkyM+eibadbxeKH5NwSnbc39mTHWiRRHpjBp9iAjY6U6qwKX7l8Xrq2BLxL59g
        ZV49u/QaPx3nBM2IgLQ9hB1vBJcJh27ZNbks8zW6A4E5xWjzMiUt1eNegHCoM1u4pcgMnB
        SY1EVsdBCJzzs/kEdKP1Me8THVHSzhzXjY4iV1M5uIEO4jpo9I9QLRMXwbGxQawnQ42bhe
        gKCBOgEzqwy+ijgdDXjd2dlIOPYdGPV3domZ8uXVKwVlFSBtnf5ZadIa63jsYQ==
Date:   Fri, 18 Aug 2023 16:17:52 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Simon Horman <simon.horman@corigine.com>
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
Message-ID: <20230818161752.7f6172d0@xps-13>
In-Reply-To: <ZHoQwKiiAhfu74/U@corigine.com>
References: <20230601154817.754519-1-miquel.raynal@bootlin.com>
        <20230601154817.754519-5-miquel.raynal@bootlin.com>
        <ZHoQwKiiAhfu74/U@corigine.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Simon,

simon.horman@corigine.com wrote on Fri, 2 Jun 2023 17:54:40 +0200:

> On Thu, Jun 01, 2023 at 05:48:10PM +0200, Miquel Raynal wrote:
> > Joining a PAN officially goes by associating with a coordinator. This
> > coordinator may have been discovered thanks to the beacons it sent in
> > the past. Add support to the MAC layer for these associations, which
> > require:
> > - Sending an association request
> > - Receiving an association response
> >=20
> > The association response contains the association status, eventually a
> > reason if the association was unsuccessful, and finally a short address
> > that we should use for intra-PAN communication from now on, if we
> > required one (which is the default, and not yet configurable).
> >=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
>=20
> ...
>=20
> > diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
> > index cd69bdbfd59f..8bf01bb7e858 100644
> > --- a/net/ieee802154/core.c
> > +++ b/net/ieee802154/core.c
> > @@ -198,6 +198,18 @@ void wpan_phy_free(struct wpan_phy *phy)
> >  }
> >  EXPORT_SYMBOL(wpan_phy_free);
> > =20
> > +static void cfg802154_free_peer_structures(struct wpan_dev *wpan_dev)
> > +{
> > +	mutex_lock(&wpan_dev->association_lock);
> > +
> > +	if (wpan_dev->parent)
> > +		kfree(wpan_dev->parent); =20
>=20
> Hi Miquel,
>=20
> a minor nit from my side: There no need to check for NULL before calling
> kfree, because kfree will do nothing with a NULL argument.

Sorry for the delay, yes of course, I will drop the extra check.

Thanks,
Miqu=C3=A8l
