Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-by2nam01on0041.outbound.protection.outlook.com ([104.47.34.41]:29361
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751377AbdK1Muj (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 28 Nov 2017 07:50:39 -0500
From: <michael.hennerich@analog.com>
Subject: [PATCH 4/5] net: ieee802154: adf7242: Avoid redundant RC_READY polling
Date: Tue, 28 Nov 2017 13:53:14 +0100
Message-ID: <1511873595-29238-4-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1511873595-29238-1-git-send-email-michael.hennerich@analog.com>
References: <1511873595-29238-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: alex.aring@gmail.com, stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

READ/WRITE register and packet buffer can be done anytime as long
as SPI_READY. Only CMD transactions require RC_READY && SPI_READY.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/net/ieee802154/adf7242.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index ce1a6d2..548bec1 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -344,12 +344,18 @@ static int adf7242_wait_status(struct adf7242_local *lp, unsigned int status,
 	return ret;
 }
 
-static int adf7242_wait_ready(struct adf7242_local *lp, int line)
+static int adf7242_wait_rc_ready(struct adf7242_local *lp, int line)
 {
 	return adf7242_wait_status(lp, STAT_RC_READY | STAT_SPI_READY,
 				   STAT_RC_READY | STAT_SPI_READY, line);
 }
 
+static int adf7242_wait_spi_ready(struct adf7242_local *lp, int line)
+{
+	return adf7242_wait_status(lp, STAT_SPI_READY,
+				   STAT_SPI_READY, line);
+}
+
 static int adf7242_write_fbuf(struct adf7242_local *lp, u8 *data, u8 len)
 {
 	u8 *buf = lp->buf;
@@ -369,7 +375,7 @@ static int adf7242_write_fbuf(struct adf7242_local *lp, u8 *data, u8 len)
 	spi_message_add_tail(&xfer_head, &msg);
 	spi_message_add_tail(&xfer_buf, &msg);
 
-	adf7242_wait_ready(lp, __LINE__);
+	adf7242_wait_spi_ready(lp, __LINE__);
 
 	mutex_lock(&lp->bmux);
 	buf[0] = CMD_SPI_PKT_WR;
@@ -401,7 +407,7 @@ static int adf7242_read_fbuf(struct adf7242_local *lp,
 	spi_message_add_tail(&xfer_head, &msg);
 	spi_message_add_tail(&xfer_buf, &msg);
 
-	adf7242_wait_ready(lp, __LINE__);
+	adf7242_wait_spi_ready(lp, __LINE__);
 
 	mutex_lock(&lp->bmux);
 	if (packet_read) {
@@ -432,7 +438,7 @@ static int adf7242_read_reg(struct adf7242_local *lp, u16 addr, u8 *data)
 		.rx_buf = lp->buf_read_rx,
 	};
 
-	adf7242_wait_ready(lp, __LINE__);
+	adf7242_wait_spi_ready(lp, __LINE__);
 
 	mutex_lock(&lp->bmux);
 	lp->buf_read_tx[0] = CMD_SPI_MEM_RD(addr);
@@ -462,7 +468,7 @@ static int adf7242_write_reg(struct adf7242_local *lp, u16 addr, u8 data)
 {
 	int status;
 
-	adf7242_wait_ready(lp, __LINE__);
+	adf7242_wait_spi_ready(lp, __LINE__);
 
 	mutex_lock(&lp->bmux);
 	lp->buf_reg_tx[0] = CMD_SPI_MEM_WR(addr);
@@ -484,7 +490,7 @@ static int adf7242_cmd(struct adf7242_local *lp, unsigned int cmd)
 	dev_vdbg(&lp->spi->dev, "%s : CMD=0x%X\n", __func__, cmd);
 
 	if (cmd != CMD_RC_PC_RESET_NO_WAIT)
-		adf7242_wait_ready(lp, __LINE__);
+		adf7242_wait_rc_ready(lp, __LINE__);
 
 	mutex_lock(&lp->bmux);
 	lp->buf_cmd = cmd;
-- 
2.7.4

