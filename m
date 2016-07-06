Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:39123 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932405AbcGFVcr (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 6 Jul 2016 17:32:47 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCHv4 bluetooth-next 3/8] ieee802154: 6lowpan: fix intra pan id check
Date: Wed,  6 Jul 2016 23:32:26 +0200
Message-Id: <20160706213231.23058-4-aar@pengutronix.de>
In-Reply-To: <20160706213231.23058-1-aar@pengutronix.de>
References: <20160706213231.23058-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <aar@pengutronix.de>

The RIOT-OS stack does send intra-pan frames but don't set the intra pan
flag inside the mac header. It seems this is valid frame addressing but
inefficient. Anyway this patch adds a new function for intra pan
addressing, doesn't matter if intra pan flag or source and destination
are the same. The newly introduction function will be used to check on
intra pan addressing for 6lowpan.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/mac802154.h     | 19 +++++++++++++++++++
 net/ieee802154/6lowpan/rx.c |  2 +-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index ec01b35..d757edd 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -346,6 +346,25 @@ static inline unsigned char *ieee802154_skb_src_pan(__le16 fc,
 }
 
 /**
+ * ieee802154_skb_is_intra_pan_addressing - checks whenever the mac addressing
+ *	is an intra pan communication
+ * @fc: mac header frame control field
+ * @skb: skb where the source and destination pan should be get from
+ */
+static inline bool ieee802154_skb_is_intra_pan_addressing(__le16 fc,
+							  const struct sk_buff *skb)
+{
+	unsigned char *dst_pan = ieee802154_skb_dst_pan(fc, skb),
+		      *src_pan = ieee802154_skb_src_pan(fc, skb);
+
+	/* if one is NULL is no intra pan addressing */
+	if (!dst_pan || !src_pan)
+		return false;
+
+	return !memcmp(dst_pan, src_pan, IEEE802154_PAN_ID_LEN);
+}
+
+/**
  * ieee802154_be64_to_le64 - copies and convert be64 to le64
  * @le64_dst: le64 destination pointer
  * @be64_src: be64 source pointer
diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index ef185dd..649e7d45 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -262,7 +262,7 @@ static inline bool lowpan_rx_h_check(struct sk_buff *skb)
 
 	/* check on ieee802154 conform 6LoWPAN header */
 	if (!ieee802154_is_data(fc) ||
-	    !ieee802154_is_intra_pan(fc))
+	    !ieee802154_skb_is_intra_pan_addressing(fc, skb))
 		return false;
 
 	/* check if we can dereference the dispatch */
-- 
2.9.0

