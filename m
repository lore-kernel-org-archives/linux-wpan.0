Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:62813 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757373AbaLJOdg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Dec 2014 09:33:36 -0500
Received: by mail-wg0-f50.google.com with SMTP id a1so3771540wgh.37
        for <linux-wpan@vger.kernel.org>; Wed, 10 Dec 2014 06:33:35 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/4] ieee802154: rework cca setting
Date: Wed, 10 Dec 2014 15:33:12 +0100
Message-Id: <1418221994-17976-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1418221994-17976-1-git-send-email-alex.aring@gmail.com>
References: <1418221994-17976-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

The current cca setting handle is a driver specific call. We need to
introduce some 802.15.4 specific layer and mapping 802.15.4 cca modes to
driver specific ones inside the 802.15.4 driver. This patch will add
such 802.15.4 layer and mapping the cca settings to driver specific ones.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 30 ++++++++++++++++++++++++++++--
 include/net/cfg802154.h            |  7 ++++++-
 include/net/ieee802154_netdev.h    |  4 +++-
 include/net/mac802154.h            |  5 ++++-
 net/ieee802154/nl-mac.c            |  4 ++--
 net/ieee802154/nl802154.c          |  2 +-
 net/ieee802154/sysfs.c             |  2 +-
 net/mac802154/driver-ops.h         |  5 +++--
 net/mac802154/mac_cmd.c            |  6 +++---
 9 files changed, 51 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 1c01356..1ac46ba 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1146,11 +1146,37 @@ at86rf230_set_lbt(struct ieee802154_hw *hw, bool on)
 }
 
 static int
