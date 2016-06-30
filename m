Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37053 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932086AbcF3MP4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Thu, 30 Jun 2016 08:15:56 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCHv3 bluetooth-next 5/8] 6lowpan: ndisc: set invalid unicast short addr to unspec
Date: Thu, 30 Jun 2016 13:55:53 +0200
Message-Id: <20160630115556.17515-6-aar@pengutronix.de>
In-Reply-To: <20160630115556.17515-1-aar@pengutronix.de>
References: <20160630115556.17515-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <aar@pengutronix.de>

When receiving neighbour information with short address option field we
should check the complete range of invalid short addresses and set it to
one invalid address setting which is the unspecified address. This
address is also used when by creating at first a new neighbour entry to
indicate no short address is set.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/6lowpan/ndisc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/6lowpan/ndisc.c b/net/6lowpan/ndisc.c
index 79c5fa9..86450b7 100644
--- a/net/6lowpan/ndisc.c
+++ b/net/6lowpan/ndisc.c
@@ -97,10 +97,13 @@ static void lowpan_ndisc_802154_update(struct neighbour *n, u32 flags,
 	}
 
 	write_lock_bh(&n->lock);
-	if (lladdr_short)
+	if (lladdr_short) {
 		ieee802154_be16_to_le16(&neigh->short_addr, lladdr_short);
-	else
+		if (!lowpan_802154_is_valid_src_short_addr(neigh->short_addr))
+			neigh->short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC);
+	} else {
 		neigh->short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC);
+	}
 	write_unlock_bh(&n->lock);
 }
 
-- 
2.9.0

