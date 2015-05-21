Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:60081 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbbEUITe (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 21 May 2015 04:19:34 -0400
Message-ID: <555D9512.8030404@datenfreihafen.org>
Date: Thu, 21 May 2015 10:19:30 +0200
From: Stefan Schmidt <stefan@datenfreihafen.org>
MIME-Version: 1.0
Subject: Re: [PATCH atubs-fw 3/4] atusb/fw: Add build system support for adding
 a DFU suffix to the fw file
References: <1432127894-4760-1-git-send-email-stefan@datenfreihafen.org> <1432127894-4760-4-git-send-email-stefan@datenfreihafen.org> <20150520163125.GH10959@ws> <555CB8B0.7060203@osg.samsung.com>
In-Reply-To: <555CB8B0.7060203@osg.samsung.com>
Content-Type: multipart/mixed;
 boundary="------------030107060906050601010700"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, Werner Almesberger <werner@almesberger.net>
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com

This is a multi-part message in MIME format.
--------------030107060906050601010700
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

Hello.

On 20/05/15 18:39, Stefan Schmidt wrote:
> Hello.
>
> On 20/05/15 18:31, Werner Almesberger wrote:
>> Stefan Schmidt wrote:
>>> DFU files need to have a valid DFU suffix which provides information
>>> about the USB vendor and product ID
>> Aah, more bureaucracy ! :)
>>
> Yup. :)
>
> Good one is this case though. The suffix add a little crc protection
> and having the ID to make sure we flash it to the right device also
> sounds good to me :)
>
>>> +        dfu-suffix -a $(NAME).dfu -d 0x$(USB_BCD_VERSION) -p
>>> 0x$(USB_PRODUCT_ID) -v 0x$(USB_VENDOR_ID)
>> Would be nice to keep wc -L <= 80, though.
>
> ok, will change this tomorrow and resend. Going afk now.
>

Please find the updated patch attached. If you prefer me to resend the
whole series let me know.

regards
Stefan Schmidt


--------------030107060906050601010700
Content-Type: text/x-patch;
 name="0003-atusb-fw-Add-build-system-support-for-adding-a-DFU-s.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0003-atusb-fw-Add-build-system-support-for-adding-a-DFU-s.pa";
 filename*1="tch"

 From f910b79aa194f9e0115bea859ede9133421ecb52 Mon Sep 17 00:00:00 2001
From: Stefan Schmidt <stefan@datenfreihafen.org>
Date: Wed, 20 May 2015 11:56:15 +0200
Subject: [PATCH atusb-fw 3/4] atusb/fw: Add build system support for adding a
 DFU suffix to the fw file

DFU files need to have a valid DFU suffix which provides information about the
USB vendor and product ID it should be used for as well as same basic CRC file
integrity checking. The dfu-suffix tool can add this and got added to dfu-utils
in 0.7.

With the Makefile changes we take the original atusb-bin file, make a copy and
add the DFU suffix it before flashing.

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
---
 atusb/fw/Makefile | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/atusb/fw/Makefile b/atusb/fw/Makefile
index 653cc56..086994a 100644
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
@@ -80,6 +85,11 @@ boot.elf:	$(BOOT_OBJS)
 		$(BUILD) $(OBJCOPY) -j .text -j .data -O binary $< $@
 		@echo "build #`cat .version`, `ls -l $@`"
 
+%.dfu:		%.bin
+		cp $(NAME).bin $(NAME).dfu
+		dfu-suffix -a $(NAME).dfu -d 0x$(USB_BCD_VERSION) -p 0x$(USB_PRODUCT_ID) \
+		  -v 0x$(USB_VENDOR_ID)
+
 %.hex:		%.elf
 		$(BUILD) $(OBJCOPY) -j .text -j .data -O ihex $< $@
 		@echo "Size: `$(SIZE) -A boot.hex | sed '/Total */s///p;d'` B"
@@ -87,7 +97,7 @@ boot.elf:	$(BOOT_OBJS)
 # ----- Cleanup ---------------------------------------------------------------
 
 clean:
-		rm -f $(NAME).bin $(NAME).elf
+		rm -f $(NAME).bin $(NAME).elf $(NAME).dfu
 		rm -f $(OBJS) $(OBJS:.o=.d)
 		rm -f boot.hex boot.elf
 		rm -f $(BOOT_OBJS) $(BOOT_OBJS:.o=.d)
@@ -177,8 +187,8 @@ prog-read:
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


--------------030107060906050601010700--
