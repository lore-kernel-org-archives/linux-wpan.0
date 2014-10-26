Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:47422 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbaJZIQn (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 26 Oct 2014 04:16:43 -0400
Received: by mail-lb0-f179.google.com with SMTP id l4so4279678lbv.24
        for <linux-wpan@vger.kernel.org>; Sun, 26 Oct 2014 01:16:41 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 00/15] ieee802154: rework transmit handling
Date: Sun, 26 Oct 2014 09:15:37 +0100
Message-Id: <1414311352-908-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This series contains patches for reworking tx handling.
Also add a workaround to hold the xmit context when sending frames.
Additional add support for asynchronous xmit handling and change the
at86rf230 to do a asynchronous xmit handling.

Moving functions and renaming are necessary for the mac80211 naming
convention.

Alexander Aring (15):
  mac802154: tx: move xmit callback to tx file
  mac802154: tx: remove kmalloc in xmit hotpath
  mac802154: tx: squash multiple dereferencing
  mac802154: tx: remove xmit channel context switch
  mac802154: add netdev qeue helpers
  mac802154: tx: use queue helpers in xmit worker
  mac802154: tx: fix error handling while xmit
  mac802154: tx: add support for xmit_async callback
  mac802154: tx: don't allow if down while sync tx
  mac802154: tx: use netdev print helpers
  mac802154: tx: cleanup crc calculation
  mac802154: tx: move stats tx increment
  mac802154: tx: change naming convention
  mac802154: tx: add comment at sync xmit callback
  at86rf230: asynchronous xmit handling

 drivers/net/ieee802154/at86rf230.c |  42 +++++------
 drivers/net/ieee802154/cc2520.c    |   2 +-
 drivers/net/ieee802154/fakelb.c    |   2 +-
 drivers/net/ieee802154/mrf24j40.c  |   2 +-
 include/net/mac802154.h            |  28 +++++--
 net/mac802154/Makefile             |   2 +-
 net/mac802154/ieee802154_i.h       |   7 +-
 net/mac802154/iface.c              |  37 +---------
 net/mac802154/main.c               |   4 +-
 net/mac802154/monitor.c            |  29 +-------
 net/mac802154/tx.c                 | 146 ++++++++++++++++++++++---------------
 net/mac802154/util.c               |  55 ++++++++++++++
 12 files changed, 194 insertions(+), 162 deletions(-)
 create mode 100644 net/mac802154/util.c

-- 
2.1.2

