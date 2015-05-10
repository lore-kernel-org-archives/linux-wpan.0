Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36144 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbbEJUlH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 10 May 2015 16:41:07 -0400
Received: by wizk4 with SMTP id k4so83660615wiz.1
        for <linux-wpan@vger.kernel.org>; Sun, 10 May 2015 13:41:06 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/3] mac802154: remove pib/mib locks
Date: Sun, 10 May 2015 22:40:53 +0200
Message-Id: <1431290456-25524-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch series removes the pib/mib lock inside the mac802154 subsystem.
The new locking mechanism will use the rtnl lock to ensure that other
operations like ifdown/ifup can't happend while setting pib/mib values.

Note: the new locking strategy depends on context, on most mib values while
interface up the mib attributes are readonly, this will allow us less
complexity and locking stuff while frame parsing.

I tried my best to change the old netlink interface according to that, but
I believe there is no real locking "strategy" in the old netlink calls
and it's hard to understand how it works.

- Alex

Alexander Aring (3):
  mac802154: fix hold rtnl while ioctl
  mac802154: remove pib lock
  mac802154: remove mib lock

 include/net/cfg802154.h         |  2 --
 include/net/ieee802154_netdev.h | 10 -------
 net/ieee802154/6lowpan/core.c   | 28 ------------------
 net/ieee802154/6lowpan/tx.c     |  2 +-
 net/ieee802154/core.c           |  2 --
 net/ieee802154/nl-mac.c         | 14 ++++++---
 net/ieee802154/nl-phy.c         |  6 ++--
 net/ieee802154/socket.c         | 12 ++++----
 net/mac802154/ieee802154_i.h    |  9 ------
 net/mac802154/iface.c           | 25 +++++-----------
 net/mac802154/mac_cmd.c         | 10 +++----
 net/mac802154/mib.c             | 63 ++---------------------------------------
 net/mac802154/rx.c              |  5 ----
 13 files changed, 32 insertions(+), 156 deletions(-)

-- 
2.3.7

