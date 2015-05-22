Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37729 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756632AbbEVI5U (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 22 May 2015 04:57:20 -0400
Received: by wibt6 with SMTP id t6so39994200wib.0
        for <linux-wpan@vger.kernel.org>; Fri, 22 May 2015 01:57:19 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/4] mac802154: remove pib/mib locks and locking fixes
Date: Fri, 22 May 2015 10:57:07 +0200
Message-Id: <1432285031-3360-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Hi,

this patch series contains patches for remove pib and mib lock. We have now
a other locking strategie inside this stack which requires at the moment the
rtnl lock only. The first patch will hold the rtnl lock which is required to
access the mib attributes while calling socket ioctl. The last patch will use
atomic operations for incremet the dsn value for dataframes, currently it could
be that this value is the same in two contiguous frames which could be occur a
wrong ack frame handling in ARET mode.

- Alex

Alexander Aring (4):
  mac802154: fix hold rtnl while ioctl
  mac802154: remove pib lock
  mac802154: remove mib lock
  mac802154: use atomic ops for sequence incrementation

 include/net/cfg802154.h         |  6 ++--
 include/net/ieee802154_netdev.h | 10 -------
 net/ieee802154/6lowpan/core.c   | 28 ------------------
 net/ieee802154/6lowpan/tx.c     |  2 +-
 net/ieee802154/core.c           |  2 --
 net/ieee802154/nl-mac.c         | 14 ++++++---
 net/ieee802154/nl-phy.c         |  6 ++--
 net/ieee802154/socket.c         | 12 ++++----
 net/mac802154/ieee802154_i.h    |  7 -----
 net/mac802154/iface.c           | 29 ++++++-------------
 net/mac802154/mac_cmd.c         |  7 ++---
 net/mac802154/mib.c             | 63 ++---------------------------------------
 net/mac802154/rx.c              |  5 ----
 13 files changed, 34 insertions(+), 157 deletions(-)

-- 
2.4.1

