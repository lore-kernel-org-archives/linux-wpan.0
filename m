Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4591FE6FE54
	for <linux-wpan@archiver.kernel.org>; Fri, 22 Sep 2023 15:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjIVPTo (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 22 Sep 2023 11:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbjIVPTn (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 22 Sep 2023 11:19:43 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E374518F;
        Fri, 22 Sep 2023 08:19:36 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B75F240009;
        Fri, 22 Sep 2023 15:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695395975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b+tJrUykBU2gtCZ7qn5sx98jSH7/WUTzPHE8qZit5Qg=;
        b=hE+tOBNQopI/5Xd6Q/CBT7xyru0+1vtMZs7O3YjwVvSkBHmC9jEW4YJWqnRuHj3sqBfn+I
        oCLlEPZqi9s7xm8fJOwWGhVOp/8+xeR6I2PARGrAZQNxAyo5qppq6+XieNuHcoRX3fKI42
        LMkzLdgq6Mgjq5DvQ5tzerKUxgpoJ0n+0XVPrJKDljApmu3NPKLagvkIPV+NWt5qIB4oED
        AJQDYQdcl1lcgCJZibCCjtW0429YE0vkrEJvPr8AyM+BxB2gyE3C1KdPRIzhlF+IxeWlfD
        Z5aaN87wFCycqhLXtzPIwYbiJSFNuHcgq1RHAYxqlrNFSGwCpMpdexyBPsvFnw==
Date:   Fri, 22 Sep 2023 17:19:32 +0200
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
Subject: Re: [PATCH wpan-next v3 00/11] ieee802154: Associations between
 devices
Message-ID: <20230922171932.48da03dd@xps-13>
In-Reply-To: <92d125a3-bd3f-63ba-0a5f-9f05068a6282@datenfreihafen.org>
References: <20230918150809.275058-1-miquel.raynal@bootlin.com>
        <92d125a3-bd3f-63ba-0a5f-9f05068a6282@datenfreihafen.org>
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

stefan@datenfreihafen.org wrote on Wed, 20 Sep 2023 20:46:20 +0200:

> Hello Miquel
>=20
> On 18.09.23 17:07, Miquel Raynal wrote:
> > Hello,
> >=20
> > [I know we are in the middle of the merge window, I don't think it
> > matters on the wpan side, so as the wpan subsystem did not evolve
> > much since the previous merge window I figured I would not delay the
> > sending of this series given the fact that I should have send it at the
> > beginning of the summer...]
> >=20
> > Now that we can discover our peer coordinators or make ourselves
> > dynamically discoverable, we may use the information about surrounding
> > devices to create PANs dynamically. This involves of course:
> > * Requesting an association to a coordinator, waiting for the response
> > * Sending a disassociation notification to a coordinator
> > * Receiving an association request when we are coordinator, answering
> >    the request (for now all devices are accepted up to a limit, to be
> >    refined)
> > * Sending a disassociation notification to a child
> > * Users may request the list of associated devices (the parent and the
> >    children).
> >=20
> > Here are a few example of userspace calls that can be made:
> > iwpan dev <dev> associate pan_id 2 coord $COORD
> > iwpan dev <dev> list_associations
> > iwpan dev <dev> disassociate ext_addr $COORD
> >=20
> > I used a small using hwsim to scan for a coordinator, associate with
> > it, look at the associations on both sides, disassociate from it and
> > check the associations again:
> > ./assoc-demo
> > *** Scan ***
> > PAN 0x0002 (on wpan1)
> > 	coordinator 0x060f3b35169a498f
> > 	page 0
> > 	channel 13
> > 	preamble code 0
> > 	mean prf 0
> > 	superframe spec. 0xcf11
> > 	LQI ff
> > *** End of scan ***
> > Associating wpan1 with coord0 0x060f3b35169a498f...
> > Dumping coord0 assoc:
> > child : 0x0b6f / 0xba7633ae47ccfb21
> > Dumping wpan1 assoc:
> > parent: 0xffff / 0x060f3b35169a498f
> > Disassociating from wpan1
> > Dumping coord0 assoc:
> > Dumping wpan1 assoc:
> >=20
> > I could also successfully interact with a smaller device running Zephir,
> > using its command line interface to associate and then disassociate from
> > the Linux coordinator.
> >=20
> > Thanks!
> > Miqu=C3=A8l
> >=20
> > Changes in v3:
> > * Clarify a helper which compares if two devices seem to be identical by
> >    adding two comments. This is a static function that is only used by
> >    the PAN management core to operate or not an
> >    association/disassociation request. In this helper, a new check is
> >    introduced to be sure we compare fields which have been populated.
> > * Dropped the "association_generation" counter and all its uses along
> >    the code. I tried to mimic some other counter but I agree it is not
> >    super useful and could be dropped anyway.
> > * Dropped a faulty sequence number hardcoded to 10. This had no impact
> >    because a few lines later the same entry was set to a valid value.
> >=20
> > Changes in v2:
> > * Drop the misleading IEEE802154_ADDR_LONG_BROADCAST definition and its
> >    only use which was useless anyway.
> > * Clarified how devices are defined when the user requests to associate
> >    with a coordinator: for now only the extended address of the
> >    coordinator is relevant so this is the only address we care about.
> > * Drop a useless NULL check before a kfree() call.
> > * Add a check when allocating a child short address: it must be
> >    different than ours.
> > * Rebased on top of v6.5.
> >=20
> > Miquel Raynal (11):
> >    ieee802154: Let PAN IDs be reset
> >    ieee802154: Internal PAN management
> >    ieee802154: Add support for user association requests
> >    mac802154: Handle associating
> >    ieee802154: Add support for user disassociation requests
> >    mac802154: Handle disassociations
> >    mac802154: Handle association requests from peers
> >    ieee802154: Add support for limiting the number of associated devices
> >    mac802154: Follow the number of associated devices
> >    mac802154: Handle disassociation notifications from peers
> >    ieee802154: Give the user the association list
> >=20
> >   include/net/cfg802154.h         |  69 ++++++
> >   include/net/ieee802154_netdev.h |  60 +++++
> >   include/net/nl802154.h          |  22 +-
> >   net/ieee802154/Makefile         |   2 +-
> >   net/ieee802154/core.c           |  24 ++
> >   net/ieee802154/nl802154.c       | 223 +++++++++++++++++-
> >   net/ieee802154/pan.c            | 115 +++++++++
> >   net/ieee802154/rdev-ops.h       |  30 +++
> >   net/ieee802154/trace.h          |  38 +++
> >   net/mac802154/cfg.c             | 170 ++++++++++++++
> >   net/mac802154/ieee802154_i.h    |  27 +++
> >   net/mac802154/main.c            |   2 +
> >   net/mac802154/rx.c              |  25 ++
> >   net/mac802154/scan.c            | 397 ++++++++++++++++++++++++++++++++
> >   14 files changed, 1191 insertions(+), 13 deletions(-)
> >   create mode 100644 net/ieee802154/pan.c =20
>=20
> With my requests for patch 02/11 taken into account and the fallout for t=
he experimental config options fixed (as krobot detected) I am happy with t=
his patchset.
>=20
> Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>

Great! Thanks a lot for the time spent.

Cheers,
Miqu=C3=A8l
