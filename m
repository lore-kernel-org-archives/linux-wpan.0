Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:55096 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751645AbcLENzC (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 5 Dec 2016 08:55:02 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH bluetooth-next 1/4] ieee802154: atusb: sync header file from firmware for new features
Date: Mon,  5 Dec 2016 14:47:17 +0100
Message-Id: <1480945640-3571-2-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1480945640-3571-1-git-send-email-stefan@osg.samsung.com>
References: <1480945640-3571-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>

This file is shared between the atusb firmware and the kernel driver. In this
update it brings the new interfaces from version 0.3 of the firmware.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/atusb.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/atusb.h b/drivers/net/ieee802154/atusb.h
index 0690edc..b22bbaa 100644
--- a/drivers/net/ieee802154/atusb.h
+++ b/drivers/net/ieee802154/atusb.h
@@ -13,8 +13,8 @@
  * Firmware: ben-wpan/atusb/fw/include/atusb/atusb.h
  */
 
-#ifndef _ATUSB_H
-#define _ATUSB_H
+#ifndef	_ATUSB_H
+#define	_ATUSB_H
 
 #define ATUSB_VENDOR_ID	0x20b7	/* Qi Hardware*/
 #define ATUSB_PRODUCT_ID 0x1540	/* 802.15.4, device 0 */
@@ -46,9 +46,12 @@ enum atusb_requests {
 	ATUSB_SPI_WRITE2_SYNC,
 	ATUSB_RX_MODE			= 0x40, /* HardMAC group */
 	ATUSB_TX,
+	ATUSB_EUI64_WRITE		= 0x50, /* Parameter in EEPROM grp */
+	ATUSB_EUI64_READ,
 };
 
-/* Direction	bRequest		wValue		wIndex	wLength
+/*
+ * Direction	bRequest		wValue		wIndex	wLength
  *
  * ->host	ATUSB_ID		-		-	3
  * ->host	ATUSB_BUILD		-		-	#bytes
@@ -76,6 +79,8 @@ enum atusb_requests {
  *
  * host->	ATUSB_RX_MODE		on		-	0
  * host->	ATUSB_TX		flags		ack_seq	#bytes
+ * host->	ATUSB_EUI64_WRITE	-		-	#bytes (8)
+ * ->host	ATUSB_EUI64_READ	-		-	#bytes (8)
  */
 
 #define ATUSB_REQ_FROM_DEV	(USB_TYPE_VENDOR | USB_DIR_IN)
-- 
2.5.5

