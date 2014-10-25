Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:57116 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602AbaJYDZj (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Oct 2014 23:25:39 -0400
Received: by mail-la0-f47.google.com with SMTP id pv20so3505609lab.6
        for <linux-wpan@vger.kernel.org>; Fri, 24 Oct 2014 20:25:38 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 5/6] ieee802154: wpan-phy: use blank line after function
Date: Sat, 25 Oct 2014 05:25:11 +0200
Message-Id: <1414207512-10281-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414207512-10281-1-git-send-email-alex.aring@gmail.com>
References: <1414207512-10281-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a blank line after function declaration.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/wpan-phy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/wpan-phy.h b/include/net/wpan-phy.h
index fa827c9..1e9795f 100644
--- a/include/net/wpan-phy.h
+++ b/include/net/wpan-phy.h
@@ -75,6 +75,7 @@ static inline void wpan_phy_set_dev(struct wpan_phy *phy, struct device *dev)
 {
 	phy->dev.parent = dev;
 }
+
 int wpan_phy_register(struct wpan_phy *phy);
 void wpan_phy_unregister(struct wpan_phy *phy);
 void wpan_phy_free(struct wpan_phy *phy);
-- 
2.1.2

