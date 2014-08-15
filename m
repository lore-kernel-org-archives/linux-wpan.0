Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:43977 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032AbaHOKaK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 15 Aug 2014 06:30:10 -0400
Received: by mail-wg0-f45.google.com with SMTP id x12so2206645wgg.16
        for <linux-wpan@vger.kernel.org>; Fri, 15 Aug 2014 03:30:09 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Fri, 15 Aug 2014 12:29:50 +0200
Message-Id: <1408098592-13412-11-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1408098592-13412-1-git-send-email-alex.aring@gmail.com>
References: <1408098592-13412-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 10/12] ieee802154: add valid frame length helper
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch adds a generic valid frame length check function helper. This
is useful to check the length field after receiving. For example the
at86rf231 doesn't filter invalid frame length. Sometimes the CRC can be
also correct. If we get the lqi value with a invalid frame length the
kernel can be crash, because we dereference an invalid pointer.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/ieee802154.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/ieee802154.h b/include/net/ieee802154.h
index 0aa7122..185260b 100644
--- a/include/net/ieee802154.h
+++ b/include/net/ieee802154.h
@@ -28,6 +28,7 @@
 #define NET_IEEE802154_H
 
 #define IEEE802154_MTU			127
+#define IEEE802154_MIN_FRAME_SIZE	5
 
 #define IEEE802154_FC_TYPE_BEACON	0x0	/* Frame is beacon */
 #define	IEEE802154_FC_TYPE_DATA		0x1	/* Frame is data */
@@ -189,7 +190,12 @@ enum {
 	IEEE802154_SCAN_IN_PROGRESS = 0xfc,
 };
 
+static inline bool ieee802154_is_valid_frame_len(const u8 len)
+{
+	if (unlikely(len > IEEE802154_MTU || len < IEEE802154_MIN_FRAME_SIZE))
+		return false;
 
-#endif
-
+	return true;
+}
 
+#endif
-- 
2.0.3

