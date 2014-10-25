Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:39622 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbaJYDZf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Oct 2014 23:25:35 -0400
Received: by mail-lb0-f182.google.com with SMTP id f15so2277435lbj.13
        for <linux-wpan@vger.kernel.org>; Fri, 24 Oct 2014 20:25:33 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/6] ieee802154: trivial fixes
Date: Sat, 25 Oct 2014 05:25:06 +0200
Message-Id: <1414207512-10281-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch series contains checkpatch fixes and typos for the
ieee802154/mac802154 branch.

Alexander Aring (6):
  ieee802154: mac802154: remove FSF address
  ieee802154: ieee802154_dev: fix align typo
  mac802154: fix typo IEEE802515 to IEEE802154
  ieee802154: wpan-phy: change to __aligned(size)
  ieee802154: wpan-phy: use blank line after function
  ieee802154: wpan-class: fix trailing semicolon

 drivers/net/ieee802154/at86rf230.c | 12 ++++--------
 drivers/net/ieee802154/cc2520.c    |  8 ++++----
 drivers/net/ieee802154/fakelb.c    |  4 ----
 drivers/net/ieee802154/mrf24j40.c  | 12 ++++--------
 include/linux/nl802154.h           |  4 ----
 include/net/af_ieee802154.h        |  4 ----
 include/net/ieee802154.h           |  4 ----
 include/net/ieee802154_netdev.h    |  4 ----
 include/net/mac802154.h            | 11 ++++-------
 include/net/nl802154.h             |  4 ----
 include/net/wpan-phy.h             |  7 ++-----
 net/ieee802154/af802154.h          |  4 ----
 net/ieee802154/af_ieee802154.c     |  4 ----
 net/ieee802154/dgram.c             |  4 ----
 net/ieee802154/ieee802154.h        |  4 ----
 net/ieee802154/netlink.c           |  4 ----
 net/ieee802154/nl-mac.c            |  4 ----
 net/ieee802154/nl-phy.c            |  4 ----
 net/ieee802154/nl_policy.c         |  4 ----
 net/ieee802154/raw.c               |  4 ----
 net/ieee802154/wpan-class.c        |  6 +-----
 net/mac802154/ieee802154_dev.c     |  6 +-----
 net/mac802154/mac802154.h          |  4 ----
 net/mac802154/mac_cmd.c            |  4 ----
 net/mac802154/mib.c                | 10 +++-------
 net/mac802154/monitor.c            |  4 ----
 net/mac802154/rx.c                 |  4 ----
 net/mac802154/tx.c                 |  4 ----
 net/mac802154/wpan.c               |  4 ----
 29 files changed, 23 insertions(+), 133 deletions(-)

-- 
2.1.2

