Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:54818 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752148AbdIVMOP (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 22 Sep 2017 08:14:15 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH 00/14] Checkpatch cleanup for ieee802154 drivers
Date: Fri, 22 Sep 2017 14:13:51 +0200
Message-Id: <20170922121405.31789-1-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aring@mojatatu.com>, michael.hennerich@analog.com, h.morris@cascoda.com, linuxdev@cascoda.com, varkabhadram@gmail.com, alan@signal11.us, Stefan Schmidt <stefan@osg.samsung.com>

Hello.

This patchset works through various warnings and errors reported from checkpatch
on all ieee802154 drivers. Testing and ACKs from the repective driver
maintainers would be appreciated.

Stefan Schmidt (14):
  ieee802154: adf7242: use unsigned int over only unsigned
  ieee802154: at86rf230: switch from BUG_ON() to WARN_ON() on problem
  ieee802154: at86rf230: use __func__ macro for debug messages
  ieee802154: atusb: switch from uint8_t to u8
  ieee802154: atusb: use __func__ macro for debug messages
  ieee802154: atusb: fix some kernel coding style errors
  ieee802154: atusb: switch from BUG_ON() to WARN_ON() on problem
  ieee802154: mrf24j40: fix some kernel coding style errors
  ieee802154: ca8210: fix some kernel coding style errors
  ieee802154: ca8210: use __func__ macro for debug messages
  ieee802154: cc2520: fix some kernel coding style errors
  ieee802154: cc2520: use __func__ macro for debug messages
  ieee802154: cc2520: switch from BUG_ON() to WARN_ON() on problem
  ieee802154: fakelb: switch from BUG_ON() to WARN_ON() on problem

 drivers/net/ieee802154/adf7242.c   |  8 ++--
 drivers/net/ieee802154/at86rf230.c | 15 +++-----
 drivers/net/ieee802154/atusb.c     | 77 +++++++++++++++++++-------------------
 drivers/net/ieee802154/ca8210.c    | 20 +++++-----
 drivers/net/ieee802154/cc2520.c    | 21 +++++------
 drivers/net/ieee802154/fakelb.c    |  2 +-
 drivers/net/ieee802154/mrf24j40.c  | 18 +++++----
 7 files changed, 79 insertions(+), 82 deletions(-)

regards
Stefan Schmidt
-- 
2.13.5

