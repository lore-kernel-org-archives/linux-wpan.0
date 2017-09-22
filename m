Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:54825 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752148AbdIVMOQ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 22 Sep 2017 08:14:16 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH 01/14] ieee802154: adf7242: use unsigned int over only unsigned
Date: Fri, 22 Sep 2017 14:13:52 +0200
Message-Id: <20170922121405.31789-2-stefan@osg.samsung.com>
In-Reply-To: <20170922121405.31789-1-stefan@osg.samsung.com>
References: <20170922121405.31789-1-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aring@mojatatu.com>, michael.hennerich@analog.com, h.morris@cascoda.com, linuxdev@cascoda.com, varkabhadram@gmail.com, alan@signal11.us, Stefan Schmidt <stefan@osg.samsung.com>

Bring it in line with the rest of the ieee802154 drivers.
Found by checkpatch.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/adf7242.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index 3e4c8b21403c..400fdbd3a120 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -311,8 +311,8 @@ static int adf7242_status(struct adf7242_local *lp, u8 *stat)
 	return status;
 }
 
-static int adf7242_wait_status(struct adf7242_local *lp, unsigned status,
-			       unsigned mask, int line)
+static int adf7242_wait_status(struct adf7242_local *lp, unsigned int status,
+			       unsigned int mask, int line)
 {
 	int cnt = 0, ret = 0;
 	u8 stat;
@@ -477,7 +477,7 @@ static int adf7242_write_reg(struct adf7242_local *lp, u16 addr, u8 data)
 	return status;
 }
 
-static int adf7242_cmd(struct adf7242_local *lp, unsigned cmd)
+static int adf7242_cmd(struct adf7242_local *lp, unsigned int cmd)
 {
 	int status;
 
@@ -920,7 +920,7 @@ static void adf7242_debug(u8 irq1)
 static irqreturn_t adf7242_isr(int irq, void *data)
 {
 	struct adf7242_local *lp = data;
-	unsigned xmit;
+	unsigned int xmit;
 	u8 irq1;
 
 	adf7242_wait_status(lp, RC_STATUS_PHY_RDY, RC_STATUS_MASK, __LINE__);
-- 
2.13.5

