Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:58428 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbaKBDTW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 1 Nov 2014 23:19:22 -0400
Received: by mail-wi0-f181.google.com with SMTP id n3so3955303wiv.8
        for <linux-wpan@vger.kernel.org>; Sat, 01 Nov 2014 20:19:21 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 11/16] mac802154: set short address filter on ifup
Date: Sun,  2 Nov 2014 04:18:42 +0100
Message-Id: <1414898327-20759-12-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
References: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch moves the setting of hardware short address filtering
inside of interface up instead doing it it directly inside of netlink
interface. The netlink call which can only be called when netif isn't
running sets only the necessary short_addr value in sdata. After an
interface up the address filter will be set with this value.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/iface.c | 4 ++++
 net/mac802154/mib.c   | 6 ------
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index a509a71..1bae29d 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -208,6 +208,10 @@ static int mac802154_wpan_open(struct net_device *dev)
 		rc = drv_set_extended_addr(local, sdata->extended_addr);
 		if (rc < 0)
 			goto out;
+
+		rc = drv_set_short_addr(local, sdata->short_addr);
+		if (rc < 0)
+			goto out;
 	}
 
 	if (local->hw.flags & IEEE802154_HW_TXPOWER) {
diff --git a/net/mac802154/mib.c b/net/mac802154/mib.c
index cfd4f65..755befd 100644
--- a/net/mac802154/mib.c
+++ b/net/mac802154/mib.c
@@ -80,12 +80,6 @@ void mac802154_dev_set_short_addr(struct net_device *dev, __le16 val)
 	spin_lock_bh(&sdata->mib_lock);
 	sdata->short_addr = val;
 	spin_unlock_bh(&sdata->mib_lock);
-
-	if ((sdata->local->ops->set_hw_addr_filt) &&
-	    (sdata->local->hw.hw_filt.short_addr != sdata->short_addr)) {
-		sdata->local->hw.hw_filt.short_addr = sdata->short_addr;
-		set_hw_addr_filt(dev, IEEE802154_AFILT_SADDR_CHANGED);
-	}
 }
 
 __le16 mac802154_dev_get_short_addr(const struct net_device *dev)
-- 
2.1.3

