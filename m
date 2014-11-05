Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:62643 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbaKETwT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 5 Nov 2014 14:52:19 -0500
Received: by mail-wi0-f171.google.com with SMTP id r20so1076522wiv.4
        for <linux-wpan@vger.kernel.org>; Wed, 05 Nov 2014 11:52:18 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 11/18] ieee802154: add ieee802154_random_extended_addr
Date: Wed,  5 Nov 2014 20:51:22 +0100
Message-Id: <1415217089-24919-12-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
References: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a new function to generate a random IEEE 802.15.4
extended address.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/linux/ieee802154.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index a907fe5..d043449 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -24,6 +24,7 @@
 #define LINUX_IEEE802154_H
 
 #include <linux/types.h>
+#include <linux/random.h>
 #include <asm/byteorder.h>
 
 #define IEEE802154_MTU			127
@@ -215,4 +216,17 @@ static inline bool ieee802154_is_valid_extended_addr(const __le64 addr)
 		(addr != cpu_to_le64(0xffffffffffffffffULL)));
 }
 
+/**
+ * ieee802154_random_extended_addr - generates a random extended address
+ * @addr: extended addr pointer to place the random address
+ */
+static inline void ieee802154_random_extended_addr(__le64 *addr)
+{
+	get_random_bytes(addr, IEEE802154_EXTENDED_ADDR_LEN);
+
+	/* toggle some bit if we hit an invalid extended addr */
+	if (!ieee802154_is_valid_extended_addr(*addr))
+		((u8 *)addr)[IEEE802154_EXTENDED_ADDR_LEN - 1] ^= 0x01;
+}
+
 #endif /* LINUX_IEEE802154_H */
-- 
2.1.3

