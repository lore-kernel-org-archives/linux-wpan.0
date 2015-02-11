Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:48371 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662AbbBKNje (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 11 Feb 2015 08:39:34 -0500
Received: by mail-wi0-f173.google.com with SMTP id bs8so20312121wib.0
        for <linux-wpan@vger.kernel.org>; Wed, 11 Feb 2015 05:39:32 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 2/3] ieee802154: cleanup ieee802154_be64_to_le64
Date: Wed, 11 Feb 2015 14:39:16 +0100
Message-Id: <1423661957-3485-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1423661957-3485-1-git-send-email-alex.aring@gmail.com>
References: <1423661957-3485-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch cleanups the ieee802154_be64_to_le64 function. This patch
removes an unnecessary temporary variable.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/mac802154.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 8506478..c5c6445 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -19,6 +19,7 @@
 #include <net/af_ieee802154.h>
 #include <linux/ieee802154.h>
 #include <linux/skbuff.h>
+#include <linux/unaligned/memmove.h>
 
 #include <net/cfg802154.h>
 
@@ -233,9 +234,7 @@ struct ieee802154_ops {
  */
 static inline void ieee802154_be64_to_le64(void *le64_dst, const void *be64_src)
 {
-	__le64 tmp = (__force __le64)swab64p(be64_src);
-
-	memcpy(le64_dst, &tmp, IEEE802154_EXTENDED_ADDR_LEN);
+	__put_unaligned_memmove64(swab64p(be64_src), le64_dst);
 }
 
 /**
-- 
2.3.0

