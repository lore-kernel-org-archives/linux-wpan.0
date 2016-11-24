Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wj0-f193.google.com ([209.85.210.193]:35889 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932250AbcKXKLy (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 24 Nov 2016 05:11:54 -0500
Received: by mail-wj0-f193.google.com with SMTP id jb2so2903516wjb.3
        for <linux-wpan@vger.kernel.org>; Thu, 24 Nov 2016 02:11:53 -0800 (PST)
From: harrymorris12@gmail.com
Subject: [PATCH v5 2/3] ieee802154: Add device tree documentation for CA8210
Date: Thu, 24 Nov 2016 09:18:21 +0000
Message-Id: <20161124091822.3752-3-h.morris@cascoda.com>
In-Reply-To: <20161124091822.3752-1-h.morris@cascoda.com>
References: <20161124091822.3752-1-h.morris@cascoda.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: aar@pengutronix.de, stefan@osg.samsung.com, marcel@holtmann.org, Harry Morris <h.morris@cascoda.com>

From: Harry Morris <h.morris@cascoda.com>

Signed-off-by: Harry Morris <h.morris@cascoda.com>
Acked-by: Stefan Schmidt <stefan@osg.samsung.com>
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
+	- compatible:           Should be "cascoda,ca8210"
+	- reg:                  Controlling chip select
+	- spi-max-frequency:    Maximum clock speed, should be *less than*
+	                        4000000
+	- spi-cpol:             Requires inverted clock polarity
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
