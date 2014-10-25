Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:56402 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404AbaJYT0K (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 25 Oct 2014 15:26:10 -0400
Received: by mail-la0-f41.google.com with SMTP id pn19so4145471lab.28
        for <linux-wpan@vger.kernel.org>; Sat, 25 Oct 2014 12:26:09 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 10/10] mac802154: remove ieee802154_addr from driver_ops
Date: Sat, 25 Oct 2014 17:16:42 +0200
Message-Id: <1414250202-32384-11-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414250202-32384-1-git-send-email-alex.aring@gmail.com>
References: <1414250202-32384-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This driver_ops callback function is never used by any driver.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/mac802154.h |  1 -
 net/mac802154/main.c    | 10 ----------
 2 files changed, 11 deletions(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index eb0e1cb..b07d431 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -170,7 +170,6 @@ struct ieee802154_ops {
 	int		(*set_hw_addr_filt)(struct ieee802154_hw *hw,
 					    struct ieee802154_hw_addr_filt *filt,
 					    unsigned long changed);
-	int		(*ieee_addr)(struct ieee802154_hw *hw, __le64 addr);
 	int		(*set_txpower)(struct ieee802154_hw *hw, int db);
 	int		(*set_lbt)(struct ieee802154_hw *hw, bool on);
 	int		(*set_cca_mode)(struct ieee802154_hw *hw, u8 mode);
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 5ce3184..0e9a6a2 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -61,16 +61,6 @@ int mac802154_slave_open(struct net_device *dev)
 			goto err;
 	}
 
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
 	netif_start_queue(dev);
 	return 0;
 err:
-- 
2.1.2

