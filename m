Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46193 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758847AbcCVNPl (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 22 Mar 2016 09:15:41 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC bluetooth-next 04/19] ieee802154: 6lowpan: fix short addr hash
Date: Tue, 22 Mar 2016 14:15:00 +0100
Message-Id: <1458652515-7862-5-git-send-email-aar@pengutronix.de>
In-Reply-To: <1458652515-7862-1-git-send-email-aar@pengutronix.de>
References: <1458652515-7862-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, Alexander Aring <aar@pengutronix.de>

The short address is unique in combination with the panid. This patch
will add the panid for generating an ieee802154 address hash.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/ieee802154/6lowpan/6lowpan_i.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/6lowpan_i.h b/net/ieee802154/6lowpan/6lowpan_i.h
index b4e17a7..b4092a9 100644
--- a/net/ieee802154/6lowpan/6lowpan_i.h
+++ b/net/ieee802154/6lowpan/6lowpan_i.h
@@ -41,7 +41,7 @@ static inline u32 ieee802154_addr_hash(const struct ieee802154_addr *a)
 		return (((__force u64)a->extended_addr) >> 32) ^
 			(((__force u64)a->extended_addr) & 0xffffffff);
 	case IEEE802154_ADDR_SHORT:
-		return (__force u32)(a->short_addr);
+		return (__force u32)(a->short_addr + (a->pan_id << 16));
 	default:
 		return 0;
 	}
-- 
2.7.4

