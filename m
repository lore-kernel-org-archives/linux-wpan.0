Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:54866 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752302AbdIVMOY (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 22 Sep 2017 08:14:24 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH 08/14] ieee802154: mrf24j40: fix some kernel coding style errors
Date: Fri, 22 Sep 2017 14:13:59 +0200
Message-Id: <20170922121405.31789-9-stefan@osg.samsung.com>
In-Reply-To: <20170922121405.31789-1-stefan@osg.samsung.com>
References: <20170922121405.31789-1-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aring@mojatatu.com>, michael.hennerich@analog.com, h.morris@cascoda.com, linuxdev@cascoda.com, varkabhadram@gmail.com, alan@signal11.us, Stefan Schmidt <stefan@osg.samsung.com>

Fix format of multi-line comments and long lines.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/mrf24j40.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index ee7084b2d52d..e951a191e15d 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -569,8 +569,9 @@ static void write_tx_buf_complete(void *context)
 }
 
 /* This function relies on an undocumented write method. Once a write command
-   and address is set, as many bytes of data as desired can be clocked into
-   the device. The datasheet only shows setting one byte at a time. */
+ * and address is set, as many bytes of data as desired can be clocked into
+ * the device. The datasheet only shows setting one byte at a time.
+ */
 static int write_tx_buf(struct mrf24j40 *devrec, u16 reg,
 			const u8 *data, size_t length)
 {
@@ -578,9 +579,10 @@ static int write_tx_buf(struct mrf24j40 *devrec, u16 reg,
 	int ret;
 
 	/* Range check the length. 2 bytes are used for the length fields.*/
-	if (length > TX_FIFO_SIZE-2) {
-		dev_err(printdev(devrec), "write_tx_buf() was passed too large a buffer. Performing short write.\n");
-		length = TX_FIFO_SIZE-2;
+	if (length > TX_FIFO_SIZE - 2) {
+		dev_err(printdev(devrec), "%s: passed buffer to large, short write\n",
+			__func__);
+		length = TX_FIFO_SIZE - 2;
 	}
 
 	cmd = MRF24J40_WRITELONG(reg);
@@ -1073,7 +1075,8 @@ static int mrf24j40_hw_init(struct mrf24j40 *devrec)
 	int ret;
 
 	/* Initialize the device.
-		From datasheet section 3.2: Initialization. */
+	 * From datasheet section 3.2: Initialization.
+	 */
 	ret = regmap_write(devrec->regmap_short, REG_SOFTRST, 0x07);
 	if (ret)
 		goto err_ret;
@@ -1374,7 +1377,8 @@ static int mrf24j40_remove(struct spi_device *spi)
 	ieee802154_unregister_hw(devrec->hw);
 	ieee802154_free_hw(devrec->hw);
 	/* TODO: Will ieee802154_free_device() wait until ->xmit() is
-	 * complete? */
+	 * complete?
+	 */
 
 	return 0;
 }
-- 
2.13.5

