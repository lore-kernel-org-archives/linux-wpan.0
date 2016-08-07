Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:43972 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751986AbcHGOdD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Aug 2016 10:33:03 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFCv2 bluetooth-next 05/19] 6lowpan: introduce generic default naming
Date: Sun,  7 Aug 2016 16:30:42 +0200
Message-Id: <20160807143056.3116-6-aar@pengutronix.de>
In-Reply-To: <20160807143056.3116-1-aar@pengutronix.de>
References: <20160807143056.3116-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, Alexander Aring <aar@pengutronix.de>

This patch adds a default naming for all 6LoWPAN interfaces. All
userspace software should have them as example e.g. for configurations.

I see currently many examples which has different interface naming for
software which works for 6LoWPAN BTLE and 6LoWPAN 802.15.4.

We need to change also all examples outside to this naming stuff, so the
interface naming inside such examples doesn't depends on L2.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/6lowpan.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index 7f4b63c..2570237 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -78,6 +78,8 @@
 #define LOWPAN_DISPATCH_IPHC		0x60 /* 011xxxxx = ... */
 #define LOWPAN_DISPATCH_IPHC_MASK	0xe0
 
+#define LOWPAN_IFNAME_TEMPLATE "6lo%d"
+
 static inline bool lowpan_is_ipv6(u8 dispatch)
 {
 	return dispatch == LOWPAN_DISPATCH_IPV6;
-- 
2.9.2