-at86rf230_set_cca_mode(struct ieee802154_hw *hw, u8 mode)
+at86rf230_set_cca_mode(struct ieee802154_hw *hw,
+		       const struct wpan_phy_cca *cca)
 {
 	struct at86rf230_local *lp = hw->priv;
+	u8 val;
 
-	return at86rf230_write_subreg(lp, SR_CCA_MODE, mode);
+	/* mapping 802.15.4 to driver spec */
+	switch (cca->mode) {
+	case NL802154_CCA_ENERGY:
+		val = 1;
+		break;
+	case NL802154_CCA_CARRIER:
+		val = 2;
+		break;
+	case NL802154_CCA_ENERGY_CARRIER:
+		switch (cca->opt) {
+		case NL802154_CCA_OPT_ENERGY_CARRIER_AND:
+			val = 3;
+			break;
+		case NL802154_CCA_OPT_ENERGY_CARRIER_OR:
+			val = 0;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return at86rf230_write_subreg(lp, SR_CCA_MODE, val);
 }
 
 static int
diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 7f713ac..6ee2618 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -56,6 +56,11 @@ struct cfg802154_ops {
 				struct wpan_dev *wpan_dev, bool mode);
 };
 
+struct wpan_phy_cca {
+	enum nl802154_cca_modes mode;
+	enum nl802154_cca_opts opt;
+};
+
 struct wpan_phy {
 	struct mutex pib_lock;
 
@@ -76,7 +81,7 @@ struct wpan_phy {
 	u8 current_page;
 	u32 channels_supported[IEEE802154_MAX_PAGE + 1];
 	s8 transmit_power;
-	u8 cca_mode;
+	struct wpan_phy_cca cca;
 
 	__le64 perm_extended_addr;
 
diff --git a/include/net/ieee802154_netdev.h b/include/net/ieee802154_netdev.h
index 83bb8a73..94a2970 100644
--- a/include/net/ieee802154_netdev.h
+++ b/include/net/ieee802154_netdev.h
@@ -28,6 +28,8 @@
 #include <linux/skbuff.h>
 #include <linux/ieee802154.h>
 
+#include <net/cfg802154.h>
+
 struct ieee802154_sechdr {
 #if defined(__LITTLE_ENDIAN_BITFIELD)
 	u8 level:3,
@@ -337,7 +339,7 @@ struct ieee802154_mac_params {
 	s8 frame_retries;
 
 	bool lbt;
-	u8 cca_mode;
+	struct wpan_phy_cca cca;
 	s32 cca_ed_level;
 };
 
diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index c823d91..8506478 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -20,6 +20,8 @@
 #include <linux/ieee802154.h>
 #include <linux/skbuff.h>
 
+#include <net/cfg802154.h>
+
 /* General MAC frame format:
  *  2 bytes: Frame Control
  *  1 byte:  Sequence Number
@@ -212,7 +214,8 @@ struct ieee802154_ops {
 					    unsigned long changed);
 	int		(*set_txpower)(struct ieee802154_hw *hw, int db);
 	int		(*set_lbt)(struct ieee802154_hw *hw, bool on);
-	int		(*set_cca_mode)(struct ieee802154_hw *hw, u8 mode);
+	int		(*set_cca_mode)(struct ieee802154_hw *hw,
+					const struct wpan_phy_cca *cca);
 	int		(*set_cca_ed_level)(struct ieee802154_hw *hw,
 					    s32 level);
 	int		(*set_csma_params)(struct ieee802154_hw *hw,
diff --git a/net/ieee802154/nl-mac.c b/net/ieee802154/nl-mac.c
index cd91949..3c902e9 100644
--- a/net/ieee802154/nl-mac.c
+++ b/net/ieee802154/nl-mac.c
@@ -121,7 +121,7 @@ static int ieee802154_nl_fill_iface(struct sk_buff *msg, u32 portid,
 			       params.transmit_power) ||
 		    nla_put_u8(msg, IEEE802154_ATTR_LBT_ENABLED, params.lbt) ||
 		    nla_put_u8(msg, IEEE802154_ATTR_CCA_MODE,
-			       params.cca_mode) ||
+			       params.cca.mode) ||
 		    nla_put_s32(msg, IEEE802154_ATTR_CCA_ED_LEVEL,
 				params.cca_ed_level) ||
 		    nla_put_u8(msg, IEEE802154_ATTR_CSMA_RETRIES,
@@ -516,7 +516,7 @@ int ieee802154_set_macparams(struct sk_buff *skb, struct genl_info *info)
 		params.lbt = nla_get_u8(info->attrs[IEEE802154_ATTR_LBT_ENABLED]);
 
 	if (info->attrs[IEEE802154_ATTR_CCA_MODE])
-		params.cca_mode = nla_get_u8(info->attrs[IEEE802154_ATTR_CCA_MODE]);
+		params.cca.mode = nla_get_u8(info->attrs[IEEE802154_ATTR_CCA_MODE]);
 
 	if (info->attrs[IEEE802154_ATTR_CCA_ED_LEVEL])
 		params.cca_ed_level = nla_get_s32(info->attrs[IEEE802154_ATTR_CCA_ED_LEVEL]);
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 8896477..1efbe42 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -291,7 +291,7 @@ static int nl802154_send_wpan_phy(struct cfg802154_registered_device *rdev,
 
 	/* cca mode */
 	if (nla_put_u8(msg, NL802154_ATTR_CCA_MODE,
-		       rdev->wpan_phy.cca_mode))
+		       rdev->wpan_phy.cca.mode))
 		goto nla_put_failure;
 
 	if (nla_put_s8(msg, NL802154_ATTR_TX_POWER,
diff --git a/net/ieee802154/sysfs.c b/net/ieee802154/sysfs.c
index 1613b9c..dff55c2 100644
--- a/net/ieee802154/sysfs.c
+++ b/net/ieee802154/sysfs.c
@@ -68,7 +68,7 @@ static DEVICE_ATTR_RO(name)
 MASTER_SHOW(current_channel, "%d");
 MASTER_SHOW(current_page, "%d");
 MASTER_SHOW(transmit_power, "%d +- 1 dB");
-MASTER_SHOW(cca_mode, "%d");
+MASTER_SHOW_COMPLEX(cca_mode, "%d", phy->cca.mode);
 
 static ssize_t channels_supported_show(struct device *dev,
 				       struct device_attribute *attr,
diff --git a/net/mac802154/driver-ops.h b/net/mac802154/driver-ops.h
index f21e864..98180a9 100644
--- a/net/mac802154/driver-ops.h
+++ b/net/mac802154/driver-ops.h
@@ -70,7 +70,8 @@ static inline int drv_set_tx_power(struct ieee802154_local *local, s8 dbm)
 	return local->ops->set_txpower(&local->hw, dbm);
 }
 
-static inline int drv_set_cca_mode(struct ieee802154_local *local, u8 cca_mode)
+static inline int drv_set_cca_mode(struct ieee802154_local *local,
+				   const struct wpan_phy_cca *cca)
 {
 	might_sleep();
 
@@ -79,7 +80,7 @@ static inline int drv_set_cca_mode(struct ieee802154_local *local, u8 cca_mode)
 		return -EOPNOTSUPP;
 	}
 
-	return local->ops->set_cca_mode(&local->hw, cca_mode);
+	return local->ops->set_cca_mode(&local->hw, cca);
 }
 
 static inline int drv_set_lbt_mode(struct ieee802154_local *local, bool mode)
diff --git a/net/mac802154/mac_cmd.c b/net/mac802154/mac_cmd.c
index 6aacb18..bdccb4e 100644
--- a/net/mac802154/mac_cmd.c
+++ b/net/mac802154/mac_cmd.c
@@ -81,7 +81,7 @@ static int mac802154_set_mac_params(struct net_device *dev,
 
 	/* PHY */
 	wpan_dev->wpan_phy->transmit_power = params->transmit_power;
-	wpan_dev->wpan_phy->cca_mode = params->cca_mode;
+	wpan_dev->wpan_phy->cca = params->cca;
 	wpan_dev->wpan_phy->cca_ed_level = params->cca_ed_level;
 
 	/* MAC */
@@ -98,7 +98,7 @@ static int mac802154_set_mac_params(struct net_device *dev,
 	}
 
 	if (local->hw.flags & IEEE802154_HW_CCA_MODE) {
-		ret = drv_set_cca_mode(local, params->cca_mode);
+		ret = drv_set_cca_mode(local, &params->cca);
 		if (ret < 0)
 			return ret;
 	}
@@ -122,7 +122,7 @@ static void mac802154_get_mac_params(struct net_device *dev,
 
 	/* PHY */
 	params->transmit_power = wpan_dev->wpan_phy->transmit_power;
-	params->cca_mode = wpan_dev->wpan_phy->cca_mode;
+	params->cca = wpan_dev->wpan_phy->cca;
 	params->cca_ed_level = wpan_dev->wpan_phy->cca_ed_level;
 
 	/* MAC */
-- 
2.1.3

