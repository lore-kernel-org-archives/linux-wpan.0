Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010E8ECAAD5
	for <linux-wpan@archiver.kernel.org>; Mon,  5 Sep 2022 00:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiIEAzz (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 4 Sep 2022 20:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiIEAzy (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 4 Sep 2022 20:55:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FB61B7B1
        for <linux-wpan@vger.kernel.org>; Sun,  4 Sep 2022 17:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662339352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=euYQTa53cmlKSeVF5sT7eiVFdYOXK0+XJir27YNXp5U=;
        b=WTr0/62EpOKiEKMZlOaD52g+8x/N/W6f4RPcwqvOdfV7uwmSBDPTHOaxkp94AeotosXj14
        1EcwkGTF12+29FyZ5HeYjYVeUHLJla0BNhJPm35YbZ6eeHgt9/+z67MR4P4gpgIX4sRJuF
        nPVKofGq107M0jWGM1XRSj2InVivOs0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-OssvWWLZNHWznBCY-ujAJQ-1; Sun, 04 Sep 2022 20:55:51 -0400
X-MC-Unique: OssvWWLZNHWznBCY-ujAJQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE057811E80;
        Mon,  5 Sep 2022 00:55:50 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB02D4024919;
        Mon,  5 Sep 2022 00:55:50 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     stefan@datenfreihafen.org
Cc:     linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com
Subject: [RFC wpan-next] atusb: add support for trac feature
Date:   Sun,  4 Sep 2022 20:55:44 -0400
Message-Id: <20220905005544.994036-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

This patch adds support for reading the trac register if atusb firmware
reports tx done. There is currently a feature to compare a sequence
number, if the payload is 1 it tells the driver only the sequence number
is available if it's two there is additional the trac status register as
payload.

Currently the atusb_in_good() function determines if it's a tx done or
rx done if according the payload length. This patch is doing the same
and assumes this behaviour.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---

Just an RFC, need another weekend to test it.

 drivers/net/ieee802154/atusb.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index 2c338783893d..95a4a3cdc8a4 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -191,7 +191,7 @@ static void atusb_work_urbs(struct work_struct *work)
 
 /* ----- Asynchronous USB -------------------------------------------------- */
 
-static void atusb_tx_done(struct atusb *atusb, u8 seq)
+static void atusb_tx_done(struct atusb *atusb, u8 seq, int reason)
 {
 	struct usb_device *usb_dev = atusb->usb_dev;
 	u8 expect = atusb->tx_ack_seq;
@@ -199,7 +199,10 @@ static void atusb_tx_done(struct atusb *atusb, u8 seq)
 	dev_dbg(&usb_dev->dev, "%s (0x%02x/0x%02x)\n", __func__, seq, expect);
 	if (seq == expect) {
 		/* TODO check for ifs handling in firmware */
-		ieee802154_xmit_complete(atusb->hw, atusb->tx_skb, false);
+		if (reason == IEEE802154_SUCCESS)
+			ieee802154_xmit_complete(atusb->hw, atusb->tx_skb, false);
+		else
+			ieee802154_xmit_error(atusb->hw, atusb->tx_skb, reason);
 	} else {
 		/* TODO I experience this case when atusb has a tx complete
 		 * irq before probing, we should fix the firmware it's an
@@ -215,7 +218,8 @@ static void atusb_in_good(struct urb *urb)
 	struct usb_device *usb_dev = urb->dev;
 	struct sk_buff *skb = urb->context;
 	struct atusb *atusb = SKB_ATUSB(skb);
-	u8 len, lqi;
+	int result = IEEE802154_SUCCESS;
+	u8 len, lqi, trac;
 
 	if (!urb->actual_length) {
 		dev_dbg(&usb_dev->dev, "atusb_in: zero-sized URB ?\n");
@@ -224,8 +228,27 @@ static void atusb_in_good(struct urb *urb)
 
 	len = *skb->data;
 
-	if (urb->actual_length == 1) {
-		atusb_tx_done(atusb, len);
+	switch (urb->actual_length) {
+	case 2:
+		trac = TRAC_MASK(*(skb->data + 1));
+		switch (trac) {
+		case TRAC_SUCCESS:
+		case TRAC_SUCCESS_DATA_PENDING:
+			/* already IEEE802154_SUCCESS */
+			break;
+		case TRAC_CHANNEL_ACCESS_FAILURE:
+			result = IEEE802154_CHANNEL_ACCESS_FAILURE;
+			break;
+		case TRAC_NO_ACK:
+			result = IEEE802154_NO_ACK;
+			break;
+		default:
+			result = IEEE802154_SYSTEM_ERROR;
+		}
+
+		fallthrough;
+	case 1:
+		atusb_tx_done(atusb, len, result);
 		return;
 	}
 
-- 
2.31.1

