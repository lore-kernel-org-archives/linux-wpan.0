Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:46829 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461AbbBJWOz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 10 Feb 2015 17:14:55 -0500
Received: by mail-wi0-f169.google.com with SMTP id z2so16383685wiv.0
        for <linux-wpan@vger.kernel.org>; Tue, 10 Feb 2015 14:14:54 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/3] ieee802154: correct ieee802154_is_valid_psdu_len
Date: Tue, 10 Feb 2015 23:14:19 +0100
Message-Id: <1423606461-16945-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1423606461-16945-1-git-send-email-alex.aring@gmail.com>
References: <1423606461-16945-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch corrects the ieee802154_is_valid_psdu_len function that this
function also checks on reserved values 6-8 for validation the psdu
length.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/linux/ieee802154.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index 6e82d88..40b0ab9 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -28,7 +28,8 @@
 #include <asm/byteorder.h>
 
 #define IEEE802154_MTU			127
-#define IEEE802154_MIN_PSDU_LEN		5
+#define IEEE802154_ACK_PSDU_LEN		5
+#define IEEE802154_MIN_PSDU_LEN		9
 
 #define IEEE802154_PAN_ID_BROADCAST	0xffff
 #define IEEE802154_ADDR_SHORT_BROADCAST	0xffff
@@ -204,11 +205,18 @@ enum {
 
 /**
  * ieee802154_is_valid_psdu_len - check if psdu len is valid
+ * available lengths:
+ *	0-4	Reserved
+ *	5	MPDU (Acknowledgment)
+ *	6-8	Reserved
+ *	9-127	MPDU
+ *
  * @len: psdu len with (MHR + payload + MFR)
  */
 static inline bool ieee802154_is_valid_psdu_len(const u8 len)
 {
-	return (len >= IEEE802154_MIN_PSDU_LEN && len <= IEEE802154_MTU);
+	return (len == IEEE802154_ACK_PSDU_LEN ||
+		(len >= IEEE802154_MIN_PSDU_LEN && len <= IEEE802154_MTU));
 }
 
 /**
-- 
2.2.2

