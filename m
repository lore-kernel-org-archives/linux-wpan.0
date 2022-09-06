Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922CAECAAA1
	for <linux-wpan@archiver.kernel.org>; Tue,  6 Sep 2022 00:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiIFAM2 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 5 Sep 2022 20:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiIFAM2 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 5 Sep 2022 20:12:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DA4564ED
        for <linux-wpan@vger.kernel.org>; Mon,  5 Sep 2022 17:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662423146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RaSz9oBdN6tWS9X14iLBT8nOiHbYcgVd7oRLwnf6m5o=;
        b=Rq5A1CqjdLv5Ka5lbIE5zPzEjmHEj0GJfGakT/2znBEAmyuwRteygFst4AvJ9A+4OCNuWJ
        Im/SFpCf1E7Vo+0E+sQnPvFrLS+QOLiKzueC/8SKsM/97uPYdNgkXYdA9vsK6nSDNdMNYV
        lOVTqtfQjfCd/KfGmjzDtPHkDaj9/go=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-Lo0Q-6baP7-HiSRoSsWWRA-1; Mon, 05 Sep 2022 20:12:23 -0400
X-MC-Unique: Lo0Q-6baP7-HiSRoSsWWRA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D2FF101A54E;
        Tue,  6 Sep 2022 00:12:23 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC18F14152E0;
        Tue,  6 Sep 2022 00:12:22 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     miquel.raynal@bootlin.com
Cc:     linux-wpan@vger.kernel.org, stefan@datenfreihafen.org
Subject: [RFCv2 ben-wpan] fw: add trac reg to tx done
Date:   Mon,  5 Sep 2022 20:12:18 -0400
Message-Id: <20220906001218.1029787-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

This patch adds an additional byte for tx done for the trac status
register which can then evaluated by the atusb Linux driver.

We need to move the transition to RX_AACK_ON after reading the trac
register value. The current optimization by switchting to RX_AACK_ON
after invoking transceiver transmission could have the side effect that
the trac register is not read out before a frame is received. Receiving
another frame will overwrite the trac register. We can only switch to
RX_AACK_ON state after we read out the trac register.
---
Not tested yet.

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
2.31.1

