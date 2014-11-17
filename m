Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:42881 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbaKQHVY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 17 Nov 2014 02:21:24 -0500
Received: by mail-wg0-f52.google.com with SMTP id a1so353578wgh.25
        for <linux-wpan@vger.kernel.org>; Sun, 16 Nov 2014 23:21:23 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 00/13] ieee802154: cleanups, nl802154 iface handling and byteorder fixes
Date: Mon, 17 Nov 2014 08:20:42 +0100
Message-Id: <1416208855-8623-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch series contains various cleanups and adding new nl802154 commands
for supporting interface handling. At least we fix some byteorder issues.
The nl802154 interface uses little endian byteorder now. This is the same
byteorder like 802.15.4 MAC layer. The nl802154 interface is new, so we should
fix the byteorder issue now.

Alexander Aring (13):
  mac802154: remove unused prototypes
  at86rf230: fix commentation for symbol duration
  mac802154: remove const for non pointer in driver-ops
  mac802154: remove const for non pointer in cfg ops
  mac802154: remove const for non pointer in rdev-ops
  mac802154: remove deprecated linux-zigbee info
  mac802154: use new nl802154 iftype types
  mac802154: remove wpan_dev parameter in if_add
  ieee802154: add new interface command
  ieee802154: setting extended address while iface add
  ieee802154: add del interface command
  ieee802154: rename and move WPAN_NUM_ defines
  ieee802154: fix byteorder for short address and panid

 drivers/net/ieee802154/at86rf230.c |  4 +-
 include/linux/ieee802154.h         |  3 ++
 include/net/cfg802154.h            | 21 +++++-----
 net/ieee802154/nl802154.c          | 80 +++++++++++++++++++++++++++++++++++---
 net/ieee802154/rdev-ops.h          | 33 ++++++++++------
 net/mac802154/cfg.c                | 69 ++++++++++++++++++++++----------
 net/mac802154/driver-ops.h         | 46 ++++++++++------------
 net/mac802154/ieee802154_i.h       | 15 +++----
 net/mac802154/iface.c              | 31 ++++++++-------
 net/mac802154/main.c               |  7 ++--
 net/mac802154/rx.c                 |  7 ++--
 11 files changed, 211 insertions(+), 105 deletions(-)

-- 
2.1.3

