Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:51220 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752549AbdKIRWZ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 9 Nov 2017 12:22:25 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: pull-request: net-next: ieee802154 2017-11-09
Date: Thu,  9 Nov 2017 18:12:49 +0100
Message-Id: <20171109171249.26164-1-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: davem@davemloft.net
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, netdev@vger.kernel.org

A small update on ieee802154 patches for net-next. Nothing dramatic, but simply
housekeeping this time around.
A fix for the correct mask to be applied in the mrf24j40 driver by Gustavo A. R. Silva
Removal of a non existing email user for the ca8210 driver by Harry Morris
A bunch of checkpatch cleanups across the subsystem from myself

Please pull, thanks a lot!

regards
Stefan Schmidt

The following changes since commit 2798b80b385384d51a81832556ee9ad25d175f9b:

  Merge branch 'eBPF-based-device-cgroup-controller' (2017-11-05 23:26:51 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan-next.git ieee802154-for-davem-2017-11-09

for you to fetch changes up to 7558bd50201f0b21129a9a5c220c11cf3bfc6efe:

  ieee802154: ca8210: use __func__ macro for debug messages (2017-11-06 16:39:14 +0100)

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      ieee802154: mrf24j40: fix incorrect mask in mrf24j40_stop

Harry Morris (1):
      MAINTAINERS: Update ca8210 driver contact emails

Stefan Schmidt (10):
      ieee802154: atusb: switch from uint8_t to u8
      ieee802154: atusb: use __func__ macro for debug messages
      ieee802154: atusb: fix some kernel coding style errors
      ieee802154: atusb: switch from BUG_ON() to WARN_ON() on problem
      ieee802154: cc2520: fix some kernel coding style errors
      ieee802154: cc2520: use __func__ macro for debug messages
      ieee802154: cc2520: switch from BUG_ON() to WARN_ON() on problem
      ieee802154: adf7242: use unsigned int over only unsigned
      ieee802154: ca8210: fix some kernel coding style errors
      ieee802154: ca8210: use __func__ macro for debug messages

 MAINTAINERS                       |  1 -
 drivers/net/ieee802154/adf7242.c  |  8 ++--
 drivers/net/ieee802154/atusb.c    | 77 +++++++++++++++++++--------------------
 drivers/net/ieee802154/ca8210.c   | 20 +++++-----
 drivers/net/ieee802154/cc2520.c   | 21 +++++------
 drivers/net/ieee802154/mrf24j40.c |  2 +-
 6 files changed, 63 insertions(+), 66 deletions(-)
