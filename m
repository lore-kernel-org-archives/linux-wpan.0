Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54031 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751105AbcFQQfE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Fri, 17 Jun 2016 12:35:04 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH bluetooth-next 1/3] ieee802154: add ieee802154_skb_dst_pan helper
Date: Fri, 17 Jun 2016 18:34:48 +0200
Message-Id: <20160617163450.3229-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <aar@pengutronix.de>

This patch adds ieee802154_skb_dst_pan function to get the pointer
address of the destination pan id at skb mac pointer.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/linux/ieee802154.h | 16 ++++++++++++++++
 include/net/mac802154.h    | 29 +++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index acedbb6..91f4665 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -31,6 +31,8 @@
 #define IEEE802154_MIN_PSDU_LEN		9
 #define IEEE802154_FCS_LEN		2
 #define IEEE802154_MAX_AUTH_TAG_LEN	16
+#define IEEE802154_FC_LEN		2
+#define IEEE802154_SEQ_LEN		1
 
 /*  General MAC frame format:
  *  2 bytes: Frame Control
@@ -221,9 +223,14 @@ enum {
 #define IEEE802154_FCTL_ACKREQ		0x0020
 #define IEEE802154_FCTL_SECEN		0x0004
 #define IEEE802154_FCTL_INTRA_PAN	0x0040
+#define IEEE802154_FCTL_DADDR		0x0c00
 
 #define IEEE802154_FTYPE_DATA		0x0001
 
+#define IEEE802154_FCTL_ADDR_NONE	0x0000
+#define IEEE802154_FCTL_DADDR_SHORT	0x0800
+#define IEEE802154_FCTL_DADDR_EXTENDED	0x0c00
+
 /*
  * ieee802154_is_data - check if type is IEEE802154_FTYPE_DATA
  * @fc: frame control bytes in little-endian byteorder
@@ -261,6 +268,15 @@ static inline bool ieee802154_is_intra_pan(__le16 fc)
 	return fc & cpu_to_le16(IEEE802154_FCTL_INTRA_PAN);
 }
 
+/*
+ * ieee802154_daddr_mode - get daddr mode from fc
+ * @fc: frame control bytes in little-endian byteorder
+ */
+static inline __le16 ieee802154_daddr_mode(__le16 fc)
+{
+	return fc & cpu_to_le16(IEEE802154_FCTL_DADDR);
+}
+
 /**
  * ieee802154_is_valid_psdu_len - check if psdu len is valid
  * available lengths:
diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index e465c85..b3f7cd8 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -258,6 +258,35 @@ static inline __le16 ieee802154_get_fc_from_skb(const struct sk_buff *skb)
 }
 
 /**
+ * ieee802154_skb_dst_pan - get the pointer to destination pan field
+ * @fc: mac header frame control field
+ * @skb: skb where the destination pan pointer will be get from
+ */
+static inline unsigned char *ieee802154_skb_dst_pan(__le16 fc,
+						    const struct sk_buff *skb)
+{
+	unsigned char *dst_pan;
+
+	switch (ieee802154_daddr_mode(fc)) {
+	case cpu_to_le16(IEEE802154_FCTL_ADDR_NONE):
+		dst_pan = NULL;
+		break;
+	case cpu_to_le16(IEEE802154_FCTL_DADDR_SHORT):
+	case cpu_to_le16(IEEE802154_FCTL_DADDR_EXTENDED):
+		dst_pan = skb_mac_header(skb) +
+			  IEEE802154_FC_LEN +
+			  IEEE802154_SEQ_LEN;
+		break;
+	default:
+		WARN_ONCE(1, "invalid addr mode detected");
+		dst_pan = NULL;
+		break;
+	}
+
+	return dst_pan;
+}
+
+/**
  * ieee802154_be64_to_le64 - copies and convert be64 to le64
  * @le64_dst: le64 destination pointer
  * @be64_src: be64 source pointer
-- 
2.8.3

