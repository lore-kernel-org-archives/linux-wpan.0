Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33544 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756338AbbIUJZK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Sep 2015 05:25:10 -0400
Received: by wiclk2 with SMTP id lk2so136953172wic.0
        for <linux-wpan@vger.kernel.org>; Mon, 21 Sep 2015 02:25:09 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 12/22] ieee802154: add helpers for frame control checks
Date: Mon, 21 Sep 2015 11:24:33 +0200
Message-Id: <1442827483-27975-13-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
References: <1442827483-27975-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, alan@signal11.us, jonatan@myeden.se, stefan@osg.samsung.com, Alexander Aring <alex.aring@gmail.com>

This patch introduce two static inline functions. The first to get the
frame control field from an sk_buff. The second is for checking on the
acknowledgment request bit on the frame control field. Later we can
introduce more functions to check on the frame control fields.

These will deprecate the current behaviour which requires a
host-byteorder conversion and manually bit handling.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/linux/ieee802154.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index db01492..7cda40d 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -25,6 +25,8 @@
 
 #include <linux/types.h>
 #include <linux/random.h>
+#include <linux/skbuff.h>
+#include <linux/unaligned/memmove.h>
 #include <asm/byteorder.h>
 
 #define IEEE802154_MTU			127
@@ -207,6 +209,7 @@ enum {
 
 /* frame control handling */
 #define IEEE802154_FCTL_FTYPE		0x0003
+#define IEEE802154_FCTL_ACKREQ		0x0020
 #define IEEE802154_FCTL_INTRA_PAN	0x0040
 
 #define IEEE802154_FTYPE_DATA		0x0001
@@ -222,6 +225,15 @@ static inline int ieee802154_is_data(__le16 fc)
 }
 
 /**
+ * ieee802154_is_ackreq - check if acknowledgment request bit is set
+ * @fc: frame control bytes in little-endian byteorder
+ */
+static inline bool ieee802154_is_ackreq(__le16 fc)
+{
+	return fc & cpu_to_le16(IEEE802154_FCTL_ACKREQ);
+}
+
+/**
  * ieee802154_is_intra_pan - check if intra pan id communication
  * @fc: frame control bytes in little-endian byteorder
  */
-- 
2.5.2

