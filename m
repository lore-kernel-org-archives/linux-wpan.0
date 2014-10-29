Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:46445 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756101AbaJ2Ufx (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 16:35:53 -0400
Received: by mail-wg0-f45.google.com with SMTP id x12so2777402wgg.32
        for <linux-wpan@vger.kernel.org>; Wed, 29 Oct 2014 13:35:52 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 04/17] mac802154: add hardware address filter flag
Date: Wed, 29 Oct 2014 21:34:31 +0100
Message-Id: <1414614884-20243-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
References: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Alan Ott <alan@signal11.us>, Varka Bhadram <varkabhadram@gmail.com>

Overdue introduction for address filtering hardware flag. Furthermore we
will check and set address filtering on interface up. This patch
prepares that we can check if an transceiver supports address filtering
option. Currently all mainline driver supports hardware address filtering.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Cc: Alan Ott <alan@signal11.us>
Cc: Varka Bhadram <varkabhadram@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 3 ++-
 drivers/net/ieee802154/cc2520.c    | 3 ++-
 drivers/net/ieee802154/mrf24j40.c  | 3 ++-
 include/net/mac802154.h            | 2 ++
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 0054588..622c1b6 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1387,7 +1387,8 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 
 	lp->hw->extra_tx_headroom = 0;
 	lp->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AACK |
-			IEEE802154_HW_TXPOWER | IEEE802154_HW_ARET;
+			IEEE802154_HW_TXPOWER | IEEE802154_HW_ARET |
+			IEEE802154_HW_AFILT;
 
 	switch (part) {
 	case 2:
diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index c56d10c..340671b 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -654,7 +654,8 @@ static int cc2520_register(struct cc2520_private *priv)
 
 	/* We do support only 2.4 Ghz */
 	priv->hw->phy->channels_supported[0] = 0x7FFF800;
-	priv->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AACK;
+	priv->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AACK |
+			  IEEE802154_HW_AFILT;
 
 	dev_vdbg(&priv->spi->dev, "registered cc2520\n");
 	ret = ieee802154_register_hw(priv->hw);
diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 52b3d31..a200fa1 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -751,7 +751,8 @@ static int mrf24j40_probe(struct spi_device *spi)
 	devrec->hw->priv = devrec;
 	devrec->hw->parent = &devrec->spi->dev;
 	devrec->hw->phy->channels_supported[0] = CHANNEL_MASK;
-	devrec->hw->flags = IEEE802154_HW_OMIT_CKSUM|IEEE802154_HW_AACK;
+	devrec->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AACK |
+			    IEEE802154_HW_AFILT;
 
 	dev_dbg(printdev(devrec), "registered mrf24j40\n");
 	ret = ieee802154_register_hw(devrec->hw);
diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index c5d7938..2f523fc 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -90,6 +90,8 @@ struct ieee802154_hw {
 #define IEEE802154_HW_CSMA_PARAMS	0x00000040
 /* Indicates that transceiver will support ARET frame retries setting. */
 #define IEEE802154_HW_FRAME_RETRIES	0x00000080
+/* Indicates that transceiver will support hardware address filter setting. */
+#define IEEE802154_HW_AFILT		0x00000100
 
 /* This groups the most common CSMA support fields into one. */
 #define IEEE802154_HW_CSMA		(IEEE802154_HW_CCA_MODE | \
-- 
2.1.2

