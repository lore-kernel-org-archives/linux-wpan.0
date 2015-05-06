Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38093 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbbEFLlI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 6 May 2015 07:41:08 -0400
Received: by wiun10 with SMTP id n10so18802537wiu.1
        for <linux-wpan@vger.kernel.org>; Wed, 06 May 2015 04:41:07 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 wpan-next 02/16] ieee802154: change transmit power to mbm
Date: Wed,  6 May 2015 13:40:14 +0200
Message-Id: <1430912428-17284-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1430912428-17284-1-git-send-email-alex.aring@gmail.com>
References: <1430912428-17284-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch change the handling of transmit power level from dbm to mbm.
This prepares to handle floating point transmit power levels values. The
old netlink 802.15.4 will convert the dbm value to mbm for handling
backward compatibility.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 3 ++-
 include/net/cfg802154.h            | 1 +
 include/net/mac802154.h            | 2 +-
 net/ieee802154/nl-mac.c            | 4 ++--
 net/mac802154/driver-ops.h         | 4 ++--
 5 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 02b6bb7..3a303e4 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1194,9 +1194,10 @@ at86rf230_set_hw_addr_filt(struct ieee802154_hw *hw,
 }
 
 static int
-at86rf230_set_txpower(struct ieee802154_hw *hw, s32 db)
+at86rf230_set_txpower(struct ieee802154_hw *hw, s32 mbm)
 {
 	struct at86rf230_local *lp = hw->priv;
+	s8 db = mbm / 100;
 
 	/* typical maximum output is 5dBm with RG_PHY_TX_PWR 0x60, lower five
 	 * bits decrease power in 1dB steps. 0x60 represents extra PA gain of
diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 47804cd..b5b3f9f 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -85,6 +85,7 @@ struct wpan_phy {
 	u8 current_channel;
 	u8 current_page;
 	u32 channels_supported[IEEE802154_MAX_PAGE + 1];
+	/* current transmit_power in mBm */
 	s32 transmit_power;
 	struct wpan_phy_cca cca;
 
diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 400e4e8..beb07ce 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -171,7 +171,7 @@ struct ieee802154_hw {
  *	  Returns either zero, or negative errno.
  *
  * set_txpower:
- *	  Set radio transmit power in dB. Called with pib_lock held.
+ *	  Set radio transmit power in mBm. Called with pib_lock held.
  *	  Returns either zero, or negative errno.
  *
  * set_lbt
diff --git a/net/ieee802154/nl-mac.c b/net/ieee802154/nl-mac.c
index 2b4955d..4ba2e13 100644
--- a/net/ieee802154/nl-mac.c
+++ b/net/ieee802154/nl-mac.c
@@ -117,7 +117,7 @@ static int ieee802154_nl_fill_iface(struct sk_buff *msg, u32 portid,
 		rtnl_unlock();
 
 		if (nla_put_s8(msg, IEEE802154_ATTR_TXPOWER,
-			       params.transmit_power) ||
+			       params.transmit_power / 100) ||
 		    nla_put_u8(msg, IEEE802154_ATTR_LBT_ENABLED, params.lbt) ||
 		    nla_put_u8(msg, IEEE802154_ATTR_CCA_MODE,
 			       params.cca.mode) ||
@@ -510,7 +510,7 @@ int ieee802154_set_macparams(struct sk_buff *skb, struct genl_info *info)
 	ops->get_mac_params(dev, &params);
 
 	if (info->attrs[IEEE802154_ATTR_TXPOWER])
-		params.transmit_power = nla_get_s8(info->attrs[IEEE802154_ATTR_TXPOWER]);
+		params.transmit_power = nla_get_s8(info->attrs[IEEE802154_ATTR_TXPOWER]) * 100;
 
 	if (info->attrs[IEEE802154_ATTR_LBT_ENABLED])
 		params.lbt = nla_get_u8(info->attrs[IEEE802154_ATTR_LBT_ENABLED]);
diff --git a/net/mac802154/driver-ops.h b/net/mac802154/driver-ops.h
index 57c1bdb..d289ae3 100644
--- a/net/mac802154/driver-ops.h
+++ b/net/mac802154/driver-ops.h
@@ -58,7 +58,7 @@ drv_set_channel(struct ieee802154_local *local, u8 page, u8 channel)
 	return local->ops->set_channel(&local->hw, page, channel);
 }
 
-static inline int drv_set_tx_power(struct ieee802154_local *local, s32 dbm)
+static inline int drv_set_tx_power(struct ieee802154_local *local, s32 mbm)
 {
 	might_sleep();
 
@@ -67,7 +67,7 @@ static inline int drv_set_tx_power(struct ieee802154_local *local, s32 dbm)
 		return -EOPNOTSUPP;
 	}
 
-	return local->ops->set_txpower(&local->hw, dbm);
+	return local->ops->set_txpower(&local->hw, mbm);
 }
 
 static inline int drv_set_cca_mode(struct ieee802154_local *local,
-- 
2.3.7

