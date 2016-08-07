Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33241 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751821AbcHGOdC (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Aug 2016 10:33:02 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFCv2 bluetooth-next 02/19] ieee802154: 6lowpan: move skb cb BUILD_BUG_ON check
Date: Sun,  7 Aug 2016 16:30:39 +0200
Message-Id: <20160807143056.3116-3-aar@pengutronix.de>
In-Reply-To: <20160807143056.3116-1-aar@pengutronix.de>
References: <20160807143056.3116-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, Alexander Aring <aar@pengutronix.de>

This patch moves the control block information BUILD_BUG_ON to the init
of module. All compile timed BUILD_BUG_ON macros should be placed there.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/6lowpan.h         | 1 -
 net/ieee802154/6lowpan/core.c | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index 5ab4c99..6d56be7 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -178,7 +178,6 @@ struct lowpan_802154_cb {
 static inline
 struct lowpan_802154_cb *lowpan_802154_cb(const struct sk_buff *skb)
 {
-	BUILD_BUG_ON(sizeof(struct lowpan_802154_cb) > sizeof(skb->cb));
 	return (struct lowpan_802154_cb *)skb->cb;
 }
 
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index d7efbf0..6afb8cd 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -233,6 +233,9 @@ static int __init lowpan_init_module(void)
 {
 	int err = 0;
 
+	BUILD_BUG_ON(sizeof(struct lowpan_802154_cb) >
+		     FIELD_SIZEOF(struct sk_buff, cb));
+
 	err = lowpan_net_frag_init();
 	if (err < 0)
 		goto out;
-- 
2.9.2

