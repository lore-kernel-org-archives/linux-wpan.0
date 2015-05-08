Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35606 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270AbbEHSZB (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 May 2015 14:25:01 -0400
Received: by widdi4 with SMTP id di4so39437215wid.0
        for <linux-wpan@vger.kernel.org>; Fri, 08 May 2015 11:24:59 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv3 bluetooth-next 10/17] cfg802154: introduce wpan phy flags
Date: Fri,  8 May 2015 20:24:21 +0200
Message-Id: <1431109468-4891-11-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431109468-4891-1-git-send-email-alex.aring@gmail.com>
References: <1431109468-4891-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch introduce a flag property for the wpan phy structure.
The current flag settings in ieee802154_hw are accessable in mac802154
layer only which is okay for flags which indicates MAC handling which
are done by phy. For real PHY layer settings like cca mode, transmit
power, cca energy detection level.

The difference between these flags are that the MAC handling flags are
only handled in mac802154/HardMac layer e.g. on an interface up. The phy
settings are direct netlink calls from nl802154 into the driver layer
and the nl802154 need to have a chance to check if the driver supports
this handling before sending to the next layer.

We also check now on PHY flags while dumping and setting pib attributes.
In comparing with MIB attributes the 802.15.4 gives us an default value
which we assume when a transceiver implement less functionality. In case
of MIB settings the nl802154 layer doesn't need to check on the
ieee802154_hw flags then.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c |  9 +++++++--
 include/net/cfg802154.h            | 16 ++++++++++++++++
 include/net/mac802154.h            | 29 +++++++----------------------
 net/ieee802154/nl802154.c          | 27 +++++++++++++++++----------
 net/mac802154/mac_cmd.c            |  6 +++---
 5 files changed, 50 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 151d57f..b0ffd1c 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1566,8 +1566,13 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 	}
 
 	lp->hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AACK |
-			IEEE802154_HW_TXPOWER | IEEE802154_HW_ARET |
-			IEEE802154_HW_AFILT | IEEE802154_HW_PROMISCUOUS;
+			IEEE802154_HW_CSMA_PARAMS |
+			IEEE802154_HW_FRAME_RETRIES | IEEE802154_HW_AFILT |
+			IEEE802154_HW_PROMISCUOUS;
+
+	lp->hw->phy->flags = WPAN_PHY_FLAG_TXPOWER |
+			     WPAN_PHY_FLAG_CCA_ED_LEVEL |
+			     WPAN_PHY_FLAG_CCA_MODE;
 
 	lp->hw->phy->cca.mode = NL802154_CCA_ENERGY;
 
diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 37abc16..a12c6c52 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -106,6 +106,20 @@ wpan_phy_cca_cmp(const struct wpan_phy_cca *a, const struct wpan_phy_cca *b)
 	return true;
 }
 
+/**
+ * @WPAN_PHY_FLAG_TRANSMIT_POWER: Indicates that transceiver will support
+ *	transmit power setting.
+ * @WPAN_PHY_FLAG_CCA_ED_LEVEL: Indicates that transceiver will support cca ed
+ *	level setting.
+ * @WPAN_PHY_FLAG_CCA_MODE: Indicates that transceiver will support cca mode
+ *	setting.
+ */
+enum wpan_phy_flags {
+	WPAN_PHY_FLAG_TXPOWER		= BIT(1),
+	WPAN_PHY_FLAG_CCA_ED_LEVEL	= BIT(2),
+	WPAN_PHY_FLAG_CCA_MODE		= BIT(3),
+};
+
 struct wpan_phy {
 	struct mutex pib_lock;
 
@@ -117,6 +131,8 @@ struct wpan_phy {
 	 */
 	const void *privid;
 
+	u32 flags;
+
 	/*
 	 * This is a PIB according to 802.15.4-2011.
 	 * We do not provide timing-related variables, as they
diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 71e2456..9605c7f 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -89,41 +89,26 @@ struct ieee802154_hw {
 #define IEEE802154_HW_TX_OMIT_CKSUM	0x00000001
 /* Indicates that receiver will autorespond with ACK frames. */
 #define IEEE802154_HW_AACK		0x00000002
-/* Indicates that transceiver will support transmit power setting. */
-#define IEEE802154_HW_TXPOWER		0x00000004
 /* Indicates that transceiver will support listen before transmit. */
-#define IEEE802154_HW_LBT		0x00000008
-/* Indicates that transceiver will support cca mode setting. */
-#define IEEE802154_HW_CCA_MODE		0x00000010
-/* Indicates that transceiver will support cca ed level setting. */
-#define IEEE802154_HW_CCA_ED_LEVEL	0x00000020
+#define IEEE802154_HW_LBT		0x00000004
 /* Indicates that transceiver will support csma (max_be, min_be, csma retries)
  * settings. */
-#define IEEE802154_HW_CSMA_PARAMS	0x00000040
+#define IEEE802154_HW_CSMA_PARAMS	0x00000008
 /* Indicates that transceiver will support ARET frame retries setting. */
-#define IEEE802154_HW_FRAME_RETRIES	0x00000080
+#define IEEE802154_HW_FRAME_RETRIES	0x00000010
 /* Indicates that transceiver will support hardware address filter setting. */
-#define IEEE802154_HW_AFILT		0x00000100
+#define IEEE802154_HW_AFILT		0x00000020
 /* Indicates that transceiver will support promiscuous mode setting. */
-#define IEEE802154_HW_PROMISCUOUS	0x00000200
+#define IEEE802154_HW_PROMISCUOUS	0x00000040
 /* Indicates that receiver omits FCS. */
-#define IEEE802154_HW_RX_OMIT_CKSUM	0x00000400
+#define IEEE802154_HW_RX_OMIT_CKSUM	0x00000080
 /* Indicates that receiver will not filter frames with bad checksum. */
-#define IEEE802154_HW_RX_DROP_BAD_CKSUM	0x00000800
+#define IEEE802154_HW_RX_DROP_BAD_CKSUM	0x00000100
 
 /* Indicates that receiver omits FCS and xmitter will add FCS on it's own. */
 #define IEEE802154_HW_OMIT_CKSUM	(IEEE802154_HW_TX_OMIT_CKSUM | \
 					 IEEE802154_HW_RX_OMIT_CKSUM)
 
-/* This groups the most common CSMA support fields into one. */
-#define IEEE802154_HW_CSMA		(IEEE802154_HW_CCA_MODE | \
-					 IEEE802154_HW_CCA_ED_LEVEL | \
-					 IEEE802154_HW_CSMA_PARAMS)
-
-/* This groups the most common ARET support fields into one. */
-#define IEEE802154_HW_ARET		(IEEE802154_HW_CSMA | \
-					 IEEE802154_HW_FRAME_RETRIES)
-
 /* struct ieee802154_ops - callbacks from mac802154 to the driver
  *
  * This structure contains various callbacks that the driver may
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index fa0c404..40fb0be 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -291,19 +291,23 @@ static int nl802154_send_wpan_phy(struct cfg802154_registered_device *rdev,
 		goto nla_put_failure;
 
 	/* cca mode */
