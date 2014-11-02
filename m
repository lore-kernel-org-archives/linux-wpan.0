Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:59590 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbaKBUnX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 2 Nov 2014 15:43:23 -0500
Received: by mail-wg0-f52.google.com with SMTP id b13so9161661wgh.25
        for <linux-wpan@vger.kernel.org>; Sun, 02 Nov 2014 12:43:22 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/6] ieee802154: add missing ULL definition
Date: Sun,  2 Nov 2014 21:43:01 +0100
Message-Id: <1414960986-7051-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414960986-7051-1-git-send-email-alex.aring@gmail.com>
References: <1414960986-7051-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Running make C=2 occurs warning:

constant 0xffffffffffffffff is so big it is unsigned long

This patch fix this warning by adding a ULL to the constant definitions.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reported-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/linux/ieee802154.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index 9bba5ca..9da7c01 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -208,7 +208,8 @@ static inline bool ieee802154_is_valid_extended_addr(const __le64 addr)
 	 * This is currently a workaround because neighbor discovery can't
 	 * deal with short addresses types right now.
 	 */
-	return ((addr != 0x0000000000000000) || (addr != 0xffffffffffffffff));
+	return ((addr != 0x0000000000000000ULL) ||
+		(addr != 0xffffffffffffffffULL));
 }
 
 #endif /* LINUX_IEEE802154_H */
-- 
2.1.3

