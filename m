Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:54898 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752351AbdIVMOa (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 22 Sep 2017 08:14:30 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH 14/14] ieee802154: fakelb: switch from BUG_ON() to WARN_ON() on problem
Date: Fri, 22 Sep 2017 14:14:05 +0200
Message-Id: <20170922121405.31789-15-stefan@osg.samsung.com>
In-Reply-To: <20170922121405.31789-1-stefan@osg.samsung.com>
References: <20170922121405.31789-1-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aring@mojatatu.com>, michael.hennerich@analog.com, h.morris@cascoda.com, linuxdev@cascoda.com, varkabhadram@gmail.com, alan@signal11.us, Stefan Schmidt <stefan@osg.samsung.com>

The check is valid but it does not warrant to crash the kernel. A
WARN_ON() is good enough here.
Found by checkpatch.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/fakelb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index 0d673f7682ee..176395e4b7bb 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -49,7 +49,7 @@ struct fakelb_phy {
 
 static int fakelb_hw_ed(struct ieee802154_hw *hw, u8 *level)
 {
-	BUG_ON(!level);
+	WARN_ON(!level);
 	*level = 0xbe;
 
 	return 0;
-- 
2.13.5

