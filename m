Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:48573 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754148AbbE2Ivj (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2015 04:51:39 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCHv2 bluetooth-next 1/4] ieee802154/atusb: Add function for partial register writes
Date: Fri, 29 May 2015 10:51:25 +0200
Message-Id: <1432889488-28420-2-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1432889488-28420-1-git-send-email-stefan@osg.samsung.com>
References: <1432889488-28420-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>, Stefan Schmidt <stefan@osg.samsung.com>

From: Stefan Schmidt <s.schmidt@samsung.com>

With this function we can set individual bits in the registers if needed.
With the old SR_VALUE macro we could only set one bit in the register
which was ok for some scenarios but not for all. With this subreg write
function we can now set more bits defined by the mask while not touching
the rest.

We start using it for the current SR_VALUE use case and will use it more
in upcoming patches.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/atusb.c | 45 +++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index 5b6bb9a..95d4220 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -58,17 +58,6 @@ struct atusb {
 	uint8_t tx_ack_seq;		/* current TX ACK sequence number */
 };
 
-/* at86rf230.h defines values as <reg, mask, shift> tuples. We use the more
- * traditional style of having registers and or-able values. SR_REG extracts
- * the register number. SR_VALUE uses the shift to prepare a value accordingly.
- */
-
-#define __SR_REG(reg, mask, shift)	(reg)
-#define SR_REG(sr)			__SR_REG(sr)
-
-#define __SR_VALUE(reg, mask, shift, val)	((val) << (shift))
-#define SR_VALUE(sr, val)			__SR_VALUE(sr, (val))
-
 /* ----- USB commands without data ----------------------------------------- */
 
 /* To reduce the number of error checks in the code, we record the first error
@@ -130,6 +119,30 @@ static int atusb_read_reg(struct atusb *atusb, uint8_t reg)
 	return ret >= 0 ? value : ret;
 }
 
+static int atusb_write_subreg(struct atusb *atusb, uint8_t reg, uint8_t mask,
+			      uint8_t shift, uint8_t value)
+{
+	struct usb_device *usb_dev = atusb->usb_dev;
+	uint8_t orig, tmp;
+	int ret = 0;
+
+	dev_dbg(&usb_dev->dev, "atusb_write_subreg: 0x%02x <- 0x%02x\n",
+		reg, value);
+
+	orig = atusb_read_reg(atusb, reg);
+
+	/* Write the value only into that part of the register which is allowed
+	 * by the mask. All other bits stay as before.
+	 */
+	tmp = orig & ~mask;
+	tmp |= (value << shift) & mask;
+
+	if (tmp != orig)
+		ret = atusb_write_reg(atusb, reg, tmp);
+
+	return ret;
+}
+
 static int atusb_get_and_clear_error(struct atusb *atusb)
 {
 	int err = atusb->err;
@@ -376,7 +389,6 @@ static int atusb_set_hw_addr_filt(struct ieee802154_hw *hw,
 {
 	struct atusb *atusb = hw->priv;
 	struct device *dev = &atusb->usb_dev->dev;
-	uint8_t reg;
 
 	if (changed & IEEE802154_AFILT_SADDR_CHANGED) {
 		u16 addr = le16_to_cpu(filt->short_addr);
@@ -406,12 +418,10 @@ static int atusb_set_hw_addr_filt(struct ieee802154_hw *hw,
 	if (changed & IEEE802154_AFILT_PANC_CHANGED) {
 		dev_vdbg(dev,
 			 "atusb_set_hw_addr_filt called for panc change\n");
-		reg = atusb_read_reg(atusb, SR_REG(SR_AACK_I_AM_COORD));
 		if (filt->pan_coord)
-			reg |= SR_VALUE(SR_AACK_I_AM_COORD, 1);
+			atusb_write_subreg(atusb, SR_AACK_I_AM_COORD, 1);
 		else
-			reg &= ~SR_VALUE(SR_AACK_I_AM_COORD, 1);
-		atusb_write_reg(atusb, SR_REG(SR_AACK_I_AM_COORD), reg);
+			atusb_write_subreg(atusb, SR_AACK_I_AM_COORD, 0);
 	}
 
 	return atusb_get_and_clear_error(atusb);
@@ -622,8 +632,7 @@ static int atusb_probe(struct usb_interface *interface,
 	 *     http://www.jennic.com/download_file.php?supportFile=JN-AN-1035%20Calculating%20802-15-4%20Data%20Rates-1v0.pdf
 	 */
 
-	atusb_write_reg(atusb,
-			SR_REG(SR_RX_SAFE_MODE), SR_VALUE(SR_RX_SAFE_MODE, 1));
+	atusb_write_subreg(atusb, SR_RX_SAFE_MODE, 1);
 #endif
 	atusb_write_reg(atusb, RG_IRQ_MASK, 0xff);
 
-- 
2.1.0

