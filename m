Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:45238 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359AbbETN2Q (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 May 2015 09:28:16 -0400
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH atubs-fw 1/4] Revert "atusb/fw/usb/: enable MCU reset on USB bus reset after config selection"
Date: Wed, 20 May 2015 15:18:11 +0200
Message-Id: <1432127894-4760-2-git-send-email-stefan@datenfreihafen.org>
In-Reply-To: <1432127894-4760-1-git-send-email-stefan@datenfreihafen.org>
References: <1432127894-4760-1-git-send-email-stefan@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, werner@almesberger.net, Stefan Schmidt <stefan@datenfreihafen.org>

This reverts commit 9b2696b8488dbc39b0fdcdefdfad775913cb6e2d.

With this patch ATUSB resets constantly when I use it in QEMU with USB
poassthrough.

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
---
 atusb/fw/usb/atu2.c | 7 +------
 atusb/fw/usb/usb.c  | 1 -
 atusb/fw/usb/usb.h  | 1 -
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/atusb/fw/usb/atu2.c b/atusb/fw/usb/atu2.c
index 409b8e0..e030bfa 100644
--- a/atusb/fw/usb/atu2.c
+++ b/atusb/fw/usb/atu2.c
@@ -247,12 +247,6 @@ void usb_reset(void)
 }
 
 
-void usb_enable_bus_reset(void)
-{
-	UDCON |= 1 << RSTCPU;		/* reset CPU on bus reset */
-}
-
-
 void usb_init(void)
 {
 	USBCON |= 1 << FRZCLK;		/* freeze the clock */
@@ -269,6 +263,7 @@ void usb_init(void)
 
 	UDCON &= ~(1 << DETACH);	/* attach the pull-up */
 	UDIEN = 1 << EORSTE;		/* enable device interrupts  */
+//	UDCON |= 1 << RSTCPU;		/* reset CPU on bus reset */
 
 	ep_init();
 }
diff --git a/atusb/fw/usb/usb.c b/atusb/fw/usb/usb.c
index 20b4d5f..2a2f720 100644
--- a/atusb/fw/usb/usb.c
+++ b/atusb/fw/usb/usb.c
@@ -119,7 +119,6 @@ bool handle_setup(const struct setup_request *setup)
 	case TO_DEVICE(SET_CONFIGURATION):
 		if (setup->wValue != config_descriptor[5])
 			return 0;
-		usb_enable_bus_reset();
 		break;
 
 	/*
diff --git a/atusb/fw/usb/usb.h b/atusb/fw/usb/usb.h
index 32d8ad7..6428ccd 100644
--- a/atusb/fw/usb/usb.h
+++ b/atusb/fw/usb/usb.h
@@ -182,7 +182,6 @@ bool handle_setup(const struct setup_request *setup);
 void set_addr(uint8_t addr);
 void usb_ep_change(struct ep_descr *ep);
 void usb_reset(void);
-void usb_enable_bus_reset(void);
 void usb_init(void);
 
 #endif /* !USB_H */
-- 
2.1.0

