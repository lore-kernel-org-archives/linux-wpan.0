Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:43135 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325AbbFHUGx (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 8 Jun 2015 16:06:53 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH] mac802154/iface: remove superfluous WARN_ON call in slave_open()
Date: Mon,  8 Jun 2015 22:06:40 +0200
Message-Id: <1433794000-10501-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

This call was used before we aligned our code with the wireless code base. We
are wanted to handle this in the err: code path. Which would actually not work
because the WARN_ON() macro would reset the res value to 0 and thus we would
never hit err:. Removing it makes the code do what we actually intend.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 net/mac802154/iface.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 3a67d35..e3d77b0 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -147,7 +147,6 @@ static int mac802154_slave_open(struct net_device *dev)
 
 	if (!local->open_count) {
 		res = drv_start(local);
-		WARN_ON(res);
 		if (res)
 			goto err;
 	}
-- 
2.1.0

