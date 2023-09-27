Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB59BE82CAE
	for <linux-wpan@archiver.kernel.org>; Wed, 27 Sep 2023 16:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjI0Qtn (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 27 Sep 2023 12:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjI0Qtn (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 27 Sep 2023 12:49:43 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095F692;
        Wed, 27 Sep 2023 09:49:40 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B9E921BF20F;
        Wed, 27 Sep 2023 16:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695833379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e8L5ZWdpo4N4GFeHWJm5tH9g9V1bEgLFF4uB75vchXU=;
        b=akPzOryUHEM0DKSx2WIXrrSm1KKhjjR9+gwyd6wYgWjWgduqjkKtYxh0STZMpZHvxvw4sk
        /N5uKNJZ3QZHZ8MXGgrGCi0u1YOU40Op2ZbrK5rYX7zFeQfTGb5dz0/ebI2P9QUdXg2NGj
        QCnwHuvx+qcgC30K9igZGDVt3yuMIKwkJbqMMuPXP0uaIn9OYZ8DQZMSl9aHh8G4XfWutx
        fmUd6zVW1xUHWGixn36Pok+pfffJYUfGdDuQPsoA1hlR12fxrae57WpkUURRrk4HdVxpAS
        BenLTn5W9mXZo0wA5/KtnYTH1Q3k21aFx7ZcpCHLdgX3F2Bfu6l7cYIgZ3WUVw==
Date:   Wed, 27 Sep 2023 18:49:32 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH wpan-next v5 00/11] ieee802154: Associations between
 devices
Message-ID: <20230927184932.75398c98@xps-13>
In-Reply-To: <20230927164714.128476-1-miquel.raynal@bootlin.com>
References: <20230927164714.128476-1-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello,

Send e-mail failed in the middle of the operation because of
connectivity issues, I'll resend the full thread later. Please ignore
this.

Sorry for the noise,
Miqu=C3=A8l

miquel.raynal@bootlin.com wrote on Wed, 27 Sep 2023
18:47:03 +0200:

> Hello,
>=20
> Now that we can discover our peer coordinators or make ourselves
> dynamically discoverable, we may use the information about surrounding
> devices to create PANs dynamically. This involves of course:
> * Requesting an association to a coordinator, waiting for the response
> * Sending a disassociation notification to a coordinator
> * Receiving an association request when we are coordinator, answering
>   the request (for now all devices are accepted up to a limit, to be
>   refined)
> * Sending a disassociation notification to a child
> * Users may request the list of associated devices (the parent and the
>   children).
>=20
> Here are a few example of userspace calls that can be made:
> iwpan dev <dev> associate pan_id 2 coord $COORD
> iwpan dev <dev> list_associations
> iwpan dev <dev> disassociate ext_addr $COORD
>=20
> I used a small using hwsim to scan for a coordinator, associate with
> it, look at the associations on both sides, disassociate from it and
> check the associations again:
> ./assoc-demo
> *** Scan ***
> PAN 0x0002 (on wpan1)
> 	coordinator 0x060f3b35169a498f
> 	page 0
> 	channel 13
> 	preamble code 0
> 	mean prf 0
> 	superframe spec. 0xcf11
> 	LQI ff
> *** End of scan ***
> Associating wpan1 with coord0 0x060f3b35169a498f...
> Dumping coord0 assoc:
> child : 0x0b6f / 0xba7633ae47ccfb21
> Dumping wpan1 assoc:
> parent: 0xffff / 0x060f3b35169a498f
> Disassociating from wpan1
> Dumping coord0 assoc:
> Dumping wpan1 assoc:
>=20
> I could also successfully interact with a smaller device running Zephir,
> using its command line interface to associate and then disassociate from
> the Linux coordinator.
>=20
> Thanks!
> Miqu=C3=A8l
>=20
> Changes in v5:
> * Fixed (again) the helper supposed to check whether a device requesting
>   association/disassociation is already (or not) in our PAN. We don't
>   nee to check short addresses there.
> * Changed the name of the helper a second time to make it more relevant
>   and understandable:
>   cfg802154_device_in_pan() -> cfg802154_pan_device_is_matching()
> * Fixed a kernel test robot report where we would use an int instead of
>   a __le16. Solved that by using cpu_to_le16 like in the other places
>   where we use definitions as arguments.
>=20
> Changes in v4:
> * Ensured any disassociation would only be processed if the destination
>   pan ID matches ours.
> * Association requests should be made using extended addressing, it's
>   the specification, so ensure this is true. Doing so helps reducing the
>   checks down the road.
> * Updated a copyright from 2021 to 2023.
> * Improved the comment for cfg802154_device_in_pan() and only accept
>   extended addressing when using this internal function because there is
>   no point in checking short addresses here.
> * Move nl802154_prepare_wpan_dev_dump() and
>   nl802154_finish_wpan_dev_dump() outside of a
>   CONFIG_IEEE802154_NL802154_EXPERIMENTAL #ifdef bloc as now used in
>   regular code (not only experimental).
> * Added a missing return value in the kernel doc of
>   cfg802154_device_is_associated().
>=20
> Changes in v3:
> * Clarify a helper which compares if two devices seem to be identical by
>   adding two comments. This is a static function that is only used by
>   the PAN management core to operate or not an
>   association/disassociation request. In this helper, a new check is
>   introduced to be sure we compare fields which have been populated.
> * Dropped the "association_generation" counter and all its uses along
>   the code. I tried to mimic some other counter but I agree it is not
>   super useful and could be dropped anyway.
> * Dropped a faulty sequence number hardcoded to 10. This had no impact
>   because a few lines later the same entry was set to a valid value.
>=20
> Changes in v2:
> * Drop the misleading IEEE802154_ADDR_LONG_BROADCAST definition and its
>   only use which was useless anyway.
> * Clarified how devices are defined when the user requests to associate
>   with a coordinator: for now only the extended address of the
>   coordinator is relevant so this is the only address we care about.
> * Drop a useless NULL check before a kfree() call.
> * Add a check when allocating a child short address: it must be
>   different than ours.
> * Rebased on top of v6.5.
>=20
>=20
> Miquel Raynal (11):
>   ieee802154: Let PAN IDs be reset
>   ieee802154: Internal PAN management
>   ieee802154: Add support for user association requests
>   mac802154: Handle associating
>   ieee802154: Add support for user disassociation requests
>   mac802154: Handle disassociations
>   mac802154: Handle association requests from peers
>   ieee802154: Add support for limiting the number of associated devices
>   mac802154: Follow the number of associated devices
>   mac802154: Handle disassociation notifications from peers
>   ieee802154: Give the user the association list
>=20
>  include/net/cfg802154.h         |  70 ++++++
>  include/net/ieee802154_netdev.h |  60 +++++
>  include/net/nl802154.h          |  22 +-
>  net/ieee802154/Makefile         |   2 +-
>  net/ieee802154/core.c           |  24 ++
>  net/ieee802154/nl802154.c       | 225 +++++++++++++++++-
>  net/ieee802154/pan.c            | 103 +++++++++
>  net/ieee802154/rdev-ops.h       |  30 +++
>  net/ieee802154/trace.h          |  38 +++
>  net/mac802154/cfg.c             | 170 ++++++++++++++
>  net/mac802154/ieee802154_i.h    |  27 +++
>  net/mac802154/main.c            |   2 +
>  net/mac802154/rx.c              |  25 ++
>  net/mac802154/scan.c            | 397 ++++++++++++++++++++++++++++++++
>  14 files changed, 1180 insertions(+), 15 deletions(-)
>  create mode 100644 net/ieee802154/pan.c
>=20
