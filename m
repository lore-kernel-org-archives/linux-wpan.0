Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from p3plsmtpa11-01.prod.phx3.secureserver.net ([68.178.252.102]:57174
	"EHLO p3plsmtpa11-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751189AbaIOFnv (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 15 Sep 2014 01:43:51 -0400
From: Walter Mack <wmack@componentsw.com>
Subject: [PATCH wpan-next] ieee802154: mrf24j40: support for external rx/tx
Date: Sun, 14 Sep 2014 22:35:38 -0700
Message-Id: <1410759338-21663-1-git-send-email-wmack@componentsw.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org, wmack@componentsw.com
Cc: alan@signal11.us

The MRF24j40 device supports the use of external receivers/transmitters.
Microchip literature refers to them as LNA and PA respectively.
However, if external receivers/transmitters are present, register
"TESTMODE" has to be programmed with value 0f.
This patch adds a boolean module parameter ext_rx_tx. Setting it to true
configures the driver to adjust the mrf24j40 operation to work
with external receivers/transmitters.

Microchip's MRF24J40MB module is one instance that has external PA/LNA.
Without this new module parameter, transmission between two of these
modules was limited to less than 5 feet. With the module parameter set,
the range increased to well above 100 feet.

Signed-off-by: Walter Mack <wmack@componentsw.com>
---
 drivers/net/ieee802154/mrf24j40.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 9e6a124..e9cb5c6 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -26,6 +26,10 @@
 #include <net/mac802154.h>
 #include <net/ieee802154.h>
 
+static bool ext_rx_tx;
+module_param(ext_rx_tx, bool, 0444);
+MODULE_PARM_DESC(ext_rx_tx, "turn on statemachine to manage external tx/rx");
+
 /* MRF24J40 Short Address Registers */
 #define REG_RXMCR    0x00  /* Receive MAC control */
 #define REG_PANIDL   0x01  /* PAN ID (low) */
@@ -63,6 +67,8 @@
 #define REG_SLPCON1    0x220
 #define REG_WAKETIMEL  0x222  /* Wake-up Time Match Value Low */
 #define REG_WAKETIMEH  0x223  /* Wake-up Time Match Value High */
+#define REG_TESTMODE   0x22f  /* test mode and state machine control register */
+
 #define REG_RX_FIFO    0x300  /* Receive FIFO */
 
 /* Device configuration: Only channels 11-26 on page 0 are supported. */
@@ -679,6 +685,12 @@ static int mrf24j40_hw_init(struct mrf24j40 *devrec)
 
 	udelay(192);
 
+	if (ext_rx_tx) {
+		ret = write_long_reg(devrec, REG_TESTMODE, 0x0f);
+		if (ret)
+			goto err_ret;
+	}
+
 	/* Set RX Mode. RXMCR<1:0>: 0x0 normal, 0x1 promisc, 0x2 error */
 	ret = read_short_reg(devrec, REG_RXMCR, &val);
 	if (ret)
-- 
1.9.1

