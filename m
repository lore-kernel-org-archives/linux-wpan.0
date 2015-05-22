Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35552 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756729AbbEVI5V (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 22 May 2015 04:57:21 -0400
Received: by wicmx19 with SMTP id mx19so40303591wic.0
        for <linux-wpan@vger.kernel.org>; Fri, 22 May 2015 01:57:20 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/4] mac802154: fix hold rtnl while ioctl
Date: Fri, 22 May 2015 10:57:08 +0200
Message-Id: <1432285031-3360-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1432285031-3360-1-git-send-email-alex.aring@gmail.com>
References: <1432285031-3360-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch fixes an issue to set address configuration with ioctl.
Accessing the mib requires rtnl lock and the ndo_do_ioctl doesn't hold
the rtnl lock while this callback is called. This patch do that
manually.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reported-by: Matteo Petracca <matteo.petracca@sssup.it>
---
 net/mac802154/iface.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 91b75ab..2a58788 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -62,8 +62,7 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 		(struct sockaddr_ieee802154 *)&ifr->ifr_addr;
 	int err = -ENOIOCTLCMD;
 
-	ASSERT_RTNL();
-
+	rtnl_lock();
 	spin_lock_bh(&sdata->mib_lock);
 
 	switch (cmd) {
@@ -90,6 +89,7 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 	case SIOCSIFADDR:
 		if (netif_running(dev)) {
 			spin_unlock_bh(&sdata->mib_lock);
+			rtnl_unlock();
 			return -EBUSY;
 		}
 
@@ -112,6 +112,7 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 	}
 
 	spin_unlock_bh(&sdata->mib_lock);
+	rtnl_unlock();
 	return err;
 }
 
-- 
2.4.1

