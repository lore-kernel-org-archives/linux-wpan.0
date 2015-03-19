Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx1.polytechnique.org ([129.104.30.34]:58572 "EHLO
	mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbbCSNX4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 19 Mar 2015 09:23:56 -0400
From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Subject: [PATCH] mac802154: fix typo in header guard
Date: Thu, 19 Mar 2015 21:23:40 +0800
Message-Id: <1426771420-29979-1-git-send-email-nicolas.iooss_linux@m4x.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: alex.aring@gmail.com, linux-wpan@vger.kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Iooss <nicolas.iooss_linux@m4x.org>

Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Fixes: b6eea9ca354a ("mac802154: introduce driver-ops header")
---
 net/mac802154/driver-ops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/driver-ops.h b/net/mac802154/driver-ops.h
index 98180a9fff4a..a0533357b9ea 100644
--- a/net/mac802154/driver-ops.h
+++ b/net/mac802154/driver-ops.h
@@ -1,4 +1,4 @@
-#ifndef __MAC802154_DRVIER_OPS
+#ifndef __MAC802154_DRIVER_OPS
 #define __MAC802154_DRIVER_OPS
 
 #include <linux/types.h>
@@ -220,4 +220,4 @@ drv_set_promiscuous_mode(struct ieee802154_local *local, bool on)
 	return local->ops->set_promiscuous_mode(&local->hw, on);
 }
 
-#endif /* __MAC802154_DRVIER_OPS */
+#endif /* __MAC802154_DRIVER_OPS */
-- 
2.3.3

