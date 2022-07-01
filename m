Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8788BCCA47B
	for <linux-wpan@archiver.kernel.org>; Fri,  1 Jul 2022 14:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbiGAOiK (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 1 Jul 2022 10:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiGAOh5 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 1 Jul 2022 10:37:57 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9F93B3CC
        for <linux-wpan@vger.kernel.org>; Fri,  1 Jul 2022 07:34:36 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D4AEE20000B;
        Fri,  1 Jul 2022 14:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656686075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FJQ+oK2OtC11aNE3cmHWBETwgaLvhkZG/0AxiMZLybE=;
        b=hPigvyqrFybe/NjpbEN317E5BdyX2v7v+4JhXQUWJWCuBxK0N5aHj/PgEd+72IKjgnc2/O
        ZJW5LKmkiJ5NJKjdL8EkxK1e3axNLmrX59nHFaBu6PzUvXzoSmiRa2pWe4tn44NS/sfk85
        dBm8o+MWet604caBwLAbXNDBMh80y01FePhVzHdUweentHNYAyKURX+kcvdOnIVJslI6zD
        /N9T6Meh8dRrPq/Ci6oAgmpWjO8ZILPN58haeSf42BdLPbQLgwJjadhVKbrmyV/Wc+a9vn
        k+c8AdI48XK0xWfan1MeFvwjZ5jcMy6rbzYuI86S82GfhK/KuujQ8pPwdQBW5g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org
Cc:     David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-tools 0/7] iwpan: Support scanning/beaconing
Date:   Fri,  1 Jul 2022 16:34:27 +0200
Message-Id: <20220701143434.1267864-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello,

This series follows the work done in the Linux kernel stack: now that
the core knows about the different netlink commands and attributes in
order to support scanning and beaconing requests from end-to-end, here
are the userspace changes to be able to use it.

Here is a list of the new available features.

* Sending (or stopping) beacons. Intervals ranging from 0 to 14 are
  valid for passively sending beacons at regular intervals. An interval
  of 15 would request the core to answer BEACON_REQ.
  # iwpan dev coord0 beacons send interval 2 # send BEACON at a fixed rate
  # iwpan dev coord0 beacons send interval 15 # answer BEACON_REQ only
  # iwpan dev coord0 beacons stop # apply to both cases

* Scanning all the channels or only a subset:
  # iwpan dev wpan1 scan type passive duration 3 # will not trigger BEACON_REQ
  # iwpan dev wpan1 scan type active duration 3 # will trigger BEACON_REQ

* During scans, there is a dedicated netlink channel event to listen to
  in order to get events like "a new coordinator was discovered" or "the
  scan is over". When beacons from new devices are received, the tool
  would print something like:
  PAN 0xabcd (on coord1)
	coordinator 0xe673d7a3f3a87ccc
	page 0
	channel 13
	preamble code 0
	mean prf 0
	superframe spec. 0x4f11
	LQI 0

* It is also possible to monitor the events with:
  # iwpan event

* As well as triggering a non blocking scan:
  # iwpan dev wpan1 scan trigger type passive duration 3
  # iwpan dev wpan1 scan done
  # iwpan dev wpan1 scan abort

Associations will be handled in another series.

Cheers,
Miquèl

David Girault (4):
  iwpan: Export iwpan_debug
  iwpan: Remove duplicated SECTION
  iwpan: Add full scan support
  iwpan: Add events support

Miquel Raynal (2):
  iwpan: Fix a comment
  iwpan: Synchronize nl802154 header with the Linux kernel

Romuald Despres (1):
  iwpan: Fix the channels printing

 src/Makefile.am |   2 +
 src/event.c     | 222 +++++++++++++++++++++++++
 src/info.c      |   2 +-
 src/iwpan.c     |   2 +-
 src/iwpan.h     |  13 +-
 src/mac.c       |   1 +
 src/nl802154.h  |  93 +++++++++++
 src/scan.c      | 420 ++++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 746 insertions(+), 9 deletions(-)
 create mode 100644 src/event.c
 create mode 100644 src/scan.c

-- 
2.34.1

