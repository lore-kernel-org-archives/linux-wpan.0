Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:62466 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754084AbaJ2Ufu (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 16:35:50 -0400
Received: by mail-wg0-f50.google.com with SMTP id z12so2761871wgg.37
        for <linux-wpan@vger.kernel.org>; Wed, 29 Oct 2014 13:35:49 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 01/17] mac802154: main: remove unnecessary include
Date: Wed, 29 Oct 2014 21:34:28 +0100
Message-Id: <1414614884-20243-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
References: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes an unnecessary include of driver-ops header file.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 21dcc56..86e533e 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -28,7 +28,6 @@
 #include <net/cfg802154.h>
 
 #include "ieee802154_i.h"
-#include "driver-ops.h"
 
 static int
 mac802154_netdev_register(struct wpan_phy *phy, struct net_device *dev)
-- 
2.1.2

