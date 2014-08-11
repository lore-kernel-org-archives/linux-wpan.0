Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:44219 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbaHKLad (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 11 Aug 2014 07:30:33 -0400
From: Alexander Aring <alex.aring@gmail.com>
Date: Mon, 11 Aug 2014 13:25:09 +0200
Message-Id: <1407756310-26592-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407756310-26592-1-git-send-email-alex.aring@gmail.com>
References: <1407756310-26592-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH 3/4] ieee802154: 6lowpan: remove unused function
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan_rtnl.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index 016b77e..509d7a6 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -77,14 +77,6 @@ lowpan_dev_info *lowpan_dev_info(const struct net_device *dev)
 	return netdev_priv(dev);
 }
 
-static inline void lowpan_address_flip(u8 *src, u8 *dest)
-{
-	int i;
-
-	for (i = 0; i < IEEE802154_ADDR_LEN; i++)
-		(dest)[IEEE802154_ADDR_LEN - i - 1] = (src)[i];
-}
-
 static int lowpan_header_create(struct sk_buff *skb, struct net_device *dev,
 				unsigned short type, const void *_daddr,
 				const void *_saddr, unsigned int len)
-- 
2.0.3