-	if (nla_put_u32(msg, NL802154_ATTR_CCA_MODE,
-			rdev->wpan_phy.cca.mode))
-		goto nla_put_failure;
-
-	if (rdev->wpan_phy.cca.mode == NL802154_CCA_ENERGY_CARRIER) {
-		if (nla_put_u32(msg, NL802154_ATTR_CCA_OPT,
-				rdev->wpan_phy.cca.opt))
+	if (rdev->wpan_phy.flags & WPAN_PHY_FLAG_CCA_MODE) {
+		if (nla_put_u32(msg, NL802154_ATTR_CCA_MODE,
+				rdev->wpan_phy.cca.mode))
 			goto nla_put_failure;
+
+		if (rdev->wpan_phy.cca.mode == NL802154_CCA_ENERGY_CARRIER) {
+			if (nla_put_u32(msg, NL802154_ATTR_CCA_OPT,
+					rdev->wpan_phy.cca.opt))
+				goto nla_put_failure;
+		}
 	}
 
-	if (nla_put_s32(msg, NL802154_ATTR_TX_POWER,
-			rdev->wpan_phy.transmit_power))
-		goto nla_put_failure;
+	if (rdev->wpan_phy.flags & WPAN_PHY_FLAG_TXPOWER) {
+		if (nla_put_s32(msg, NL802154_ATTR_TX_POWER,
+				rdev->wpan_phy.transmit_power))
+			goto nla_put_failure;
+	}
 
 finish:
 	genlmsg_end(msg, hdr);
@@ -637,6 +641,9 @@ static int nl802154_set_cca_mode(struct sk_buff *skb, struct genl_info *info)
 	struct cfg802154_registered_device *rdev = info->user_ptr[0];
 	struct wpan_phy_cca cca;
 
+	if (rdev->wpan_phy.flags & WPAN_PHY_FLAG_CCA_MODE)
+		return -EOPNOTSUPP;
+
 	if (!info->attrs[NL802154_ATTR_CCA_MODE])
 		return -EINVAL;
 
diff --git a/net/mac802154/mac_cmd.c b/net/mac802154/mac_cmd.c
index bdccb4e..6dcbb3b 100644
--- a/net/mac802154/mac_cmd.c
+++ b/net/mac802154/mac_cmd.c
@@ -91,19 +91,19 @@ static int mac802154_set_mac_params(struct net_device *dev,
 	wpan_dev->frame_retries = params->frame_retries;
 	wpan_dev->lbt = params->lbt;
 
-	if (local->hw.flags & IEEE802154_HW_TXPOWER) {
+	if (local->hw.phy->flags & WPAN_PHY_FLAG_TXPOWER) {
 		ret = drv_set_tx_power(local, params->transmit_power);
 		if (ret < 0)
 			return ret;
 	}
 
-	if (local->hw.flags & IEEE802154_HW_CCA_MODE) {
+	if (local->hw.phy->flags & WPAN_PHY_FLAG_CCA_MODE) {
 		ret = drv_set_cca_mode(local, &params->cca);
 		if (ret < 0)
 			return ret;
 	}
 
-	if (local->hw.flags & IEEE802154_HW_CCA_ED_LEVEL) {
+	if (local->hw.phy->flags & WPAN_PHY_FLAG_CCA_ED_LEVEL) {
 		ret = drv_set_cca_ed_level(local, params->cca_ed_level);
 		if (ret < 0)
 			return ret;
-- 
2.3.7

