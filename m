Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:38616 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbbBWT37 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 23 Feb 2015 14:29:59 -0500
Received: by wgha1 with SMTP id a1so840213wgh.5
        for <linux-wpan@vger.kernel.org>; Mon, 23 Feb 2015 11:29:58 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 2/2] at86rf230: add support for external xtal
Date: Mon, 23 Feb 2015 20:29:44 +0100
Message-Id: <1424719784-15012-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1424719784-15012-1-git-send-email-alex.aring@gmail.com>
References: <1424719784-15012-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for setting external xtal. This is recommended
by the at86rf230 transceivers to reduce power consuming and for a better
clock source.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 .../bindings/net/ieee802154/at86rf230.txt          |  6 ++++++
 drivers/net/ieee802154/at86rf230.c                 | 23 ++++++++++++++++++++--
 include/linux/spi/at86rf230.h                      |  2 ++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt b/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
index d3bbdded..4d47c2e 100644
--- a/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
+++ b/Documentation/devicetree/bindings/net/ieee802154/at86rf230.txt
@@ -11,6 +11,10 @@ Required properties:
 Optional properties:
   - reset-gpio:		GPIO spec for the rstn pin
   - sleep-gpio:		GPIO spec for the slp_tr pin
+  - external-xtal:	boolean to use external xtal if present
+  - xtal-trim:		u8 value to fine tuning the internal capacitance
+			arrays of xtal pins. This value should not above 0x0F
+			and only present when external-xtal is enabled
 
 Example:
 
@@ -20,4 +24,6 @@ Example:
 		reg = <0>;
 		interrupts = <19 1>;
 		interrupt-parent = <&gpio3>;
+		external-xtal;
+		xtal-trim = /bits/ 8 <0x06>;
 	};
diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index c495f23..1853f1e 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -72,6 +72,7 @@ struct at86rf230_state_change {
 
 struct at86rf230_local {
 	struct spi_device *spi;
+	struct at86rf230_platform_data cfg;
 
 	struct ieee802154_hw *hw;
 	struct at86rf2xx_chip_data *data;
@@ -1362,6 +1363,17 @@ static int at86rf230_hw_init(struct at86rf230_local *lp)
 	usleep_range(lp->data->t_sleep_cycle,
 		     lp->data->t_sleep_cycle + 100);
 
+	if (lp->cfg.xtal) {
+		rc = at86rf230_write_subreg(lp, SR_XTAL_TRIM,
+					    lp->cfg.xtal_trim);
+		if (rc)
+			return rc;
+
+		rc = at86rf230_write_subreg(lp, SR_XTAL_MODE, 0x5);
+		if (rc)
+			return rc;
+	}
+
 	rc = at86rf230_read_subreg(lp, SR_DVDD_OK, &dvdd);
 	if (rc)
 		return rc;
@@ -1380,18 +1392,24 @@ static int at86rf230_hw_init(struct at86rf230_local *lp)
 static int at86rf230_get_pdata(struct spi_device *spi,
 			       struct at86rf230_platform_data *cfg)
 {
+	int ret = 0;
+
 	if (!IS_ENABLED(CONFIG_OF) || !spi->dev.of_node) {
 		if (!spi->dev.platform_data)
 			return -ENOENT;
 
 		memcpy(cfg, spi->dev.platform_data, sizeof(*cfg));
-		return 0;
+		return ret;
 	}
 
 	cfg->rstn = of_get_named_gpio(spi->dev.of_node, "reset-gpio", 0);
 	cfg->slp_tr = of_get_named_gpio(spi->dev.of_node, "sleep-gpio", 0);
+	cfg->xtal = of_property_read_bool(spi->dev.of_node, "external-xtal");
+	if (cfg->xtal)
+		ret = of_property_read_u8(spi->dev.of_node, "xtal-trim",
+					  &cfg->xtal_trim);
 
-	return 0;
+	return ret;
 }
 
 static int
@@ -1545,6 +1563,7 @@ static int at86rf230_probe(struct spi_device *spi)
 	lp = hw->priv;
 	lp->hw = hw;
 	lp->spi = spi;
+	lp->cfg = cfg;
 	hw->parent = &spi->dev;
 	hw->vif_data_size = sizeof(*lp);
 	ieee802154_random_extended_addr(&hw->phy->perm_extended_addr);
diff --git a/include/linux/spi/at86rf230.h b/include/linux/spi/at86rf230.h
index cd519a1..632ad90 100644
--- a/include/linux/spi/at86rf230.h
+++ b/include/linux/spi/at86rf230.h
@@ -22,6 +22,8 @@ struct at86rf230_platform_data {
 	int rstn;
 	int slp_tr;
 	int dig2;
+	bool xtal;
+	u8 xtal_trim;
 };
 
 #endif
-- 
2.3.0

