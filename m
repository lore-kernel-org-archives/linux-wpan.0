Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:39489 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757415AbcDGSyd (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 7 Apr 2016 14:54:33 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFCv2 bluetooth-next 02/21] ieee802154: add short address helpers
Date: Thu,  7 Apr 2016 20:54:03 +0200
Message-Id: <1460055262-4330-3-git-send-email-aar@pengutronix.de>
In-Reply-To: <1460055262-4330-1-git-send-email-aar@pengutronix.de>
References: <1460055262-4330-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, Alexander Aring <aar@pengutronix.de>

This patch introduce some short address handling functionality into
ieee802154 headers.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/linux/ieee802154.h | 29 +++++++++++++++++++++++++++++
 include/net/mac802154.h    | 10 ++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index 303f446..864fdda 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -47,6 +47,7 @@
 #define IEEE802154_ADDR_SHORT_UNSPEC	0xfffe
 
 #define IEEE802154_EXTENDED_ADDR_LEN	8
+#define IEEE802154_SHORT_ADDR_LEN	2
 
 #define IEEE802154_LIFS_PERIOD		40
 #define IEEE802154_SIFS_PERIOD		12
@@ -280,6 +281,34 @@ static inline bool ieee802154_is_valid_extended_unicast_addr(__le64 addr)
 }
 
 /**
+ * ieee802154_is_broadcast_short_addr - check if short addr is broadcast
+ * @addr: short addr to check
+ */
+static inline bool ieee802154_is_broadcast_short_addr(__le16 addr)
+{
+	return (addr == cpu_to_le16(IEEE802154_ADDR_SHORT_BROADCAST));
+}
+
+/**
+ * ieee802154_is_unspec_short_addr - check if short addr is unspecified
+ * @addr: short addr to check
+ */
+static inline bool ieee802154_is_unspec_short_addr(__le16 addr)
+{
+	return (addr == cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC));
+}
+
+/**
+ * ieee802154_is_valid_src_short_addr - check if source short address is valid
+ * @addr: short addr to check
+ */
+static inline bool ieee802154_is_valid_src_short_addr(__le16 addr)
+{
+	return !(ieee802154_is_broadcast_short_addr(addr) ||
+		 ieee802154_is_unspec_short_addr(addr));
+}
+
+/**
  * ieee802154_random_extended_addr - generates a random extended address
  * @addr: extended addr pointer to place the random address
  */
diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 6cd7a70..e465c85 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -288,6 +288,16 @@ static inline void ieee802154_le16_to_be16(void *be16_dst, const void *le16_src)
 }
 
 /**
+ * ieee802154_be16_to_le16 - copies and convert be16 to le16
+ * @le16_dst: le16 destination pointer
+ * @be16_src: be16 source pointer
+ */
+static inline void ieee802154_be16_to_le16(void *le16_dst, const void *be16_src)
+{
+	put_unaligned_le16(get_unaligned_be16(be16_src), le16_dst);
+}
+
+/**
  * ieee802154_alloc_hw - Allocate a new hardware device
  *
  * This must be called once for each hardware device. The returned pointer
-- 
2.8.0

