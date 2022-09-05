Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA42C6FA82
	for <linux-wpan@archiver.kernel.org>; Mon,  5 Sep 2022 00:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiIEAtv (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 4 Sep 2022 20:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIEAtu (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 4 Sep 2022 20:49:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4D312A8C
        for <linux-wpan@vger.kernel.org>; Sun,  4 Sep 2022 17:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662338987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8+rUSd3kEdkocyYSn/+36CDpFjRIfG9CincEv+GxCFE=;
        b=ONyJmYcy3SxgFyuMCSdSo6tbCIogU+narIDjLKwgBpl+u1QScVynljijnOYWGQS2aRlQ4r
        5kF4rh4H8G5u3833sjReRgGa3hMmy1upbOeQOXRT8bPQElRaIfARQxgokRlLFCjb0EnaVe
        K1wOmdNNCMUJd2T/VyCZuc5XW3RRy7s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-18lEEF8BNsa7zB9hnVm9VQ-1; Sun, 04 Sep 2022 20:49:46 -0400
X-MC-Unique: 18lEEF8BNsa7zB9hnVm9VQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CCB63C16183;
        Mon,  5 Sep 2022 00:49:46 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 352251121314;
        Mon,  5 Sep 2022 00:49:45 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     stefan@datenfreihafen.org
Cc:     linux-wpan@vger.kernel.org
Subject: [RFC ben-wpan] fw: add trac reg to tx done
Date:   Sun,  4 Sep 2022 20:49:44 -0400
Message-Id: <20220905004944.967757-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

This patch adds an additional byte for tx done for the trac status
register which can then evaluated by the atusb Linux driver.
---

Just an RFC, need another weekend to test it.

 atusb/fw/mac.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/atusb/fw/mac.c b/atusb/fw/mac.c
index 835002c..045d5fa 100644
--- a/atusb/fw/mac.c
+++ b/atusb/fw/mac.c
@@ -32,7 +32,7 @@ static uint8_t tx_buf[MAX_PSDU];
 static uint8_t tx_size = 0;
 static bool txing = 0;
 static bool queued_tx_ack = 0;
-static uint8_t next_seq, this_seq, queued_seq;
+static uint8_t next_seq, this_seq, queued_seq, queued_tx_trac;
 
 
 /* ----- Receive buffer management ----------------------------------------- */
@@ -57,6 +57,7 @@ static void tx_ack_done(void *user);
 static void usb_next(void)
 {
 	const uint8_t *buf;
+	uint8_t data[2];
 
 	if (rx_in != rx_out) {
 		buf = rx_buf[rx_out];
@@ -65,7 +66,9 @@ static void usb_next(void)
 	}
 
 	if (queued_tx_ack) {
-		usb_send(&eps[1], &queued_seq, 1, tx_ack_done, NULL);
+		data[0] = queued_seq;
+		data[1] = queued_tx_trac;
+		usb_send(&eps[1], data, sizeof(data), tx_ack_done, NULL);
 		queued_tx_ack = 0;	
 	}
 }
@@ -116,7 +119,7 @@ static void receive_frame(void)
 
 static bool handle_irq(void)
 {
-	uint8_t irq;
+	uint8_t irq, data[2];
 
 	irq = reg_read(REG_IRQ_STATUS);
 	if (!(irq & IRQ_TRX_END))
@@ -124,10 +127,13 @@ static bool handle_irq(void)
 
 	if (txing) {
 		if (eps[1].state == EP_IDLE) {
-			usb_send(&eps[1], &this_seq, 1, tx_ack_done, NULL);
+			data[0] = this_seq;
+			data[1] = reg_read(REG_TRX_STATE);
+			usb_send(&eps[1], data, sizeof(data), tx_ack_done, NULL);
 		} else {
 			queued_tx_ack = 1;
 			queued_seq = this_seq;
+			queued_tx_trac = reg_read(REG_TRX_STATE);
 		}
 		txing = 0;
 		return 1;
-- 
2.31.1

