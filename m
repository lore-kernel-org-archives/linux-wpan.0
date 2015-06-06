Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36551 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbbFFPbP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 6 Jun 2015 11:31:15 -0400
Received: by wigg3 with SMTP id g3so12510510wig.1
        for <linux-wpan@vger.kernel.org>; Sat, 06 Jun 2015 08:31:14 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 8/8] mac802154: change pan_coord type to bool
Date: Sat,  6 Jun 2015 17:30:53 +0200
Message-Id: <1433604653-9585-9-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1433604653-9585-1-git-send-email-alex.aring@gmail.com>
References: <1433604653-9585-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

To indicate if it's a coordinator or not a bool is enough. There should
no more values available which represent some other state.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/mac802154.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 095c9d0..de1cdde 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -71,7 +71,7 @@ struct ieee802154_hw_addr_filt {
 	__le16	pan_id;
 	__le16	short_addr;
 	__le64	ieee_addr;
-	u8	pan_coord;
+	bool	pan_coord;
 };
 
 /**
-- 
2.4.1

