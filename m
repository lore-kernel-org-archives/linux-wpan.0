Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54581 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750879AbcFRIgT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Sat, 18 Jun 2016 04:36:19 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH bluetooth-next] ieee802154: fix skb get fc on big endian
Date: Sat, 18 Jun 2016 10:36:07 +0200
Message-Id: <20160618083607.3538-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <aar@pengutronix.de>

This patch fixes ieee802154_get_fc_from_skb function on big endian
machines. The function get_unaligned_le16 converts the byte order to
host byte order but we want to keep the byte order like in mac header.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/mac802154.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index df34187..3d7fa73 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -247,14 +247,16 @@ struct ieee802154_ops {
  */
 static inline __le16 ieee802154_get_fc_from_skb(const struct sk_buff *skb)
 {
+	__le16 fc;
+
 	/* check if we can fc at skb_mac_header of sk buffer */
-	if (unlikely(!skb_mac_header_was_set(skb) ||
-		     (skb_tail_pointer(skb) - skb_mac_header(skb)) < 2)) {
-		WARN_ON(1);
+	if (WARN_ON(!skb_mac_header_was_set(skb) ||
+		    (skb_tail_pointer(skb) -
+		     skb_mac_header(skb)) < IEEE802154_FC_LEN))
 		return cpu_to_le16(0);
-	}
 
-	return get_unaligned_le16(skb_mac_header(skb));
+	memcpy(&fc, skb_mac_header(skb), IEEE802154_FC_LEN);
+	return fc;
 }
 
 /**
-- 
2.8.3

