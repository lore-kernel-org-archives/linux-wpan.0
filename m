Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34045 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbaKBUn0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 2 Nov 2014 15:43:26 -0500
Received: by mail-wi0-f176.google.com with SMTP id h11so4975318wiw.3
        for <linux-wpan@vger.kernel.org>; Sun, 02 Nov 2014 12:43:25 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 3/6] mac802154: fix byteorder issues
Date: Sun,  2 Nov 2014 21:43:03 +0100
Message-Id: <1414960986-7051-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414960986-7051-1-git-send-email-alex.aring@gmail.com>
References: <1414960986-7051-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Running make C=2 occurs these warnings:

cast from restricted __be64
incorrect type in argument 1 (different base types)
expected unsigned long long[unsigned] [usertype] val
got restricted __be64 [usertype]<noident>
cast from restricted __be64
cast to restricted __le64

This patch fix these warnings by forcing to __le64 type and using swabp64
instead swab64.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reported-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/mac802154.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index c17acbd..8b0c26b 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -215,12 +215,12 @@ struct ieee802154_ops {
 };
 
 /**
- * ieee802154_netdev_to_extended_addr - convert __be64 u8 pointer to __le64
+ * ieee802154_netdev_to_extended_addr - convert big endian 64 byte void pointer to __le64
  * @dev_addr: big endian address pointer like netdevice dev_addr attribute
  */
-static inline __le64 ieee802154_netdev_to_extended_addr(const u8 *dev_addr)
+static inline __le64 ieee802154_netdev_to_extended_addr(const void *dev_addr)
 {
-	return (__le64)swab64(*((__be64 *)dev_addr));
+	return (__force __le64)swab64p(dev_addr);
 }
 
 /* Basic interface to register ieee802154 hwice */
-- 
2.1.3

