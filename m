Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-dm3nam03on0073.outbound.protection.outlook.com ([104.47.41.73]:40072
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751144AbdK1Muj (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 28 Nov 2017 07:50:39 -0500
From: <michael.hennerich@analog.com>
Subject: [PATCH 3/5] net: ieee802154: adf7242: Add additional DEBUG information
Date: Tue, 28 Nov 2017 13:53:13 +0100
Message-ID: <1511873595-29238-3-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1511873595-29238-1-git-send-email-michael.hennerich@analog.com>
References: <1511873595-29238-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: alex.aring@gmail.com, stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

This adds missing status bits and improves the DEBUG prints.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/net/ieee802154/adf7242.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index a11948a..ce1a6d2 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -906,9 +906,12 @@ static void adf7242_debug(struct adf7242_local *lp, u8 irq1)
 		irq1 & IRQ_FRAME_VALID ? "IRQ_FRAME_VALID\n" : "",
 		irq1 & IRQ_ADDRESS_VALID ? "IRQ_ADDRESS_VALID\n" : "");
 
-	dev_dbg(&lp->spi->dev, "%s STATUS = %X:\n%s\n%s%s%s%s%s\n",
+	dev_dbg(&lp->spi->dev, "%s STATUS = %X:\n%s\n%s\n%s\n%s\n%s%s%s%s%s\n",
 		__func__, stat,
+		stat & STAT_SPI_READY ? "SPI_READY" : "SPI_BUSY",
+		stat & STAT_IRQ_STATUS ? "IRQ_PENDING" : "IRQ_CLEAR",
 		stat & STAT_RC_READY ? "RC_READY" : "RC_BUSY",
+		stat & STAT_CCA_RESULT ? "CHAN_IDLE" : "CHAN_BUSY",
 		(stat & 0xf) == RC_STATUS_IDLE ? "RC_STATUS_IDLE" : "",
 		(stat & 0xf) == RC_STATUS_MEAS ? "RC_STATUS_MEAS" : "",
 		(stat & 0xf) == RC_STATUS_PHY_RDY ? "RC_STATUS_PHY_RDY" : "",
@@ -1086,8 +1089,11 @@ static int adf7242_stats_show(struct seq_file *file, void *offset)
 		   irq1 & IRQ_FRAME_VALID ? "IRQ_FRAME_VALID\n" : "",
 		   irq1 & IRQ_ADDRESS_VALID ? "IRQ_ADDRESS_VALID\n" : "");
 
-	seq_printf(file, "STATUS = %X:\n%s\n%s%s%s%s%s\n", stat,
+	seq_printf(file, "STATUS = %X:\n%s\n%s\n%s\n%s\n%s%s%s%s%s\n", stat,
+		   stat & STAT_SPI_READY ? "SPI_READY" : "SPI_BUSY",
+		   stat & STAT_IRQ_STATUS ? "IRQ_PENDING" : "IRQ_CLEAR",
 		   stat & STAT_RC_READY ? "RC_READY" : "RC_BUSY",
+		   stat & STAT_CCA_RESULT ? "CHAN_IDLE" : "CHAN_BUSY",
 		   (stat & 0xf) == RC_STATUS_IDLE ? "RC_STATUS_IDLE" : "",
 		   (stat & 0xf) == RC_STATUS_MEAS ? "RC_STATUS_MEAS" : "",
 		   (stat & 0xf) == RC_STATUS_PHY_RDY ? "RC_STATUS_PHY_RDY" : "",
-- 
2.7.4

