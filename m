Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473EBC38145
	for <linux-wpan@archiver.kernel.org>; Tue,  6 Sep 2022 08:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbiIFIVS (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 6 Sep 2022 04:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbiIFIVR (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 6 Sep 2022 04:21:17 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF0673325
        for <linux-wpan@vger.kernel.org>; Tue,  6 Sep 2022 01:21:10 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F3333FF80E;
        Tue,  6 Sep 2022 08:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662452469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ALGGn/CduQXBnOtj94WFZrqbOzJRWr0CNwPvNW0tO8=;
        b=H2nwUF/1cViTjq7/Lt1LdM2D8bPjAk1BJy315usLcvkFdr0O+NvXwy66NAc3BKlw6rc9HU
        Him5WfGWGBCBWFaaWapJtygwf3yIobv/P3Z9NKhLVt9MAihYCy1oPuyviLkU1AyDdgILc4
        RP0ua564ffbEZ8u3UyNs11GnEkpsy+8oLLBvI9Npz5KwaZfnZeXQlVIkYYgFazz2S/zoxv
        CPDwFOZWlG2oPRMQSBtRDxkCUjJfHEqMusi8s3rEbufBBffniFGWQhKcJoxdogmuQpP+kr
        FUzUXEWKW64HU/OsqlMqi8BLgcU1wZrouzRkt+Zr52MnX8hl+olwL+Q/Z8CP8g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     werner@almesberger.net
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
        Alexander Aring <alex.aring@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-wpan@vger.kernel.org, Alexander Aring <aahringo@redhat.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH atusb/fw v2 3/3] atusb: fw: Provide TRAC status
Date:   Tue,  6 Sep 2022 10:21:04 +0200
Message-Id: <20220906082104.1338694-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906082104.1338694-1-miquel.raynal@bootlin.com>
References: <20220906082104.1338694-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

From: Alexander Aring <aahringo@redhat.com>

Upon Tx done condition, returning the sequence number is useful but we
might also return the TRAC value which is needed to ensure that the
packet we sent got ACKed.

We then need to read the TRAC status register upon Tx completion and
send this information to the atusb Linux driver as part of the status
message. First byte remains the sequence number for ensuring backward
compatibility, a second byte is added to forward the TRAC register
status.

We need to move the transition to RX_AACK_ON after reading the trac
register value. The current optimization by switchting to RX_AACK_ON
after invoking transceiver transmission could have the side effect that
the TRAC register is not read out before a frame is received. Receiving
another frame will overwrite the TRAC register. We can only switch to
RX_AACK_ON state after we read out the TRAC register.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>
[Miquel Raynal: Moved the data array out of the stack, rewrote commit log]
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Changes since v1:
* Fix race condition (Rx would mess with the TRAC value, so wait for the
  transmission to have been signaled and the TRAC register to have been
  read before changing the state to RX_AACK_ON (by Alexander).

 atusb/fw/mac.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/atusb/fw/mac.c b/atusb/fw/mac.c
index 835002c..165ce30 100644
--- a/atusb/fw/mac.c
+++ b/atusb/fw/mac.c
@@ -32,7 +32,7 @@ static uint8_t tx_buf[MAX_PSDU];
 static uint8_t tx_size = 0;
 static bool txing = 0;
 static bool queued_tx_ack = 0;
-static uint8_t next_seq, this_seq, queued_seq;
+static uint8_t next_seq, this_seq, this_data[2], queued_data[2];
 
 
 /* ----- Receive buffer management ----------------------------------------- */
@@ -65,7 +65,8 @@ static void usb_next(void)
 	}
 
 	if (queued_tx_ack) {
-		usb_send(&eps[1], &queued_seq, 1, tx_ack_done, NULL);
+		usb_send(&eps[1], queued_data, sizeof(queued_data),
+			 tx_ack_done, NULL);
 		queued_tx_ack = 0;	
 	}
 }
@@ -124,11 +125,17 @@ static bool handle_irq(void)
 
 	if (txing) {
 		if (eps[1].state == EP_IDLE) {
-			usb_send(&eps[1], &this_seq, 1, tx_ack_done, NULL);
+			this_data[0] = this_seq;
+			this_data[1] = reg_read(REG_TRX_STATE);
+			usb_send(&eps[1], this_data, sizeof(this_data),
+				 tx_ack_done, NULL);
 		} else {
 			queued_tx_ack = 1;
-			queued_seq = this_seq;
+			queued_data[0] = this_seq;
+			queued_data[1] = reg_read(REG_TRX_STATE);
 		}
+		change_state(TRX_CMD_PLL_ON);
+		change_state(TRX_CMD_RX_AACK_ON);
 		txing = 0;
 		return 1;
 	}
@@ -215,13 +222,6 @@ static void do_tx(void *user)
 
 	txing = 1;
 	this_seq = next_seq;
-
-	/*
-	 * Wait until we reach BUSY_TX_ARET, so that we command the transition to
-	 * RX_AACK_ON which will be executed upon TX completion.
-	 */
-	change_state(TRX_CMD_PLL_ON);
-	change_state(TRX_CMD_RX_AACK_ON);
 }
 
 
@@ -242,7 +242,7 @@ void mac_reset(void)
 	txing = 0;
 	queued_tx_ack = 0;
 	rx_in = rx_out = 0;
-	next_seq = this_seq = queued_seq = 0;
+	next_seq = this_seq = queued_data[0], queued_data[1] = 0;
 
 	/* enable CRC and PHY_RSSI (with RX_CRC_VALID) in SPI status return */
 	reg_write(REG_TRX_CTRL_1,
-- 
2.34.1

