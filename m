Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:42000 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620AbbBKNjd (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 11 Feb 2015 08:39:33 -0500
Received: by mail-we0-f181.google.com with SMTP id w62so3457927wes.12
        for <linux-wpan@vger.kernel.org>; Wed, 11 Feb 2015 05:39:31 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 1/3] ieee802154: correct ieee802154_is_valid_psdu_len
Date: Wed, 11 Feb 2015 14:39:15 +0100
Message-Id: <1423661957-3485-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1423661957-3485-1-git-send-email-alex.aring@gmail.com>
References: <1423661957-3485-1-git-send-email-alex.aring@gmail.com>
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
2.3.0

