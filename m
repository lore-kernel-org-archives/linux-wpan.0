Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:54521 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbaKIHhl (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 9 Nov 2014 02:37:41 -0500
Received: by mail-wg0-f41.google.com with SMTP id k14so6536477wgh.14
        for <linux-wpan@vger.kernel.org>; Sat, 08 Nov 2014 23:37:40 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 15/15] mac802154: protect address changes via ioctl
Date: Sun,  9 Nov 2014 08:36:59 +0100
Message-Id: <1415518619-4370-16-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
References: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a netif_running check while trying to change the address
attributes via ioctl. While netif_running is true these attributes
should be only readable.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/iface.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index d635f36..83715b5 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -63,6 +63,8 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 		(struct sockaddr_ieee802154 *)&ifr->ifr_addr;
 	int err = -ENOIOCTLCMD;
 
+	ASSERT_RTNL();
+
 	spin_lock_bh(&sdata->mib_lock);
 
 	switch (cmd) {
@@ -87,6 +89,11 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 		break;
 	}
 	case SIOCSIFADDR:
+		if (netif_running(dev)) {
+			spin_unlock_bh(&sdata->mib_lock);
+			return -EBUSY;
+		}
+
 		dev_warn(&dev->dev,
 			 "Using DEBUGing ioctl SIOCSIFADDR isn't recommended!\n");
 		if (sa->family != AF_IEEE802154 ||
-- 
2.1.3

