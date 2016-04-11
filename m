Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53789 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752904AbcDKJE3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 11 Apr 2016 05:04:29 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH bluetooth-next 08/11] 6lowpan: iphc: remove unnecessary zero data
Date: Mon, 11 Apr 2016 11:04:21 +0200
Message-Id: <1460365464-12435-9-git-send-email-aar@pengutronix.de>
In-Reply-To: <1460365464-12435-1-git-send-email-aar@pengutronix.de>
References: <1460365464-12435-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, Alexander Aring <aar@pengutronix.de>

This patch removes unnecessary zero data for a stack variable.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/6lowpan/iphc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 66b4139..2999240 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -177,7 +177,7 @@ lowpan_iphc_uncompress_802154_lladdr(struct in6_addr *ipaddr,
 				     const void *lladdr)
 {
 	const struct ieee802154_addr *addr = lladdr;
-	u8 eui64[EUI64_ADDR_LEN] = { };
+	u8 eui64[EUI64_ADDR_LEN];
 
 	switch (addr->mode) {
 	case IEEE802154_ADDR_LONG:
-- 
2.8.0

