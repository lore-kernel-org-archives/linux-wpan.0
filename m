Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34886 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757449AbcKCPTr (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 3 Nov 2016 11:19:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id 68so8568233wmz.2
        for <linux-wpan@vger.kernel.org>; Thu, 03 Nov 2016 08:19:47 -0700 (PDT)
From: harrymorris12@gmail.com
Subject: [PATCH v2 2/3] ieee802154: Add device tree documentation for CA8210
Date: Thu,  3 Nov 2016 15:16:50 +0000
Message-Id: <20161103151651.7880-3-h.morris@cascoda.com>
In-Reply-To: <20161103151651.7880-1-h.morris@cascoda.com>
References: <20161103151651.7880-1-h.morris@cascoda.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, stefan@osg.samsung.com, Harry Morris <h.morris@cascoda.com>

From: Harry Morris <h.morris@cascoda.com>

Signed-off-by: Harry Morris <h.morris@cascoda.com>
---
 .../devicetree/bindings/net/ieee802154/ca8210.txt  | 28 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 2 files changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ieee802154/ca8210.txt

diff --git a/Documentation/devicetree/bindings/net/ieee802154/ca8210.txt b/Documentation/devicetree/bindings/net/ieee802154/ca8210.txt
new file mode 100644
index 0000000..0297ce8
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ieee802154/ca8210.txt
@@ -0,0 +1,28 @@
+* CA8210 IEEE 802.15.4 *
+
+Required properties:
+	- compatible:           should be "cascoda,ca8210"
+	- reg:                  Controlling chip select
+	- spi-max-frequency:    Maximum clock speed, should be *less than*
+	                        4000000
+	- spi-cpol:             Invert clock polarity
+	- reset-gpio:           GPIO attached to reset
+	- irq-gpio:             GPIO attached to IRQ
+Optional properties:
+	- extclock-enable:      Include for the ca8210 to route its 16MHz clock
+	                        to an output
+	- extclock-freq:        Frequency in Hz of the external clock
+	- extclock-gpio:        GPIO of the ca8210 to output the clock on
+
+Example:
+	ca8210@0 {
+		compatible = "cascoda,ca8210";
+		reg = <0>;
+		spi-max-frequency = <3000000>;
+		spi-cpol;
+		reset-gpio = <&gpio1 1 GPIO_ACTIVE_HIGH>;
+		irq-gpio = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+		extclock-enable;
+		extclock-freq = 16000000;
+		extclock-gpio = 2;
+	};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 24c6f65..6c5609f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -47,6 +47,7 @@ brcm	Broadcom Corporation
 buffalo	Buffalo, Inc.
 calxeda	Calxeda
 capella	Capella Microsystems, Inc
+cascoda	Cascoda, Ltd.
 cavium	Cavium, Inc.
 cdns	Cadence Design Systems Inc.
 ceva	Ceva, Inc.
-- 
2.9.3.windows.1

