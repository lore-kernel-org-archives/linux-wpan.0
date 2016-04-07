Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60107 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757419AbcDGSye (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 7 Apr 2016 14:54:34 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFCv2 bluetooth-next 06/21] 6lowpan: move lowpan_802154_dev to 6lowpan
Date: Thu,  7 Apr 2016 20:54:07 +0200
Message-Id: <1460055262-4330-7-git-send-email-aar@pengutronix.de>
In-Reply-To: <1460055262-4330-1-git-send-email-aar@pengutronix.de>
References: <1460055262-4330-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, Alexander Aring <aar@pengutronix.de>

This patch moves the 802.15.4 link layer specific structures to generic
6lowpan. This is necessary for special 802.15.4 6lowpan handling in
6lowpan generic layer.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/6lowpan.h              | 12 ++++++++++++
 net/ieee802154/6lowpan/6lowpan_i.h | 12 ------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index f204664..a0c01f5 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -144,6 +144,18 @@ struct lowpan_dev *lowpan_dev(const struct net_device *dev)
 	return netdev_priv(dev);
 }
 
+/* private device info */
+struct lowpan_802154_dev {
+	struct net_device	*wdev; /* wpan device ptr */
+	u16			fragment_tag;
+};
+
+static inline struct
+lowpan_802154_dev *lowpan_802154_dev(const struct net_device *dev)
+{
+	return (struct lowpan_802154_dev *)lowpan_dev(dev)->priv;
+}
+
 struct lowpan_802154_cb {
 	u16 d_tag;
 	unsigned int d_size;
diff --git a/net/ieee802154/6lowpan/6lowpan_i.h b/net/ieee802154/6lowpan/6lowpan_i.h
index b02b74d..5ac7789 100644
--- a/net/ieee802154/6lowpan/6lowpan_i.h
+++ b/net/ieee802154/6lowpan/6lowpan_i.h
@@ -47,18 +47,6 @@ static inline u32 ieee802154_addr_hash(const struct ieee802154_addr *a)
 	}
 }
 
-/* private device info */
-struct lowpan_802154_dev {
-	struct net_device	*wdev; /* wpan device ptr */
-	u16			fragment_tag;
-};
-
-static inline struct
-lowpan_802154_dev *lowpan_802154_dev(const struct net_device *dev)
-{
-	return (struct lowpan_802154_dev *)lowpan_dev(dev)->priv;
-}
-
 int lowpan_frag_rcv(struct sk_buff *skb, const u8 frag_type);
 void lowpan_net_frag_exit(void);
 int lowpan_net_frag_init(void);
-- 
2.8.0

