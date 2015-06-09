Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:45046 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbbFIPzm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 9 Jun 2015 11:55:42 -0400
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH] linux-firmware: add firmware for atusb driver
Date: Tue,  9 Jun 2015 17:55:33 +0200
Message-Id: <1433865333-8503-1-git-send-email-stefan@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-firmware@kernel.org
Cc: linux-wpan@vger.kernel.org, werner@almesberger.net, Stefan Schmidt <stefan@datenfreihafen.org>

The atusb kernel driver is sitting in the bluetooth-next tree waiting for the
merge window to open. It's scheduled for 4.2.

Flashing goes into permanent storage and the GPLv2+ firmware allows for further
explorations. See ChangeLog for more details and links.

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
---
 WHENCE              |  10 ++++++++++
 atusb/ChangeLog     |  14 ++++++++++++++
 atusb/atusb-0.2.dfu | Bin 0 -> 5800 bytes
 3 files changed, 24 insertions(+)
 create mode 100644 atusb/ChangeLog
 create mode 100755 atusb/atusb-0.2.dfu

diff --git a/WHENCE b/WHENCE
index 312bc88..fcf5ccd 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2756,3 +2756,13 @@ File: nvidia/tegra210/xusb.bin
 Version: v50.07
 
 Licence: Redistributable. See LICENCE.nvidia for details
+
+--------------------------------------------------------------------------
+
+Driver: atusb - ATUSB IEEE 802.15.4 transceiver driver
+
+File: atusb/atusb-0.2.dfu
+Version: 0.2
+Info: atusb/ChangeLog
+
+Licence: GPLv2+
diff --git a/atusb/ChangeLog b/atusb/ChangeLog
new file mode 100644
index 0000000..65b8c58
--- /dev/null
+++ b/atusb/ChangeLog
@@ -0,0 +1,14 @@
+ChangeLog:
+	* 0.0  initial release
+	* 0.1  addition of ATUSB_TEST
+	* 0.2  First public release. Compatible with atusb driver in the
+	  upcoming 4.2 kernel
+
+To flash the firmware you need dfu-util on the host:
+dfu-util -d 20b7:1540 -D atusb-0.2.dfu
+
+The firmware is flashed into permanent storage and does not need to be provided
+after power off. A new firmware version can be flashed the same way.
+
+Firmware source code is GPLv2+ and can be found here:
+http://projects.qi-hardware.com/index.php/p/ben-wpan/source/tree/master/atusb/fw
diff --git a/atusb/atusb-0.2.dfu b/atusb/atusb-0.2.dfu
new file mode 100755
index 0000000000000000000000000000000000000000..a5cd38327683c21a04f7ffe9b9dbb6e786fe48c7
GIT binary patch
literal 5800
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
B2U`FD

literal 0
HcmV?d00001

-- 
2.1.0

