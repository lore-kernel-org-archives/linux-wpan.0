Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C304ECAAD3
	for <linux-wpan@archiver.kernel.org>; Mon,  5 Sep 2022 15:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbiIEPf3 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 5 Sep 2022 11:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238886AbiIEPfX (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 5 Sep 2022 11:35:23 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DCC2ED5A
        for <linux-wpan@vger.kernel.org>; Mon,  5 Sep 2022 08:35:17 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F1F0F60008;
        Mon,  5 Sep 2022 15:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662392116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6lbk/b7Ve9XBkwNnDkoaADdvt2OBqrA97HcNAXXt85I=;
        b=VbTUPykLtMkxbrhKA3503jcKoFHktzb778feM3o5WrL3wlVX6PWlswPO6pRK7/JZHGGREr
        94xfJKqQhfk3XVGD0i77tOkTMvzzeYDwTAZjkn9nGjBt5Ya3ZJU8klzWVVJOCrPepNTjd/
        c2xMQZLwAE5OhElbb3S5clXAliUwPLDN0/R+JdMeMoKOpQ0zj5gdqYiKFRF55oqMsqeQrc
        mrpvz5ACm2ulyAIA6TevV3B0OQyLi+Wcd3Y0jcEDhjir/xYvit2Sbb0FZ0AQvE3d4V5KG6
        BwH958JahiD+MroPQYbQVuyT1+RwzHrOUrUpAlUPLZDaZYgkpyWO3qX0WQc5MA==
Date:   Mon, 5 Sep 2022 17:35:14 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [RFC wpan-next 2/2] net: mac802154: set filter at drv_start()
Message-ID: <20220905173514.7b5fccff@xps-13>
In-Reply-To: <CAK-6q+j8aQAPrj2HVUD2SmYijpt=bH=rheqqU0toZGNaPyj2YA@mail.gmail.com>
References: <20220905010810.1010911-1-aahringo@redhat.com>
        <20220905010810.1010911-2-aahringo@redhat.com>
        <CAK-6q+j8aQAPrj2HVUD2SmYijpt=bH=rheqqU0toZGNaPyj2YA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Alexander,

aahringo@redhat.com wrote on Sun, 4 Sep 2022 21:10:55 -0400:

> Hi,
>=20
> On Sun, Sep 4, 2022 at 9:09 PM Alexander Aring <aahringo@redhat.com> wrot=
e:
> >
> > The current filtering level is set on the first interface up on a wpan
> > phy. If we support scan functionality we need to change the filtering
> > level on the fly on an operational phy and switching back again.
> >
> > This patch will move the receive mode parameter e.g. address filter and
> > promiscuous mode to the drv_start() functionality to allow changing the
> > receive mode on an operational phy not on first ifup only. In future th=
is
> > should be handled on driver layer because each hardware has it's own way
> > to enter a specific filtering level. However this should offer to switch
> > to mode IEEE802154_FILTERING_NONE and back to
> > IEEE802154_FILTERING_4_FRAME_FIELDS.
> >
> > Only IEEE802154_FILTERING_4_FRAME_FIELDS and IEEE802154_FILTERING_NONE
> > are somewhat supported by current hardware. All other filtering levels
> > can be supported in future but will end in IEEE802154_FILTERING_NONE as
> > the receive part can kind of "emulate" those receive paths by doing
> > additional filtering routines.
> >
> > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > ---
> >
> > RFC as code snippet as requested to somehow deal with the current
> > driver-ops and switching between filters with address filtering (AACK o=
n)
> > and non-address filtering (AACK off) which is necessary for scanning in
> > this case it will be NONE because that's what we currently support and I
> > hope it can useful for scanning receive mode.
> > =20
>=20
> based on wpan-next/master with:
>=20
> [PATCH wpan-next v2 01/11] net: mac802154: Introduce filtering levels
>=20
> applied.

Excellent! That was very helpful. I think I've found a nice way to use
those filtering levels, it's not something that we need for the scan to
work so I've queued those patches later, but in the end you were right,
it's much better than the ->promiscuous callback alone.

I've integrated your patches, let me come up with a final submission,
no worries about the v2, please just check v3 which will be much more
interesting.

Thanks,
Miqu=C3=A8l
