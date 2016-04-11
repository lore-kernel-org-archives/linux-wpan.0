Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:39058 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753484AbcDKJE2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 11 Apr 2016 05:04:28 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH bluetooth-next 04/11] ieee802154: 6lowpan: fix short addr hash
Date: Mon, 11 Apr 2016 11:04:17 +0200
Message-Id: <1460365464-12435-5-git-send-email-aar@pengutronix.de>
In-Reply-To: <1460365464-12435-1-git-send-email-aar@pengutronix.de>
References: <1460365464-12435-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, Alexander Aring <aar@pengutronix.de>

The short address is unique in combination with the panid. This patch
will add the panid for generating an ieee802154 address hash.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
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
2.8.0

