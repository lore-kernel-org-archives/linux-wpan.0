Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:59514 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752392AbeBZPvm (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 26 Feb 2018 10:51:42 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: pull-request: ieee802154-next 2018-02-26
Date: Mon, 26 Feb 2018 16:41:35 +0100
Message-Id: <20180226154135.13798-1-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: davem@davemloft.net
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, netdev@vger.kernel.org

Hello Dave.

An update from ieee802154 for *net-next*

Alexander corrected a setting which got lost during some 6lowpan rework
a while back and Xue Liu provided us with a new driver for the MCR20A
transceiver.

If there are any issues let me know. If not, please pull.

regards
Stefan Schmidt

The following changes since commit 77079683617b60387ad23e91cc5b82693b3075ab:

  Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue (2018-02-13 22:31:23 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan-next.git ieee802154-for-davem-2018-02-26

for you to fetch changes up to 8c6ad9cc51574c8f20b5777e97b42457802ac36d:

  ieee802154: Add NXP MCR20A IEEE 802.15.4 transceiver driver (2018-02-21 09:08:39 +0100)

----------------------------------------------------------------
Alexander Aring (1):
      ieee802154: 6lowpan: set IFF_NO_QUEUE

Xue Liu (3):
      ieee802154: Add device tree documentation for MCR20A
      ieee802154: Add entry in MAINTAINTERS for MCR20a driver
      ieee802154: Add NXP MCR20A IEEE 802.15.4 transceiver driver

 .../devicetree/bindings/net/ieee802154/mcr20a.txt  |   23 +
 MAINTAINERS                                        |    9 +
 drivers/net/ieee802154/Kconfig                     |   11 +
 drivers/net/ieee802154/Makefile                    |    1 +
 drivers/net/ieee802154/mcr20a.c                    | 1413 ++++++++++++++++++++
 drivers/net/ieee802154/mcr20a.h                    |  498 +++++++
 net/ieee802154/6lowpan/core.c                      |    1 +
 7 files changed, 1956 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ieee802154/mcr20a.txt
 create mode 100644 drivers/net/ieee802154/mcr20a.c
 create mode 100644 drivers/net/ieee802154/mcr20a.h
