Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52154 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751087AbcFQQfA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Fri, 17 Jun 2016 12:35:00 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH bluetooth-next 2/3] ieee802154: add ieee802154_skb_src_pan helper
Date: Fri, 17 Jun 2016 18:34:49 +0200
Message-Id: <20160617163450.3229-2-aar@pengutronix.de>
In-Reply-To: <20160617163450.3229-1-aar@pengutronix.de>
References: <20160617163450.3229-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <aar@pengutronix.de>

This patch adds ieee802154_skb_src_pan function to get the pointer
address of the source pan id at skb mac pointer.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/linux/ieee802154.h | 12 ++++++++++++
 include/net/mac802154.h    | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index 91f4665..fd14815 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -224,12 +224,15 @@ enum {
 #define IEEE802154_FCTL_SECEN		0x0004
 #define IEEE802154_FCTL_INTRA_PAN	0x0040
 #define IEEE802154_FCTL_DADDR		0x0c00
+#define IEEE802154_FCTL_SADDR		0xc000
 
 #define IEEE802154_FTYPE_DATA		0x0001
 
 #define IEEE802154_FCTL_ADDR_NONE	0x0000
 #define IEEE802154_FCTL_DADDR_SHORT	0x0800
 #define IEEE802154_FCTL_DADDR_EXTENDED	0x0c00
+#define IEEE802154_FCTL_SADDR_SHORT	0x8000
+#define IEEE802154_FCTL_SADDR_EXTENDED	0xc000
 
 /*
  * ieee802154_is_data - check if type is IEEE802154_FTYPE_DATA
@@ -277,6 +280,15 @@ static inline __le16 ieee802154_daddr_mode(__le16 fc)
 	return fc & cpu_to_le16(IEEE802154_FCTL_DADDR);
 }
 
+/*
+ * ieee802154_saddr_mode - get saddr mode from fc
+ * @fc: frame control bytes in little-endian byteorder
+ */
+static inline __le16 ieee802154_saddr_mode(__le16 fc)
+{
+	return fc & cpu_to_le16(IEEE802154_FCTL_SADDR);
+}
+
 /**
  * ieee802154_is_valid_psdu_len - check if psdu len is valid
  * available lengths:
diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index b3f7cd8..deb90a1 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -287,6 +287,52 @@ static inline unsigned char *ieee802154_skb_dst_pan(__le16 fc,
 }
 
 /**
+ * ieee802154_skb_src_pan - get the pointer to source pan field
+ * @fc: mac header frame control field
+ * @skb: skb where the source pan pointer will be get from
+ */
+static inline unsigned char *ieee802154_skb_src_pan(__le16 fc,
+						    const struct sk_buff *skb)
+{
+	unsigned char *src_pan;
+
+	switch (ieee802154_saddr_mode(fc)) {
+	case cpu_to_le16(IEEE802154_FCTL_ADDR_NONE):
+		src_pan = NULL;
+		break;
+	case cpu_to_le16(IEEE802154_FCTL_SADDR_SHORT):
+	case cpu_to_le16(IEEE802154_FCTL_SADDR_EXTENDED):
+		src_pan = skb_mac_header(skb) +
+			  IEEE802154_FC_LEN +
+			  IEEE802154_SEQ_LEN;
+
+		switch (ieee802154_daddr_mode(fc)) {
+		case cpu_to_le16(IEEE802154_FCTL_ADDR_NONE):
+			break;
+		case cpu_to_le16(IEEE802154_FCTL_DADDR_SHORT):
+			if (!ieee802154_is_intra_pan(fc))
+				src_pan += IEEE802154_SHORT_ADDR_LEN;
+			break;
+		case cpu_to_le16(IEEE802154_FCTL_DADDR_EXTENDED):
+			if (!ieee802154_is_intra_pan(fc))
+				src_pan += IEEE802154_EXTENDED_ADDR_LEN;
+			break;
+		default:
+			WARN_ONCE(1, "invalid addr mode detected");
+			src_pan = NULL;
+			break;
+		}
+		break;
+	default:
+		WARN_ONCE(1, "invalid addr mode detected");
+		src_pan = NULL;
+		break;
+	}
+
+	return src_pan;
+}
+
+/**
  * ieee802154_be64_to_le64 - copies and convert be64 to le64
  * @le64_dst: le64 destination pointer
  * @be64_src: be64 source pointer
-- 
2.8.3

