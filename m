Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:52561 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752086AbeC2Pvq (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 29 Mar 2018 11:51:46 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: pull-request: ieee802154-next 2018-03-29
Date: Thu, 29 Mar 2018 17:51:38 +0200
Message-Id: <20180329155138.14417-1-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: davem@davemloft.net
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, netdev@vger.kernel.org

Hello Dave.

An update from ieee802154 for *net-next*

Colin fixed a unused variable in the new mcr20a driver.
Harry fixed an unitialised data read in the debugfs interface of the
ca8210 driver.

If there are any issues or you think these are to late for -rc1 (both can also
go into -rc2 as they are simple fixes) let me know.

regards
Stefan Schmidt

The following changes since commit 23e19fd4fb07eebf96909a86b8545bc4aa682e54:

  Merge branch 'tcp_bbr-more-GSO-work' (2018-03-01 21:44:29 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan-next.git ieee802154-for-davem-2018-03-29

for you to fetch changes up to 86674a97f5055f4c7f406563408096e8cf9364ff:

  ieee802154: ca8210: fix uninitialised data read (2018-03-29 16:51:26 +0200)

----------------------------------------------------------------
Colin Ian King (1):
      ieee802154: remove unused variable 'val'

Harry Morris (1):
      ieee802154: ca8210: fix uninitialised data read

 drivers/net/ieee802154/ca8210.c | 14 +++++++++++---
 drivers/net/ieee802154/mcr20a.c |  2 --
 2 files changed, 11 insertions(+), 5 deletions(-)
