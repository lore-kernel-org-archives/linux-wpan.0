Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from r0.smtpout1.alwaysdata.com ([176.31.58.0]:56917 "EHLO
	r0.smtpout1.alwaysdata.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750741AbcCNUrX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 14 Mar 2016 16:47:23 -0400
From: Alexandre Macabies <web+oss@zopieux.com>
Subject: [PATCH v2 1/3] ieee802154: add security bit check function
Date: Mon, 14 Mar 2016 21:46:12 +0100
Message-Id: <1457988374-31220-1-git-send-email-web+oss@zopieux.com>
In-Reply-To: <1457633643-12535-1-git-send-email-web+oss@zopieux.com>
References: <1457633643-12535-1-git-send-email-web+oss@zopieux.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexandre Macabies <web+oss@zopieux.com>, Alexander Aring <aar@pengutronix.de>

ieee802154_is_secen checks if the 802.15.4 security bit is set in the
frame control field.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
Signed-off-by: Alexandre Macabies <web+oss@zopieux.com>
Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 include/linux/ieee802154.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index d3e4156..56090f1 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -218,6 +218,7 @@ enum {
 /* frame control handling */
 #define IEEE802154_FCTL_FTYPE		0x0003
 #define IEEE802154_FCTL_ACKREQ		0x0020
+#define IEEE802154_FCTL_SECEN		0x0004
 #define IEEE802154_FCTL_INTRA_PAN	0x0040
 
 #define IEEE802154_FTYPE_DATA		0x0001
@@ -233,6 +234,15 @@ static inline int ieee802154_is_data(__le16 fc)
 }
 
 /**
+ * ieee802154_is_secen - check if Security bit is set
+ * @fc: frame control bytes in little-endian byteorder
+ */
+static inline bool ieee802154_is_secen(__le16 fc)
+{
+	return fc & cpu_to_le16(IEEE802154_FCTL_SECEN);
+}
+
+/**
  * ieee802154_is_ackreq - check if acknowledgment request bit is set
  * @fc: frame control bytes in little-endian byteorder
  */
-- 
2.7.3

