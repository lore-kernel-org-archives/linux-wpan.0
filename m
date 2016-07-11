Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:56218 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750950AbcGKTvS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 11 Jul 2016 15:51:18 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC bluetooth-next 08/20] 6lowpan: move rx defines to generic
Date: Mon, 11 Jul 2016 21:50:32 +0200
Message-Id: <20160711195044.25343-9-aar@pengutronix.de>
In-Reply-To: <20160711195044.25343-1-aar@pengutronix.de>
References: <20160711195044.25343-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, luiz.dentz@gmail.com, kaspar@schleiser.de, jukka.rissanen@linux.intel.com, linux-bluetooth@vger.kernel.org, Patrik.Flykt@linux.intel.com, Alexander Aring <aar@pengutronix.de>

This patch prepares to use 802.15.4 6LoWPAN receive handling also for
BTLE 6LoWPAN.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/6lowpan.h              | 6 ++++++
 net/ieee802154/6lowpan/6lowpan_i.h | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index 2570237..90d9d08 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -80,6 +80,12 @@
 
 #define LOWPAN_IFNAME_TEMPLATE "6lo%d"
 
+typedef unsigned __bitwise__ lowpan_rx_result;
+#define RX_CONTINUE		((__force lowpan_rx_result) 0u)
+#define RX_DROP_UNUSABLE	((__force lowpan_rx_result) 1u)
+#define RX_DROP			((__force lowpan_rx_result) 2u)
+#define RX_QUEUED		((__force lowpan_rx_result) 3u)
+
 static inline bool lowpan_is_ipv6(u8 dispatch)
 {
 	return dispatch == LOWPAN_DISPATCH_IPV6;
diff --git a/net/ieee802154/6lowpan/6lowpan_i.h b/net/ieee802154/6lowpan/6lowpan_i.h
index 5ac7789..39b739f 100644
--- a/net/ieee802154/6lowpan/6lowpan_i.h
+++ b/net/ieee802154/6lowpan/6lowpan_i.h
@@ -7,12 +7,6 @@
 #include <net/inet_frag.h>
 #include <net/6lowpan.h>
 
-typedef unsigned __bitwise__ lowpan_rx_result;
-#define RX_CONTINUE		((__force lowpan_rx_result) 0u)
-#define RX_DROP_UNUSABLE	((__force lowpan_rx_result) 1u)
-#define RX_DROP			((__force lowpan_rx_result) 2u)
-#define RX_QUEUED		((__force lowpan_rx_result) 3u)
-
 #define LOWPAN_DISPATCH_FRAG1           0xc0
 #define LOWPAN_DISPATCH_FRAGN           0xe0
 
-- 
2.9.0

