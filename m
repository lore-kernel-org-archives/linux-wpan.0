Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:50959 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbeI1Qnz (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 28 Sep 2018 12:43:55 -0400
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: pull-request: ieee802154 for net 2018-09-28
Date: Fri, 28 Sep 2018 12:20:42 +0200
Message-Id: <20180928102043.25080-1-stefan@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: davem@davemloft.net
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, netdev@vger.kernel.org

Hello Dave.

An update from ieee802154 for your *net* tree.

Some cleanup patches throughout the drivers from the Huawei tag team
Yue Haibing and Zhong Jiang.
Xue is replacing some magic numbers with defines in his mcr20a driver.

regards
Stefan Schmidt

The following changes since commit 10bc6a6042c900934a097988b5d50e3cf3f91781:

  r8169: fix autoneg issue on resume with RTL8168E (2018-09-20 19:58:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan.git ieee802154-for-davem-2018-09-28

for you to fetch changes up to d6d1cd2578c4da0764ad334e3411c1c1b1557f58:

  ieee802154: mcr20a: Replace magic number with constants (2018-09-27 17:22:48 +0200)

----------------------------------------------------------------
Xue Liu (1):
      ieee802154: mcr20a: Replace magic number with constants

YueHaibing (1):
      ieee802154: Use kmemdup instead of duplicating it in ca8210_test_int_driver_write

zhong jiang (2):
      ieee802154: remove unecessary condition check before debugfs_remove_recursive
      ieee802154: ca8210: remove redundant condition check before debugfs_remove

 drivers/net/ieee802154/adf7242.c | 3 +--
 drivers/net/ieee802154/ca8210.c  | 6 ++----
 drivers/net/ieee802154/mcr20a.c  | 8 ++++----
 3 files changed, 7 insertions(+), 10 deletions(-)
