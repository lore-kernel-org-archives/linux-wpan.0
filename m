Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD7DC3DA7A
	for <linux-wpan@archiver.kernel.org>; Fri,  6 Jan 2023 11:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbjAFLSn (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 6 Jan 2023 06:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbjAFLSl (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 6 Jan 2023 06:18:41 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C4C625DC
        for <linux-wpan@vger.kernel.org>; Fri,  6 Jan 2023 03:18:36 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EB37B240008;
        Fri,  6 Jan 2023 11:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673003914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=JGVSwsmNl5D9Z/XQ1EyUlJLNG9NaVhYTpoJOcrapQf4=;
        b=QPtU91QRP5EpbtF9Yu+zMmx0+/CpE4NBTW21ZBGuSaY237zYzoPXo8y0RGOV4w8YyK5+q4
        EJxEoketQJV7x6q+a76GqzbYl2hwJdOQWm31Es1TXvE3ySwnGLdT95kwYpWgnTyrtgiP+O
        YE+a8qFt1tAlPRoanrn+qG8uT0wbiaVnJ8M8fhg+eSHd8a9I5Wt47u57zVTQ8L0+5d7td/
        XUssGHl9eb+ofZRhvRBSpYep0mRqE9PuCUz9IU5C+PR91bC9r4bJ00YYmUdVEFrAYb+1MV
        kCRbfhpl8Z1DW6ITIaLrI8N9U9QVXIovqNUmc1miwqeM3iSV3V2HuLciWLkqOA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org
Cc:     David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-tools v2 0/8] iwpan: Scan support
Date:   Fri,  6 Jan 2023 12:18:23 +0100
Message-Id: <20230106111831.692202-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello,

This series follows the work done in the Linux kernel stack [1]: now
that the core knows about the different netlink commands and attributes
in order to support scanning requests, we can sync the userspace tools
to use them.

As part of these additions, a few cleanup patches are introducing the
series, including a first sync with a recent change in nl802154.h.

[1] https://lore.kernel.org/linux-wpan/ec93100f-8c55-2f54-d3d5-63f31c2602f4@datenfreihafen.org/T/#t

Cheers,
Miquèl

Changes in v2:
* Adapted to the latest kernel changes.
* Added a real "monitor" command in place of the scan done command.
* Renamed iwpan event into iwpan monitor.
* Dropped an unused function.
* Changed the behavior of the scan monitor call.
* Added SIGINT support to send an abort.
* Avoided a race in the scan command by using pthread when starting to
  monitor, before triggering the scan operation.
* Dropped beaconing support for this first version.

David Girault (4):
  iwpan: Export iwpan_debug
  iwpan: Remove duplicated SECTION
  iwpan: Add scan support
  iwpan: Add events support

Miquel Raynal (3):
  iwpan: Synchronize nl802154.h with the latest kernel
  iwpan: Fix a comment
  iwpan: Synchronize nl802154.h with the latest scan changes

Romuald Despres (1):
  iwpan: Fix the channels printing

 src/Makefile.am |   2 +
 src/event.c     | 230 ++++++++++++++++++++
 src/info.c      |   2 +-
 src/iwpan.c     |   2 +-
 src/iwpan.h     |  10 +-
 src/nl802154.h  | 107 +++++++++-
 src/scan.c      | 548 ++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 888 insertions(+), 13 deletions(-)
 create mode 100644 src/event.c
 create mode 100644 src/scan.c

-- 
2.34.1

