Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:63486 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbaKLSwI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 12 Nov 2014 13:52:08 -0500
Received: by mail-wi0-f177.google.com with SMTP id l15so1982888wiw.10
        for <linux-wpan@vger.kernel.org>; Wed, 12 Nov 2014 10:52:06 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/2] at86rf230: remove interframe spacing time workaround
Date: Wed, 12 Nov 2014 19:51:57 +0100
Message-Id: <1415818317-26487-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415818317-26487-1-git-send-email-alex.aring@gmail.com>
References: <1415818317-26487-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes the interframe spacing time workaround from at86rf230
driver and use the mac802154 one. The interframe spacing time differs at
at86rf212 and channel setting. This patch fix this handling which is also
a new workaround and should be moved into mac802154 while channel
setting.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 60 +++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 46e5029..7278e18 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -46,10 +46,6 @@ struct at86rf2xx_chip_data {
 	u16 t_off_to_tx_on;
 	u16 t_frame;
 	u16 t_p_ack;
-	/* short interframe spacing time */
-	u16 t_sifs;
-	/* long interframe spacing time */
-	u16 t_lifs;
 	/* completion timeout for tx in msecs */
 	u16 t_tx_timeout;
 	int rssi_base_val;
@@ -719,19 +715,10 @@ at86rf230_tx_complete(void *context)
 
 	enable_irq(lp->spi->irq);
 
-	if (lp->max_frame_retries <= 0) {
-		/* Interfame spacing time, which is phy depend.
-		 * TODO
-		 * Move this handling in MAC 802.15.4 layer.
-		 * This is currently a workaround to avoid fragmenation issues.
-		 */
-		if (skb->len > 18)
-			udelay(lp->data->t_lifs);
-		else
-			udelay(lp->data->t_sifs);
-	}
-
-	ieee802154_xmit_complete(lp->hw, skb, false);
+	if (lp->max_frame_retries <= 0)
+		ieee802154_xmit_complete(lp->hw, skb, true);
+	else
+		ieee802154_xmit_complete(lp->hw, skb, false);
 }
 
 static void
@@ -1038,6 +1025,36 @@ at86rf212_set_channel(struct at86rf230_local *lp, u8 page, u8 channel)
 	if (rc < 0)
 		return rc;
 
+	/* This sets the symbol_duration according frequency on the 212.
+	 * TODO move this handling while set channel and page in cfg802154.
+	 * We can do that, this timings are according 802.15.4 standard.
+	 * If we do that in cfg802154, this is a more generic calculation.
+	 *
+	 * This should also protected from ifs_timer. Means cancel timer and
+	 * init with a new value. For now, this is okay.
+	 */
+	if (channel == 0) {
+		if (page == 0) {
+			/* SUB:0 and BPSK:0 -> BPSK-20 */
+			lp->hw->phy->symbol_duration = 50;
+		} else {
+			/* SUB:1 and BPSK:0 -> BPSK-40 */
+			lp->hw->phy->symbol_duration = 25;
+		}
+	} else {
+		if (page == 0)
+			/* SUB:0 and BPSK:1 -> BPSK-20 */
+			lp->hw->phy->symbol_duration = 40;
+		else
+			/* SUB:1 and BPSK:1 -> BPSK-20 */
+			lp->hw->phy->symbol_duration = 16;
+	}
+
+	lp->hw->phy->lifs_period = IEEE802154_LIFS_PERIOD *
+				   lp->hw->phy->symbol_duration;
+	lp->hw->phy->sifs_period = IEEE802154_SIFS_PERIOD *
+				   lp->hw->phy->symbol_duration;
+
 	return at86rf230_write_subreg(lp, SR_CHANNEL, channel);
 }
 
@@ -1245,8 +1262,6 @@ static struct at86rf2xx_chip_data at86rf233_data = {
 	.t_off_to_tx_on = 80,
 	.t_frame = 4096,
 	.t_p_ack = 545,
-	.t_sifs = 192,
-	.t_lifs = 640,
 	.t_tx_timeout = 2000,
 	.rssi_base_val = -91,
 	.set_channel = at86rf23x_set_channel,
@@ -1261,8 +1276,6 @@ static struct at86rf2xx_chip_data at86rf231_data = {
 	.t_off_to_tx_on = 110,
 	.t_frame = 4096,
 	.t_p_ack = 545,
-	.t_sifs = 192,
-	.t_lifs = 640,
 	.t_tx_timeout = 2000,
 	.rssi_base_val = -91,
 	.set_channel = at86rf23x_set_channel,
@@ -1277,8 +1290,6 @@ static struct at86rf2xx_chip_data at86rf212_data = {
 	.t_off_to_tx_on = 200,
 	.t_frame = 4096,
 	.t_p_ack = 545,
-	.t_sifs = 192,
-	.t_lifs = 640,
 	.t_tx_timeout = 2000,
 	.rssi_base_val = -100,
 	.set_channel = at86rf212_set_channel,
@@ -1414,6 +1425,7 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 		lp->data = &at86rf231_data;
 		lp->hw->phy->channels_supported[0] = 0x7FFF800;
 		lp->hw->phy->current_channel = 11;
+		lp->hw->phy->symbol_duration = 16;
 		break;
 	case 7:
 		chip = "at86rf212";
@@ -1423,6 +1435,7 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 			lp->hw->phy->channels_supported[0] = 0x00007FF;
 			lp->hw->phy->channels_supported[2] = 0x00007FF;
 			lp->hw->phy->current_channel = 5;
+			lp->hw->phy->symbol_duration = 25;
 		} else {
 			rc = -ENOTSUPP;
 		}
@@ -1432,6 +1445,7 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 		lp->data = &at86rf233_data;
 		lp->hw->phy->channels_supported[0] = 0x7FFF800;
 		lp->hw->phy->current_channel = 13;
+		lp->hw->phy->symbol_duration = 16;
 		break;
 	default:
 		chip = "unkown";
-- 
2.1.3

