Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36475 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbbEFLlK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 6 May 2015 07:41:10 -0400
Received: by wizk4 with SMTP id k4so198542106wiz.1
        for <linux-wpan@vger.kernel.org>; Wed, 06 May 2015 04:41:09 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 wpan-next 04/16] ieee802154: introduce wpan_phy_supported
Date: Wed,  6 May 2015 13:40:16 +0200
Message-Id: <1430912428-17284-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1430912428-17284-1-git-send-email-alex.aring@gmail.com>
References: <1430912428-17284-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Varka Bhadram <varkabhadram@gmail.com>, Alan Ott <alan@signal11.us>

This patch introduce the wpan_phy_supported struct for wpan_phy. There
is currently no way to check if a transceiver can handle IEEE 802.15.4
complaint values. With this struct we can check before if the
transceiver supports these values before sending to driver layer.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Suggested-by: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Cc: Varka Bhadram <varkabhadram@gmail.com>
Cc: Alan Ott <alan@signal11.us>
---
 drivers/net/ieee802154/at86rf230.c |  8 ++++----
 drivers/net/ieee802154/cc2520.c    |  2 +-
 drivers/net/ieee802154/fakelb.c    | 30 +++++++++++++++---------------
 drivers/net/ieee802154/mrf24j40.c  |  2 +-
 include/net/cfg802154.h            |  6 +++++-
 net/ieee802154/nl-phy.c            |  4 ++--
 net/ieee802154/nl802154.c          |  4 ++--
 7 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index e68d45e..151d57f 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1579,7 +1579,7 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 	case 3:
 		chip = "at86rf231";
 		lp->data = &at86rf231_data;
-		lp->hw->phy->channels_supported[0] = 0x7FFF800;
+		lp->hw->phy->supported.channels[0] = 0x7FFF800;
 		lp->hw->phy->current_channel = 11;
 		lp->hw->phy->symbol_duration = 16;
 		break;
@@ -1587,15 +1587,15 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 		chip = "at86rf212";
 		lp->data = &at86rf212_data;
 		lp->hw->flags |= IEEE802154_HW_LBT;
-		lp->hw->phy->channels_supported[0] = 0x00007FF;
-		lp->hw->phy->channels_supported[2] = 0x00007FF;
+		lp->hw->phy->supported.channels[0] = 0x00007FF;
+		lp->hw->phy->supported.channels[2] = 0x00007FF;
 		lp->hw->phy->current_channel = 5;
 		lp->hw->phy->symbol_duration = 25;
 		break;
 	case 11:
 		chip = "at86rf233";
 		lp->data = &at86rf233_data;
-		lp->hw->phy->channels_supported[0] = 0x7FFF800;
+		lp->hw->phy->supported.channels[0] = 0x7FFF800;
 		lp->hw->phy->current_channel = 13;
 		lp->hw->phy->symbol_duration = 16;
 		break;
diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index f833b8b..84b28a0 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -653,7 +653,7 @@ static int cc2520_register(struct cc2520_private *priv)
 	ieee802154_random_extended_addr(&priv->hw->phy->perm_extended_addr);
 
 	/* We do support only 2.4 Ghz */
-	priv->hw->phy->channels_supported[0] = 0x7FFF800;
+	priv->hw->phy->supported.channels[0] = 0x7FFF800;
 	priv->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AACK |
 			  IEEE802154_HW_AFILT;
 
diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index dc2bfb6..91bbf03 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -149,35 +149,35 @@ static int fakelb_add_one(struct device *dev, struct fakelb_priv *fake)
 	priv->hw = hw;
 
 	/* 868 MHz BPSK	802.15.4-2003 */
-	hw->phy->channels_supported[0] |= 1;
+	hw->phy->supported.channels[0] |= 1;
 	/* 915 MHz BPSK	802.15.4-2003 */
-	hw->phy->channels_supported[0] |= 0x7fe;
+	hw->phy->supported.channels[0] |= 0x7fe;
 	/* 2.4 GHz O-QPSK 802.15.4-2003 */
-	hw->phy->channels_supported[0] |= 0x7FFF800;
+	hw->phy->supported.channels[0] |= 0x7FFF800;
 	/* 868 MHz ASK 802.15.4-2006 */
-	hw->phy->channels_supported[1] |= 1;
+	hw->phy->supported.channels[1] |= 1;
 	/* 915 MHz ASK 802.15.4-2006 */
-	hw->phy->channels_supported[1] |= 0x7fe;
+	hw->phy->supported.channels[1] |= 0x7fe;
 	/* 868 MHz O-QPSK 802.15.4-2006 */
-	hw->phy->channels_supported[2] |= 1;
+	hw->phy->supported.channels[2] |= 1;
 	/* 915 MHz O-QPSK 802.15.4-2006 */
-	hw->phy->channels_supported[2] |= 0x7fe;
+	hw->phy->supported.channels[2] |= 0x7fe;
 	/* 2.4 GHz CSS 802.15.4a-2007 */
