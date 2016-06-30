Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:39084 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752035AbcF3MQF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Thu, 30 Jun 2016 08:16:05 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCHv3 bluetooth-next 4/8] ieee802154: fix skb get fc on big endian
Date: Thu, 30 Jun 2016 13:55:52 +0200
Message-Id: <20160630115556.17515-5-aar@pengutronix.de>
In-Reply-To: <20160630115556.17515-1-aar@pengutronix.de>
References: <20160630115556.17515-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <aar@pengutronix.de>

This patch fixes ieee802154_get_fc_from_skb function on big endian
machines. The function get_unaligned_le16 converts the byte order to
host byte order but we want to keep the byte order like in mac header.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/mac802154.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index d757edd..bb7bfec 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -247,6 +247,8 @@ struct ieee802154_ops {
  */
 static inline __le16 ieee802154_get_fc_from_skb(const struct sk_buff *skb)
 {
+	__le16 fc;
+
 	/* check if we can fc at skb_mac_header of sk buffer */
 	if (unlikely(!skb_mac_header_was_set(skb) ||
 		     (skb_tail_pointer(skb) - skb_mac_header(skb)) < 2)) {
@@ -254,7 +256,8 @@ static inline __le16 ieee802154_get_fc_from_skb(const struct sk_buff *skb)
 		return cpu_to_le16(0);
 	}
 
-	return get_unaligned_le16(skb_mac_header(skb));
+	memcpy(&fc, skb_mac_header(skb), IEEE802154_FC_LEN);
+	return fc;
 }
 
 /**
-- 
2.9.0

