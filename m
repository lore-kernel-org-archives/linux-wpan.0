Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:33661 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704AbaJYDZi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Oct 2014 23:25:38 -0400
Received: by mail-la0-f52.google.com with SMTP id hz20so3605883lab.11
        for <linux-wpan@vger.kernel.org>; Fri, 24 Oct 2014 20:25:37 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 4/6] ieee802154: wpan-phy: change to __aligned(size)
Date: Sat, 25 Oct 2014 05:25:10 +0200
Message-Id: <1414207512-10281-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414207512-10281-1-git-send-email-alex.aring@gmail.com>
References: <1414207512-10281-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch fix a checkpatch warning that __aligned(size) is preferred
over __attribute__((aligned(size))).

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/wpan-phy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/wpan-phy.h b/include/net/wpan-phy.h
index 65a05f1..fa827c9 100644
--- a/include/net/wpan-phy.h
+++ b/include/net/wpan-phy.h
@@ -65,7 +65,7 @@ struct wpan_phy {
 			       u8 retries);
 	int (*set_frame_retries)(struct wpan_phy *phy, s8 retries);
 
-	char priv[0] __attribute__((__aligned__(NETDEV_ALIGN)));
+	char priv[0] __aligned(NETDEV_ALIGN);
 };
 
 #define to_phy(_dev)	container_of(_dev, struct wpan_phy, dev)
-- 
2.1.2

