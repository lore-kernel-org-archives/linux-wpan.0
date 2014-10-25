Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:50199 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbaJYTHE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 25 Oct 2014 15:07:04 -0400
Received: by mail-la0-f48.google.com with SMTP id gi9so4054682lab.21
        for <linux-wpan@vger.kernel.org>; Sat, 25 Oct 2014 12:07:02 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 00/10] ieee802154: removals and renames
Date: Sat, 25 Oct 2014 17:16:32 +0200
Message-Id: <1414250202-32384-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch series removes the not working/not finished hardMAC virtual driver
"fakehard". Additional we remove the not used ieee802154_addr driver callback ops.
The other patches are rename patches for avoiding mainly the "priv variable naming
hell" inside the 802.15.4 subsystem. This series introduce 802.11 naming style for
used structs and variable naming.

This serie based on "[PATCHv2 bluetooth-next 0/7] ieee802154: file movements" patch
serie.

Alexander Aring (10):
  ieee802154: remove fakehard driver
  ieee802154: rename ieee802154_dev to ieee802154_hw
  mac802154: rename mac802154_priv to ieee802154_local
  mac802154: rename mac802154_sub_if_data
  mac802154: rename hw subif_data variable to local
  mac802154: rename sdata slaves and slaves_mtx
  mac802154: introduce hw_to_local function
  mac802154: introduce IEEE802154_DEV_TO_SUB_IF
  mac802154: rename dev_workqueue to workqueue
  mac802154: remove ieee802154_addr from driver_ops

 drivers/net/ieee802154/Kconfig     |  10 -
 drivers/net/ieee802154/Makefile    |   1 -
 drivers/net/ieee802154/at86rf230.c |  90 ++++----
 drivers/net/ieee802154/cc2520.c    |  50 ++---
 drivers/net/ieee802154/fakehard.c  | 427 -------------------------------------
 drivers/net/ieee802154/fakelb.c    |  78 +++----
 drivers/net/ieee802154/mrf24j40.c  |  48 ++---
 include/net/mac802154.h            |  43 ++--
 net/mac802154/ieee802154_i.h       |  34 +--
 net/mac802154/iface.c              | 141 ++++++------
 net/mac802154/mac_cmd.c            |   4 +-
 net/mac802154/main.c               | 265 +++++++++++------------
 net/mac802154/mib.c                | 206 +++++++++---------
 net/mac802154/monitor.c            |  26 +--
 net/mac802154/rx.c                 |  22 +-
 net/mac802154/tx.c                 |  40 ++--
 16 files changed, 522 insertions(+), 963 deletions(-)
 delete mode 100644 drivers/net/ieee802154/fakehard.c

-- 
2.1.2

