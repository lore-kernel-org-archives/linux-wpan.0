Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:51002 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbbBJWO5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 10 Feb 2015 17:14:57 -0500
Received: by mail-we0-f177.google.com with SMTP id l61so36482047wev.8
        for <linux-wpan@vger.kernel.org>; Tue, 10 Feb 2015 14:14:56 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 3/3] ieee802154: cleanup ieee802154_le64_to_be64
Date: Tue, 10 Feb 2015 23:14:21 +0100
Message-Id: <1423606461-16945-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1423606461-16945-1-git-send-email-alex.aring@gmail.com>
References: <1423606461-16945-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch cleanups the ieee802154_le64_to_be64 function. This patch
removes an unnecessary temporary variable.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/mac802154.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index a4dcefe..1362eb5 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -243,9 +243,7 @@ static inline void ieee802154_be64_to_le64(void *le64_dst, const void *be64_src)
  */
 static inline void ieee802154_le64_to_be64(void *be64_dst, const void *le64_src)
 {
-	__be64 tmp = (__force __be64)swab64p(le64_src);
-
-	memcpy(be64_dst, &tmp, IEEE802154_EXTENDED_ADDR_LEN);
+	*((__be64 *)be64_dst) = (__force __be64)swab64p(le64_src);
 }
 
 /* Basic interface to register ieee802154 hwice */
-- 
2.2.2

