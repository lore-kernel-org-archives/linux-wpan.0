Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from p3plsmtpa06-01.prod.phx3.secureserver.net ([173.201.192.102]:40587
	"EHLO p3plsmtpa06-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752877AbaINUYa (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Sun, 14 Sep 2014 16:24:30 -0400
Message-ID: <5415F84C.9000401@componentsw.com>
Date: Sun, 14 Sep 2014 13:19:24 -0700
From: Walter Mack <wmack@componentsw.com>
MIME-Version: 1.0
Subject: PATCH IEEE 802.15.4: Add module parameter to mrf24j40 to allow use
 of external transmitters/receivers
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Add module parameter ext_rx_tx to support designs that use an external 
transmitter/receiver

Signed-off-by: Walter J. Mack<wmack@componentsw.com>


---
diff --git a/drivers/net/ieee802154/mrf24j40.c 
b/drivers/net/ieee802154/mrf24j40.c
index 9e6a124..6f87889 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -26,6 +26,10 @@
  #include <net/mac802154.h>
  #include <net/ieee802154.h>

+static bool ext_rx_tx = false ;
+module_param(ext_rx_tx, bool, 0444);
+MODULE_PARM_DESC(ext_rx_tx, "turn on statemachine to manage external 
tx/rx");
+
  /* MRF24J40 Short Address Registers */
  #define REG_RXMCR    0x00  /* Receive MAC control */
  #define REG_PANIDL   0x01  /* PAN ID (low) */
@@ -63,6 +67,8 @@
  #define REG_SLPCON1    0x220
  #define REG_WAKETIMEL  0x222  /* Wake-up Time Match Value Low */
  #define REG_WAKETIMEH  0x223  /* Wake-up Time Match Value High */
+#define REG_TESTMODE   0x22f  /* test mode and state machine control 
register */
+
  #define REG_RX_FIFO    0x300  /* Receive FIFO */

  /* Device configuration: Only channels 11-26 on page 0 are supported. */
@@ -679,6 +685,13 @@ static int mrf24j40_hw_init(struct mrf24j40 *devrec)

      udelay(192);

+    if (ext_rx_tx){
+      ret = write_long_reg(devrec, REG_TESTMODE, 0x0f);
+      if (ret)
+        goto err_ret;
+    }
+
+
      /* Set RX Mode. RXMCR<1:0>: 0x0 normal, 0x1 promisc, 0x2 error */
      ret = read_short_reg(devrec, REG_RXMCR, &val);
      if (ret)