-	hw->phy->channels_supported[3] |= 0x3fff;
+	hw->phy->supported.channels[3] |= 0x3fff;
 	/* UWB Sub-gigahertz 802.15.4a-2007 */
-	hw->phy->channels_supported[4] |= 1;
+	hw->phy->supported.channels[4] |= 1;
 	/* UWB Low band 802.15.4a-2007 */
-	hw->phy->channels_supported[4] |= 0x1e;
+	hw->phy->supported.channels[4] |= 0x1e;
 	/* UWB High band 802.15.4a-2007 */
-	hw->phy->channels_supported[4] |= 0xffe0;
+	hw->phy->supported.channels[4] |= 0xffe0;
 	/* 750 MHz O-QPSK 802.15.4c-2009 */
-	hw->phy->channels_supported[5] |= 0xf;
+	hw->phy->supported.channels[5] |= 0xf;
 	/* 750 MHz MPSK 802.15.4c-2009 */
-	hw->phy->channels_supported[5] |= 0xf0;
+	hw->phy->supported.channels[5] |= 0xf0;
 	/* 950 MHz BPSK 802.15.4d-2009 */
-	hw->phy->channels_supported[6] |= 0x3ff;
+	hw->phy->supported.channels[6] |= 0x3ff;
 	/* 950 MHz GFSK 802.15.4d-2009 */
-	hw->phy->channels_supported[6] |= 0x3ffc00;
+	hw->phy->supported.channels[6] |= 0x3ffc00;
 
 	INIT_LIST_HEAD(&priv->list);
 	priv->fake = fake;
diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index fba2dfd..f2a1bd1 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -750,7 +750,7 @@ static int mrf24j40_probe(struct spi_device *spi)
 
 	devrec->hw->priv = devrec;
 	devrec->hw->parent = &devrec->spi->dev;
-	devrec->hw->phy->channels_supported[0] = CHANNEL_MASK;
+	devrec->hw->phy->supported.channels[0] = CHANNEL_MASK;
 	devrec->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AACK |
 			    IEEE802154_HW_AFILT;
 
diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 9ced2c9..1941d7a 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -61,6 +61,10 @@ struct cfg802154_ops {
 				struct wpan_dev *wpan_dev, bool mode);
 };
 
+struct wpan_phy_supported {
+	u32 channels[IEEE802154_MAX_PAGE + 1];
+};
+
 struct wpan_phy_cca {
 	enum nl802154_cca_modes mode;
 	enum nl802154_cca_opts opt;
@@ -84,7 +88,7 @@ struct wpan_phy {
 	 */
 	u8 current_channel;
 	u8 current_page;
-	u32 channels_supported[IEEE802154_MAX_PAGE + 1];
+	struct wpan_phy_supported supported;
 	/* current transmit_power in mBm */
 	s32 transmit_power;
 	struct wpan_phy_cca cca;
diff --git a/net/ieee802154/nl-phy.c b/net/ieee802154/nl-phy.c
index 346c666..cbc0d09 100644
--- a/net/ieee802154/nl-phy.c
+++ b/net/ieee802154/nl-phy.c
@@ -56,8 +56,8 @@ static int ieee802154_nl_fill_phy(struct sk_buff *msg, u32 portid,
 	    nla_put_u8(msg, IEEE802154_ATTR_CHANNEL, phy->current_channel))
 		goto nla_put_failure;
 	for (i = 0; i < 32; i++) {
-		if (phy->channels_supported[i])
-			buf[pages++] = phy->channels_supported[i] | (i << 27);
+		if (phy->supported.channels[i])
+			buf[pages++] = phy->supported.channels[i] | (i << 27);
 	}
 	if (pages &&
 	    nla_put(msg, IEEE802154_ATTR_CHANNEL_PAGE_LIST,
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index f3185c7..d271879 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -248,7 +248,7 @@ nl802154_send_wpan_phy_channels(struct cfg802154_registered_device *rdev,
 
 	for (page = 0; page <= IEEE802154_MAX_PAGE; page++) {
 		if (nla_put_u32(msg, NL802154_ATTR_SUPPORTED_CHANNEL,
-				rdev->wpan_phy.channels_supported[page]))
+				rdev->wpan_phy.supported.channels[page]))
 			return -ENOBUFS;
 	}
 	nla_nest_end(msg, nl_page);
@@ -626,7 +626,7 @@ static int nl802154_set_channel(struct sk_buff *skb, struct genl_info *info)
 
 	/* check 802.15.4 constraints */
 	if (page > IEEE802154_MAX_PAGE || channel > IEEE802154_MAX_CHANNEL ||
-	    !(rdev->wpan_phy.channels_supported[page] & BIT(channel)))
+	    !(rdev->wpan_phy.supported.channels[page] & BIT(channel)))
 		return -EINVAL;
 
 	return rdev_set_channel(rdev, page, channel);
-- 
2.3.7

