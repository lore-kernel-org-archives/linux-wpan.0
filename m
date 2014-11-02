Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:63357 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbaKBDTN (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 1 Nov 2014 23:19:13 -0400
Received: by mail-wi0-f171.google.com with SMTP id q5so4005775wiv.4
        for <linux-wpan@vger.kernel.org>; Sat, 01 Nov 2014 20:19:12 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 02/16] ieee802154: remove default channel settings
Date: Sun,  2 Nov 2014 04:18:33 +0100
Message-Id: <1414898327-20759-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
References: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes the default channel setting. A channel is always set
and there is no default channel setting according 802.15.4.

Drivers should set the default channel and page in probing routine. This
behaviour is currently a lack of all 802.15.4 drivers.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index 620abc2..dc294a4 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -100,9 +100,6 @@ struct wpan_phy *wpan_phy_alloc(size_t priv_size)
 
 	phy->dev.class = &wpan_phy_class;
 
-	phy->current_channel = -1; /* not initialised */
-	phy->current_page = 0; /* for compatibility */
-
 	return phy;
 
 out:
-- 
2.1.3

