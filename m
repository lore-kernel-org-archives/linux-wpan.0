Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:53148 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756619AbaJ2Uf4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 16:35:56 -0400
Received: by mail-wi0-f172.google.com with SMTP id bs8so2788391wib.5
        for <linux-wpan@vger.kernel.org>; Wed, 29 Oct 2014 13:35:55 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 06/17] at86rf230: add support for promiscuous mode
Date: Wed, 29 Oct 2014 21:34:33 +0100
Message-Id: <1414614884-20243-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
References: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for promiscuous mode setting for the at86rf230
driver.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 622c1b6..98c9437 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1211,6 +1211,33 @@ at86rf230_set_frame_retries(struct ieee802154_hw *hw, s8 retries)
 	return rc;
 }
 
+static int
+at86rf230_set_promiscuous_mode(struct ieee802154_hw *hw, const bool on)
+{
+	struct at86rf230_local *lp = hw->priv;
+	int rc;
+
+	if (on) {
+		rc = at86rf230_write_subreg(lp, SR_AACK_DIS_ACK, 1);
+		if (rc < 0)
+			return rc;
+
+		rc = at86rf230_write_subreg(lp, SR_AACK_PROM_MODE, 1);
+		if (rc < 0)
+			return rc;
+	} else {
+		rc = at86rf230_write_subreg(lp, SR_AACK_PROM_MODE, 0);
+		if (rc < 0)
+			return rc;
+
+		rc = at86rf230_write_subreg(lp, SR_AACK_DIS_ACK, 0);
+		if (rc < 0)
+			return rc;
+	}
+
+	return 0;
+}
+
 static const struct ieee802154_ops at86rf230_ops = {
 	.owner = THIS_MODULE,
 	.xmit_async = at86rf230_xmit,
@@ -1225,6 +1252,7 @@ static const struct ieee802154_ops at86rf230_ops = {
 	.set_cca_ed_level = at86rf230_set_cca_ed_level,
 	.set_csma_params = at86rf230_set_csma_params,
 	.set_frame_retries = at86rf230_set_frame_retries,
+	.set_promiscuous_mode = at86rf230_set_promiscuous_mode,
 };
 
 static struct at86rf2xx_chip_data at86rf233_data = {
@@ -1388,7 +1416,7 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 	lp->hw->extra_tx_headroom = 0;
 	lp->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AACK |
 			IEEE802154_HW_TXPOWER | IEEE802154_HW_ARET |
-			IEEE802154_HW_AFILT;
+			IEEE802154_HW_AFILT | IEEE802154_HW_PROMISCUOUS;
 
 	switch (part) {
 	case 2:
-- 
2.1.2

