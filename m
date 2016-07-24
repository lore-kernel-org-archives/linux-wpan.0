Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50445 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751544AbcGXOMs (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Sun, 24 Jul 2016 10:12:48 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH bluetooth-next 2/2] 6lowpan: ndisc: no overreact if no short address is available
Date: Sun, 24 Jul 2016 16:12:25 +0200
Message-Id: <20160724141225.17591-2-aar@pengutronix.de>
In-Reply-To: <20160724141225.17591-1-aar@pengutronix.de>
References: <20160724141225.17591-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, Alexander Aring <aar@pengutronix.de>

This patch removes handling to remove short address for a neigbour entry
if RS/RA/NS/NA doesn't contain a short address. If these messages
doesn't has any short address option, the existing short address from
ndisc cache will be used. The current behaviour will set that the
neigbour doesn't has a short address anymore.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/6lowpan/ndisc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/6lowpan/ndisc.c b/net/6lowpan/ndisc.c
index 86450b7..941df2f 100644
--- a/net/6lowpan/ndisc.c
+++ b/net/6lowpan/ndisc.c
@@ -101,8 +101,6 @@ static void lowpan_ndisc_802154_update(struct neighbour *n, u32 flags,
 		ieee802154_be16_to_le16(&neigh->short_addr, lladdr_short);
 		if (!lowpan_802154_is_valid_src_short_addr(neigh->short_addr))
 			neigh->short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC);
-	} else {
-		neigh->short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC);
 	}
 	write_unlock_bh(&n->lock);
 }
-- 
2.9.0

