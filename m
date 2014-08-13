Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:59531 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbaHMNrG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 13 Aug 2014 09:47:06 -0400
Received: by mail-la0-f50.google.com with SMTP id pi18so2112263lab.37
        for <linux-wpan@vger.kernel.org>; Wed, 13 Aug 2014 06:47:05 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Wed, 13 Aug 2014 15:46:34 +0200
Message-Id: <1407937595-16415-12-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407937595-16415-1-git-send-email-alex.aring@gmail.com>
References: <1407937595-16415-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 11/12] mac802154: remove ieee802154_addr from driver_ops
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This function is never used by any driver. There exist also no comment
for this. In my opinion it was a try to implement hardware address
filter but we have already such driver ops for this functionallity.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/mac802154.h |  1 -
 net/mac802154/iface.c   | 10 ----------
 2 files changed, 11 deletions(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 9e9d8fa..4666b98 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -173,7 +173,6 @@ struct ieee802154_ops {
 	int		(*set_hw_addr_filt)(struct ieee802154_hw *hw,
 					    struct ieee802154_hw_addr_filt *filt,
 					    unsigned long changed);
-	int		(*ieee_addr)(struct ieee802154_hw *hw, __le64 addr);
 	int		(*set_txpower)(struct ieee802154_hw *hw, int db);
 	int		(*set_lbt)(struct ieee802154_hw *hw, bool on);
 	int		(*set_cca_mode)(struct ieee802154_hw *hw, u8 mode);
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index c1e5096..4655be5 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -51,16 +51,6 @@ static int mac802154_slave_open(struct net_device *dev)
 	sdata->running = true;
 	mutex_unlock(&sdata->local->iflist_mtx);
 
-	if (local->ops->ieee_addr) {
-		__le64 addr = ieee802154_devaddr_from_raw(dev->dev_addr);
-
-		res = local->ops->ieee_addr(&local->hw, addr);
-		WARN_ON(res);
-		if (res)
-			goto err;
-		mac802154_dev_set_ieee_addr(dev);
-	}
-
 	local->open_count++;
 
 	netif_start_queue(dev);
-- 
2.0.3

