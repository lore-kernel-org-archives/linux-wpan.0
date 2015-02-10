Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:65447 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbbBJWO4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 10 Feb 2015 17:14:56 -0500
Received: by mail-we0-f173.google.com with SMTP id w55so25046642wes.4
        for <linux-wpan@vger.kernel.org>; Tue, 10 Feb 2015 14:14:55 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/3] ieee802154: cleanup ieee802154_be64_to_le64
Date: Tue, 10 Feb 2015 23:14:20 +0100
Message-Id: <1423606461-16945-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1423606461-16945-1-git-send-email-alex.aring@gmail.com>
References: <1423606461-16945-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch cleanups the ieee802154_be64_to_le64 function. This patch
removes an unnecessary temporary variable.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/mac802154.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 8506478..a4dcefe 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -233,9 +233,7 @@ struct ieee802154_ops {
  */
 static inline void ieee802154_be64_to_le64(void *le64_dst, const void *be64_src)
 {
-	__le64 tmp = (__force __le64)swab64p(be64_src);
-
-	memcpy(le64_dst, &tmp, IEEE802154_EXTENDED_ADDR_LEN);
+	*((__le64 *)le64_dst) = (__force __le64)swab64p(be64_src);
 }
 
 /**
-- 
2.2.2

