Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:44876 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbaKBDTZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 1 Nov 2014 23:19:25 -0400
Received: by mail-wi0-f177.google.com with SMTP id ex7so3936915wid.16
        for <linux-wpan@vger.kernel.org>; Sat, 01 Nov 2014 20:19:24 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 14/16] ieee802154: add extended address validation helper
Date: Sun,  2 Nov 2014 04:18:45 +0100
Message-Id: <1414898327-20759-15-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
References: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch introduce an extended address validation helper to check if
an extended address is valid or not.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/linux/ieee802154.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index 6e50a2a..9bba5ca 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -197,4 +197,18 @@ static inline bool ieee802154_is_valid_psdu_len(const u8 len)
 	return (len >= IEEE802154_MIN_PSDU_LEN && len <= IEEE802154_MTU);
 }
 
+/**
+ * ieee802154_is_valid_psdu_len - check if extended addr is valid
+ * @addr: extended addr to check
+ */
+static inline bool ieee802154_is_valid_extended_addr(const __le64 addr)
+{
+	/* These EUI-64 addresses are reserved by IEEE. 0xffffffffffffffff
+	 * is used internally as extended to short address broadcast mapping.
+	 * This is currently a workaround because neighbor discovery can't
+	 * deal with short addresses types right now.
+	 */
+	return ((addr != 0x0000000000000000) || (addr != 0xffffffffffffffff));
+}
+
 #endif /* LINUX_IEEE802154_H */
-- 
2.1.3

