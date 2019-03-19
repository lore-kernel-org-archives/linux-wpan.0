Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:49274 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfCSQYl (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Mar 2019 12:24:41 -0400
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: pull-request: ieee802154 for net 2019-03-19
Date: Tue, 19 Mar 2019 17:24:35 +0100
Message-Id: <20190319162435.16854-1-stefan@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: davem@davemloft.net
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, netdev@vger.kernel.org

Hello Dave.

An update from ieee802154 for your *net* tree.

Kangjie Lu fixed a potential NULL pointer deref in the adf7242 driver and Li
RongQing make sure we propagate a netlink return code to the caller.

If there are any problems let me know.

regards
Stefan Schmidt

The following changes since commit ffa91253739ca89fc997195d8bbd1f7ba3e29fbe:

  Documentation: networking: Update netdev-FAQ regarding patches (2019-03-18 20:09:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan.git ieee802154-for-davem-2019-03-19

for you to fetch changes up to 86008304dc2ad41a274cdacb585c641ec6bbb558:

  Merge remote-tracking branch 'net/master' (2019-03-19 16:25:37 +0100)

----------------------------------------------------------------
Kangjie Lu (1):
      net: ieee802154: fix a potential NULL pointer dereference

Li RongQing (1):
      ieee802154: hwsim: propagate genlmsg_reply return code

Stefan Schmidt (1):
      Merge remote-tracking branch 'net/master'

 drivers/net/ieee802154/adf7242.c         | 4 ++++
 drivers/net/ieee802154/mac802154_hwsim.c | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)
