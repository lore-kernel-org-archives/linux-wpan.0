Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:45237 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbbETN2Q (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 May 2015 09:28:16 -0400
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH atubs-fw 3/4] atusb/fw: Add build system support for adding a DFU suffix to the fw file
Date: Wed, 20 May 2015 15:18:13 +0200
Message-Id: <1432127894-4760-4-git-send-email-stefan@datenfreihafen.org>
In-Reply-To: <1432127894-4760-1-git-send-email-stefan@datenfreihafen.org>
References: <1432127894-4760-1-git-send-email-stefan@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, werner@almesberger.net, Stefan Schmidt <stefan@datenfreihafen.org>

DFU files need to have a valid DFU suffix which provides information about the
USB vendor and product ID it should be used for as well as same basic CRC file
integrity checking. The dfu-suffix tool can add this and got added to dfu-utils
in 0.7.

With the Makefile changes we take the original atusb-bin file, make a copy and
add the DFU suffix it before flashing.

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
---
 atusb/fw/Makefile | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/atusb/fw/Makefile b/atusb/fw/Makefile
index 653cc56..ecd8b04 100644
--- a/atusb/fw/Makefile
+++ b/atusb/fw/Makefile
@@ -28,7 +28,12 @@ OBJCOPY = $(AVR_PREFIX)objcopy
 #OBJDUMP = $(AVR_PREFIX)objdump
 SIZE = $(AVR_PREFIX)size
 
-USB_ID = 20b7:1540
+# BCD notion is 0xJJMM with JJ being major and MM being minor. Thus 0x0020 is
+# version 0.2 */
+USB_BCD_VERSION = 0020
+USB_VENDOR_ID = 20b7
+USB_PRODUCT_ID = 1540
+USB_ID = $(USB_VENDOR_ID):$(USB_PRODUCT_ID)
 
 OBJS = atusb.o board.o board_app.o sernum.o spi.o descr.o ep0.o \
        dfu_common.o usb.o app-atu2.o mac.o
@@ -80,6 +85,10 @@ boot.elf:	$(BOOT_OBJS)
 		$(BUILD) $(OBJCOPY) -j .text -j .data -O binary $< $@
 		@echo "build #`cat .version`, `ls -l $@`"
 
+%.dfu:		%.bin
+		cp $(NAME).bin $(NAME).dfu
+		dfu-suffix -a $(NAME).dfu -d 0x$(USB_BCD_VERSION) -p 0x$(USB_PRODUCT_ID) -v 0x$(USB_VENDOR_ID)
+
 %.hex:		%.elf
 		$(BUILD) $(OBJCOPY) -j .text -j .data -O ihex $< $@
 		@echo "Size: `$(SIZE) -A boot.hex | sed '/Total */s///p;d'` B"
@@ -87,7 +96,7 @@ boot.elf:	$(BOOT_OBJS)
 # ----- Cleanup ---------------------------------------------------------------
 
 clean:
-		rm -f $(NAME).bin $(NAME).elf
+		rm -f $(NAME).bin $(NAME).elf $(NAME).dfu
 		rm -f $(OBJS) $(OBJS:.o=.d)
 		rm -f boot.hex boot.elf
 		rm -f $(BOOT_OBJS) $(BOOT_OBJS:.o=.d)
@@ -177,8 +186,8 @@ prog-read:
 		ssh $(HOST) avrdude -F -p $(CHIP) -c nanonote_atusb \
 		  -U flash:r:mcu.bin:r
 
-dfu:		$(NAME).bin
-		dfu-util -d $(USB_ID) -D $(NAME).bin
+dfu:		$(NAME).dfu
+		dfu-util -d $(USB_ID) -D $(NAME).dfu
 
 update:		$(NAME).bin
 		-atrf-reset -a
-- 
2.1.0

