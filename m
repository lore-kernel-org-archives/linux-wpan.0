Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:40942 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbaKBUnY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 2 Nov 2014 15:43:24 -0500
Received: by mail-wi0-f171.google.com with SMTP id q5so4980452wiv.4
        for <linux-wpan@vger.kernel.org>; Sun, 02 Nov 2014 12:43:23 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/6] ieee802154: fix byteorder issues
Date: Sun,  2 Nov 2014 21:43:02 +0100
Message-Id: <1414960986-7051-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414960986-7051-1-git-send-email-alex.aring@gmail.com>
References: <1414960986-7051-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch fix byteorder issues which occurs because we compare __le64
with an host byteorder value. Simple add a cpu_to_le64 to convert the
host byteorder values to __le64.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reported-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/linux/ieee802154.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index 9da7c01..5d9e745 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -24,6 +24,7 @@
 #define LINUX_IEEE802154_H
 
 #include <linux/types.h>
+#include <asm/byteorder.h>
 
 #define IEEE802154_MTU			127
 #define IEEE802154_MIN_PSDU_LEN		5
@@ -208,8 +209,8 @@ static inline bool ieee802154_is_valid_extended_addr(const __le64 addr)
 	 * This is currently a workaround because neighbor discovery can't
 	 * deal with short addresses types right now.
 	 */
-	return ((addr != 0x0000000000000000ULL) ||
-		(addr != 0xffffffffffffffffULL));
+	return ((addr != cpu_to_le64(0x0000000000000000ULL)) ||
+		(addr != cpu_to_le64(0xffffffffffffffffULL)));
 }
 
 #endif /* LINUX_IEEE802154_H */
-- 
2.1.3

