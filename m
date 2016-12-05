Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:54898 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbcLEHuS (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 5 Dec 2016 02:50:18 -0500
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH v2] linux-firmware: update firmware file for atusb
Date: Mon,  5 Dec 2016 08:50:08 +0100
Message-Id: <1480924208-22104-1-git-send-email-stefan@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-firmware@kernel.org
Cc: linux-wpan@vger.kernel.org, Stefan Schmidt <stefan@datenfreihafen.org>

Update to newly released 0.3 version while also adding another
file for the slightly different Atmel Raven USB dongle to be
supported by the same kernel driver.

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
---

v2:
o Added version field for new files and kept old one
o Fixed file permissions

 WHENCE              |   4 ++++
 atusb/ChangeLog     |  12 +++++++++---
 atusb/atusb-0.3.dfu | Bin 0 -> 6042 bytes
 atusb/rzusb-0.3.bin | Bin 0 -> 6058 bytes
 4 files changed, 13 insertions(+), 3 deletions(-)
 create mode 100644 atusb/atusb-0.3.dfu
 create mode 100644 atusb/rzusb-0.3.bin

diff --git a/WHENCE b/WHENCE
index d021c40..3ec9e21 100644
--- a/WHENCE
+++ b/WHENCE
@@ -3130,6 +3130,10 @@ Driver: atusb - ATUSB IEEE 802.15.4 transceiver driver
 
 File: atusb/atusb-0.2.dfu
 Version: 0.2
+File: atusb/atusb-0.3.dfu
+Version: 0.3
+File: atusb/rzusb-0.3.bin
+Version: 0.3
 Info: atusb/ChangeLog
 
 Licence: GPLv2 or later. See GPL-2 and GPL-3 for details.
diff --git a/atusb/ChangeLog b/atusb/ChangeLog
index 65b8c58..62b7cef 100644
--- a/atusb/ChangeLog
+++ b/atusb/ChangeLog
@@ -1,11 +1,17 @@
 ChangeLog:
 	* 0.0  initial release
 	* 0.1  addition of ATUSB_TEST
-	* 0.2  First public release. Compatible with atusb driver in the
-	  upcoming 4.2 kernel
+	* 0.2  First public release. Compatible with atusb driver in the upcoming 4.2 kernel
+	* 0.3	* ATUSB_EUI64_READ/WRITE for permanent EUI64 handling
+		* Support to run the firmware on Atmel Raven USB dongles (Alexander Aring)
+		* Remove FCS frame check from firmware and leave it to the driver
+		* Use extended operation mode for TX for automatic ACK handling
 
 To flash the firmware you need dfu-util on the host:
-dfu-util -d 20b7:1540 -D atusb-0.2.dfu
+dfu-util -d 20b7:1540 -D atusb-0.3.dfu
+
+For the Atmel Raven USB dongle a full JTAG setup is needed to flash the
+firmware as no DFU bootloader is available there.
 
 The firmware is flashed into permanent storage and does not need to be provided
 after power off. A new firmware version can be flashed the same way.
diff --git a/atusb/atusb-0.3.dfu b/atusb/atusb-0.3.dfu
new file mode 100644
index 0000000000000000000000000000000000000000..79eda3b7c25b627b9e9484a23584cf2d0ee878d8
GIT binary patch
literal 6042
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
MH`lgnOy^_&2PwRK>Hq)$

literal 0
HcmV?d00001

diff --git a/atusb/rzusb-0.3.bin b/atusb/rzusb-0.3.bin
new file mode 100644
index 0000000000000000000000000000000000000000..dec0237bc2423864695d66d2012440cc8db9201f
GIT binary patch
literal 6058
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
Xz(ey&A1d)Vmwe+%XNj-)0gC#6Pz8nK

literal 0
HcmV?d00001

-- 
2.5.5

