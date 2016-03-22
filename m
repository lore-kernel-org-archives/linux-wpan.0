Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60867 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758874AbcCVNPn (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 22 Mar 2016 09:15:43 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC bluetooth-next 08/19] 6lowpan: iphc: remove unnecessary zero data
Date: Tue, 22 Mar 2016 14:15:04 +0100
Message-Id: <1458652515-7862-9-git-send-email-aar@pengutronix.de>
In-Reply-To: <1458652515-7862-1-git-send-email-aar@pengutronix.de>
References: <1458652515-7862-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, Alexander Aring <aar@pengutronix.de>

This patch removes unnecessary zero data for a stack variable.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/6lowpan/iphc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index d5a72e3..bad4f89 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -172,7 +172,7 @@ lowpan_iphc_uncompress_802154_lladdr(struct in6_addr *ipaddr,
 				     const void *lladdr)
 {
 	const struct ieee802154_addr *addr = lladdr;
-	u8 eui64[EUI64_ADDR_LEN] = { };
+	u8 eui64[EUI64_ADDR_LEN];
 
 	switch (addr->mode) {
 	case IEEE802154_ADDR_LONG:
-- 
2.7.4

