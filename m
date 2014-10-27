Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:56165 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbaJ0Lnu (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Oct 2014 07:43:50 -0400
Received: by mail-lb0-f180.google.com with SMTP id z12so2068955lbi.39
        for <linux-wpan@vger.kernel.org>; Mon, 27 Oct 2014 04:43:49 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 13/16] ieee802154: add valid psdu length helper
Date: Mon, 27 Oct 2014 12:43:06 +0100
Message-Id: <1414410189-20092-14-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414410189-20092-1-git-send-email-alex.aring@gmail.com>
References: <1414410189-20092-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a generic valid psdu length check function helper. This
is useful to check the length field after receiving. For example the
at86rf231 doesn't filter invalid psdu length. Sometimes the CRC can also
be correct. If we get the lqi value with an invalid frame length the
kernel may crash because we dereference an invalid pointer in the
receive buffer.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/linux/ieee802154.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index 2dfab2d..73285a3 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -23,7 +23,10 @@
 #ifndef LINUX_IEEE802154_H
 #define LINUX_IEEE802154_H
 
+#include <linux/types.h>
+
 #define IEEE802154_MTU			127
+#define IEEE802154_MIN_PSDU_LEN		5
 
 #define IEEE802154_FC_TYPE_BEACON	0x0	/* Frame is beacon */
 #define	IEEE802154_FC_TYPE_DATA		0x1	/* Frame is data */
@@ -185,5 +188,13 @@ enum {
 	IEEE802154_SCAN_IN_PROGRESS = 0xfc,
 };
 
+/**
+ * ieee802154_is_valid_psdu_len - check if psdu len is valid
+ * @len: psdu len with (MHR + payload + MFR)
+ */
+static inline bool ieee802154_is_valid_psdu_len(const u8 len)
+{
+	return (len <= IEEE802154_MTU || len >= IEEE802154_MIN_PSDU_LEN);
+}
 
 #endif /* LINUX_IEEE802154_H */
-- 
2.1.2

