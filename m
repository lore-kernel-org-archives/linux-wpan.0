Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:35532 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751858AbcF3MPu (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Thu, 30 Jun 2016 08:15:50 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCHv3 bluetooth-next 7/8] ieee802154: cleanup WARN_ON for fc fetch
Date: Thu, 30 Jun 2016 13:55:55 +0200
Message-Id: <20160630115556.17515-8-aar@pengutronix.de>
In-Reply-To: <20160630115556.17515-1-aar@pengutronix.de>
References: <20160630115556.17515-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <aar@pengutronix.de>

This patch cleanups the WARN_ON which occurs when the sk buffer has
insufficient buffer space by moving the WARN_ON into if condition.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/mac802154.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index bb7bfec..286824a 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -250,11 +250,10 @@ static inline __le16 ieee802154_get_fc_from_skb(const struct sk_buff *skb)
 	__le16 fc;
 
 	/* check if we can fc at skb_mac_header of sk buffer */
-	if (unlikely(!skb_mac_header_was_set(skb) ||
-		     (skb_tail_pointer(skb) - skb_mac_header(skb)) < 2)) {
-		WARN_ON(1);
+	if (WARN_ON(!skb_mac_header_was_set(skb) ||
+		    (skb_tail_pointer(skb) -
+		     skb_mac_header(skb)) < IEEE802154_FC_LEN))
 		return cpu_to_le16(0);
-	}
 
 	memcpy(&fc, skb_mac_header(skb), IEEE802154_FC_LEN);
 	return fc;
-- 
2.9.0

