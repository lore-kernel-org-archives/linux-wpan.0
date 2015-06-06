Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:35400 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973AbbFFPbM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 6 Jun 2015 11:31:12 -0400
Received: by wiga1 with SMTP id a1so46571650wig.0
        for <linux-wpan@vger.kernel.org>; Sat, 06 Jun 2015 08:31:11 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 6/8] mac802154: rearrange attribute in ieee802154_hw
Date: Sat,  6 Jun 2015 17:30:51 +0200
Message-Id: <1433604653-9585-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1433604653-9585-1-git-send-email-alex.aring@gmail.com>
References: <1433604653-9585-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes the priv attribute in ieee802154_hw to the right
section which is commented by attributes which needs to be filled by
driver layer.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/mac802154.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 61d4b80..d8e9e6f 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -72,9 +72,9 @@ struct ieee802154_hw {
 	int	extra_tx_headroom;
 	u32	flags;
 	struct	device *parent;
+	void	*priv;
 
 	/* filled by mac802154 core */
-	void	*priv;
 	struct	wpan_phy *phy;
 };
 
-- 
2.4.1

