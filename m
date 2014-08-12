Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:40196 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbaHLNOh (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 12 Aug 2014 09:14:37 -0400
Received: by mail-la0-f47.google.com with SMTP id mc6so7758810lab.6
        for <linux-wpan@vger.kernel.org>; Tue, 12 Aug 2014 06:14:36 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Tue, 12 Aug 2014 15:14:09 +0200
Message-Id: <1407849255-11500-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407849255-11500-1-git-send-email-alex.aring@gmail.com>
References: <1407849255-11500-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 05/11] nl802154: add missing endif comment
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/linux/nl802154.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nl802154.h b/include/linux/nl802154.h
index 3058544..c33b468 100644
--- a/include/linux/nl802154.h
+++ b/include/linux/nl802154.h
@@ -182,4 +182,4 @@ enum nl802154_iftype {
 	NL802154_IFTYPE_MAX = NUM_NL802154_IFTYPES - 1
 };
 
-#endif
+#endif /* NL802154_H */
-- 
2.0.3

