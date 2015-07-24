Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:38661 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754208AbbGXNBr (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Jul 2015 09:01:47 -0400
Received: by wibxm9 with SMTP id xm9so27055234wib.1
        for <linux-wpan@vger.kernel.org>; Fri, 24 Jul 2015 06:01:46 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/2] mac802154: fix wpan mac setting while lowpan
Date: Fri, 24 Jul 2015 15:01:45 +0200
Message-Id: <1437742905-5921-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1437742905-5921-1-git-send-email-alex.aring@gmail.com>
References: <1437742905-5921-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

If we currently change the mac address inside the wpan interface while
we have a lowpan interface on top of the wpan interface, the mac address
setting doesn't reach the lowpan interface. The effect would be that the
IPv6 lowpan interface has the old SLAAC address and isn't working
anymore because the lowpan interface use in internal mechanism sometimes
dev->addr which is the old mac address of the wpan interface.

This patch checks if a wpan interface belongs to lowpan interface, if
yes then we need to check if the lowpan interface is down and change the
mac address also at the lowpan interface. When the lowpan interface will
be set up afterwards, it will use the correct SLAAC address which based
on the updated mac address setting.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/iface.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 416de90..346c160 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -132,6 +132,20 @@ static int mac802154_wpan_mac_addr(struct net_device *dev, void *p)
 	memcpy(dev->dev_addr, addr->sa_data, dev->addr_len);
 	sdata->wpan_dev.extended_addr = extended_addr;
 
+	/* update lowpan interface mac address when
+	 * wpan mac has been changed
+	 */
+	if (sdata->wpan_dev.lowpan_dev) {
+		/* lowpan need to be down for update
+		 * SLAAC address after ifup
+		 */
+		if (netif_running(sdata->wpan_dev.lowpan_dev))
+			return -EBUSY;
+
+		memcpy(sdata->wpan_dev.lowpan_dev->dev_addr, dev->dev_addr,
+		       dev->addr_len);
+	}
+
 	return mac802154_wpan_update_llsec(dev);
 }
 
-- 
2.4.6

