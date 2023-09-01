Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BD2CA0FEC
	for <linux-wpan@archiver.kernel.org>; Fri,  1 Sep 2023 17:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348558AbjIARFP (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 1 Sep 2023 13:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348800AbjIARFO (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 1 Sep 2023 13:05:14 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DB410FA;
        Fri,  1 Sep 2023 10:05:10 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CBF2EC0004;
        Fri,  1 Sep 2023 17:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693587909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=I7/I+UM9wwbkvHibXqN93gDSTFG9J4mncNX6BBurVVI=;
        b=m/mQKOQBEpVWJedqR1k4xdNYuLOWZksFPs5Zf+2fpqzTl3XXVSke3Mf5VB/hwgPQ/VIoyR
        8IR/I+Eu/oklV1BL+9PzVrSdVOOj+tYfpebBwpxnZrnWrcwEBFxplX/cg1SF/s0QxoJpKr
        kgaHTrUTD2dZfsw5/ZG1i3xERyTGKyMISMXobb4d9++o0WiiBjPH1FeQ597pY2h3jLrcb5
        wlOGs/WrZIM68atQxeTNcAfvYDMkytTDihLxuHEQEbF/qmmgV3svIMjAQ6sWuE4hcoxJ5g
        MMnPn0QgdImSCFOl8DEcCBmQ/wU+Pww61PmC+omCI7/NPWfA7BzW4KP36sxx4g==
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-next v2 00/11] ieee802154: Associations between devices
Date:   Fri,  1 Sep 2023 19:04:50 +0200
Message-Id: <20230901170501.1066321-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello,

[I know we are in the middle of the merge window, I don't think it
matters on the wpan side, so as the wpan subsystem did not evolve
much since the previous merge window I figured I would not delay the
sending of this series given the fact that I should have send it at the
beginning of the summer...]

Now that we can discover our peer coordinators or make ourselves
dynamically discoverable, we may use the information about surrounding
devices to create PANs dynamically. This involves of course:
* Requesting an association to a coordinator, waiting for the response
* Sending a disassociation notification to a coordinator
* Receiving an association request when we are coordinator, answering
  the request (for now all devices are accepted up to a limit, to be
  refined)
* Sending a disassociation notification to a child
* Users may request the list of associated devices (the parent and the
  children).

Here are a few example of userspace calls that can be made:
iwpan dev <dev> associate pan_id 2 coord $COORD
iwpan dev <dev> list_associations
iwpan dev <dev> disassociate ext_addr $COORD

I used a small using hwsim to scan for a coordinator, associate with
it, look at the associations on both sides, disassociate from it and
check the associations again:
./assoc-demo
*** Scan ***
PAN 0x0002 (on wpan1)
	coordinator 0x060f3b35169a498f
	page 0
	channel 13
	preamble code 0
	mean prf 0
	superframe spec. 0xcf11
	LQI ff
*** End of scan ***
Associating wpan1 with coord0 0x060f3b35169a498f...
Dumping coord0 assoc:
child : 0x0b6f / 0xba7633ae47ccfb21
Dumping wpan1 assoc:
parent: 0xffff / 0x060f3b35169a498f
Disassociating from wpan1
Dumping coord0 assoc:
Dumping wpan1 assoc:

I could also successfully interact with a smaller device running Zephir,
using its command line interface to associate and then disassociate from
the Linux coordinator.

Thanks!
Miquèl

Changes in v2:
* Drop the misleading IEEE802154_ADDR_LONG_BROADCAST definition and its
  only use which was useless anyway.
* Clarified how devices are defined when the user requests to associate
  with a coordinator: for now only the extended address of the
  coordinator is relevant so this is the only address we care about.
* Drop a useless NULL check before a kfree() call.
* Add a check when allocating a child short address: it must be
  different than ours.
* Rebased on top of v6.5.

Miquel Raynal (11):
  ieee802154: Let PAN IDs be reset
  ieee802154: Internal PAN management
  ieee802154: Add support for user association requests
  mac802154: Handle associating
  ieee802154: Add support for user disassociation requests
  mac802154: Handle disassociations
  mac802154: Handle association requests from peers
  ieee802154: Add support for limiting the number of associated devices
  mac802154: Follow the number of associated devices
  mac802154: Handle disassociation notifications from peers
  ieee802154: Give the user the association list

 include/net/cfg802154.h         |  70 ++++++
 include/net/ieee802154_netdev.h |  60 +++++
 include/net/nl802154.h          |  22 +-
 net/ieee802154/Makefile         |   2 +-
 net/ieee802154/core.c           |  25 ++
 net/ieee802154/nl802154.c       | 229 +++++++++++++++++-
 net/ieee802154/pan.c            | 106 +++++++++
 net/ieee802154/rdev-ops.h       |  30 +++
 net/ieee802154/trace.h          |  38 +++
 net/mac802154/cfg.c             | 173 ++++++++++++++
 net/mac802154/ieee802154_i.h    |  27 +++
 net/mac802154/main.c            |   2 +
 net/mac802154/rx.c              |  25 ++
 net/mac802154/scan.c            | 400 ++++++++++++++++++++++++++++++++
 14 files changed, 1196 insertions(+), 13 deletions(-)
 create mode 100644 net/ieee802154/pan.c

-- 
2.34.1

