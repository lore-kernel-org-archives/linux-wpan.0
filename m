Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:49369 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbaKBD0O (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 1 Nov 2014 23:26:14 -0400
Received: by mail-wg0-f46.google.com with SMTP id x13so8887319wgg.19
        for <linux-wpan@vger.kernel.org>; Sat, 01 Nov 2014 20:26:13 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 00/16] ieee802154: introduce cfg802154 and address filter handling
Date: Sun,  2 Nov 2014 04:18:31 +0100
Message-Id: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This series introduce basic cfg802154 handling and add cfg802154 ops for
deprecated interface add/del netlink operations. Also reparing handling
with default channels and change handling for setup hardware address filter.
While change handling for setup hardware address filter this patch series
adds a function to validate the extended address while setting the extended
address over netdev_ops parameter.

Alexander Aring (16):
  at86rf230: fix page parameter constraints
  ieee802154: remove default channel settings
  at86rf230: add default channel settings
  cfg802154: introduce cfg802154_registered_device
  mac802154: introduce mac802154_config_ops
  ieee802154: add helper wpan_phy_to_rdev function
  cfg802154: convert deprecated iface add and del
  ieee802154: don't allow to change addr while netif_running
  mac802154: add helper for converting dev_addr
  mac802154: set extended address filter on ifup
  mac802154: set short address filter on ifup
  mac802154: set panid address filter on ifup
  mac802154: move phy settings into netlink receive
  ieee802154: add extended address validation helper
  mac802154: iface: add validation for extended address
  ieee802154: 6lowpan: remove set of mac address

 drivers/net/ieee802154/at86rf230.c |  5 ++-
 include/linux/ieee802154.h         | 14 ++++++++
 include/net/cfg802154.h            | 17 ++++++---
 include/net/mac802154.h            |  9 +++++
 net/ieee802154/6lowpan_rtnl.c      | 14 --------
 net/ieee802154/core.c              | 42 +++++++++++++---------
 net/ieee802154/core.h              | 26 ++++++++++++++
 net/ieee802154/nl-mac.c            | 10 ++++--
 net/ieee802154/nl-phy.c            | 19 ++++------
 net/ieee802154/rdev-ops.h          | 23 ++++++++++++
 net/ieee802154/sysfs.c             | 15 ++++++--
 net/mac802154/Makefile             |  2 +-
 net/mac802154/cfg.c                | 36 +++++++++++++++++++
 net/mac802154/cfg.h                |  9 +++++
 net/mac802154/ieee802154_i.h       |  5 ++-
 net/mac802154/iface.c              | 27 ++++++++-------
 net/mac802154/mac_cmd.c            | 22 +++++++++++-
 net/mac802154/main.c               | 11 +++---
 net/mac802154/mib.c                | 71 --------------------------------------
 19 files changed, 229 insertions(+), 148 deletions(-)
 create mode 100644 net/ieee802154/core.h
 create mode 100644 net/ieee802154/rdev-ops.h
 create mode 100644 net/mac802154/cfg.c
 create mode 100644 net/mac802154/cfg.h

-- 
2.1.3

