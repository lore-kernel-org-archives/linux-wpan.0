Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35394 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782AbbFFPbL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 6 Jun 2015 11:31:11 -0400
Received: by wiga1 with SMTP id a1so46571455wig.0
        for <linux-wpan@vger.kernel.org>; Sat, 06 Jun 2015 08:31:10 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 5/8] mac802154: remove unused hw_filt attribute
Date: Sat,  6 Jun 2015 17:30:50 +0200
Message-Id: <1433604653-9585-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1433604653-9585-1-git-send-email-alex.aring@gmail.com>
References: <1433604653-9585-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removed an attribute from ieee802154_hw structure which is
never used inside kernel. Address information are stored inside wpan_dev
nowadays.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/mac802154.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index c21a700..61d4b80 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -74,7 +74,6 @@ struct ieee802154_hw {
 	struct	device *parent;
 
 	/* filled by mac802154 core */
-	struct	ieee802154_hw_addr_filt hw_filt;
 	void	*priv;
 	struct	wpan_phy *phy;
 };
-- 
2.4.1

