Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:44496 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620AbbBKNje (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 11 Feb 2015 08:39:34 -0500
Received: by mail-wi0-f179.google.com with SMTP id hi2so4990700wib.0
        for <linux-wpan@vger.kernel.org>; Wed, 11 Feb 2015 05:39:33 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 3/3] ieee802154: cleanup ieee802154_le64_to_be64
Date: Wed, 11 Feb 2015 14:39:17 +0100
Message-Id: <1423661957-3485-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1423661957-3485-1-git-send-email-alex.aring@gmail.com>
References: <1423661957-3485-1-git-send-email-alex.aring@gmail.com>
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
index c5c6445..fb4e8a3d 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -244,9 +244,7 @@ static inline void ieee802154_be64_to_le64(void *le64_dst, const void *be64_src)
  */
 static inline void ieee802154_le64_to_be64(void *be64_dst, const void *le64_src)
 {
-	__be64 tmp = (__force __be64)swab64p(le64_src);
-
-	memcpy(be64_dst, &tmp, IEEE802154_EXTENDED_ADDR_LEN);
+	__put_unaligned_memmove64(swab64p(le64_src), be64_dst);
 }
 
 /* Basic interface to register ieee802154 hwice */
-- 
2.3.0

