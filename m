Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33065 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755046AbbG3I5K (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 30 Jul 2015 04:57:10 -0400
Received: by wicmv11 with SMTP id mv11so12182752wic.0
        for <linux-wpan@vger.kernel.org>; Thu, 30 Jul 2015 01:57:09 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFCv3 bluetooth-next 2/6] ieee802154: add helpers for frame control checks
Date: Thu, 30 Jul 2015 10:55:38 +0200
Message-Id: <1438246542-17633-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1438246542-17633-1-git-send-email-alex.aring@gmail.com>
References: <1438246542-17633-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch introduce two static inline functions. The first to get the
frame control field from an sk_buff. The second is for checking on the
acknowledgment request bit on the frame control field. Later we can
introduce more functions to check on the frame control fields.

These will deprecate the current behaviour which requires a
host-byteorder conversion and manually bit handling.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/linux/ieee802154.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index 1dc1f4e..4f26c01 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -25,6 +25,8 @@
 
 #include <linux/types.h>
 #include <linux/random.h>
+#include <linux/skbuff.h>
+#include <linux/unaligned/memmove.h>
 #include <asm/byteorder.h>
 
 #define IEEE802154_MTU			127
@@ -205,6 +207,33 @@ enum {
 	IEEE802154_SCAN_IN_PROGRESS = 0xfc,
 };
 
+/* frame control handling */
+#define IEEE802154_FCTL_ACKREQ	0x0020
+
+/**
+ * ieee802154_is_ackreq - check if acknowledgment request bit is set
+ * @fc: frame control bytes in little-endian byteorder
+ */
+static inline bool ieee802154_is_ackreq(__le16 fc)
+{
+	return fc & cpu_to_le16(IEEE802154_FCTL_ACKREQ);
+}
+
+/**
+ * ieee802154_get_fc_from_skb - get the frame control field from an skb
+ * @skb: skb where the frame control field will be get from
+ */
+static inline __le16 ieee802154_get_fc_from_skb(const struct sk_buff *skb)
+{
+	/* return some invalid fc on failure */
+	if (unlikely(skb->mac_len < 2)) {
+		WARN_ON(1);
+		return cpu_to_le16(0);
+	}
+
+	return (__force __le16)__get_unaligned_memmove16(skb_mac_header(skb));
+}
+
 /**
  * ieee802154_is_valid_psdu_len - check if psdu len is valid
  * available lengths:
-- 
2.5.0

