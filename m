Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:35771 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbbE0DlY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 26 May 2015 23:41:24 -0400
Received: by pdea3 with SMTP id a3so106673359pde.2
        for <linux-wpan@vger.kernel.org>; Tue, 26 May 2015 20:41:24 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCHv4 bluetooth-next] ieee802154: add set transmit power support
Date: Wed, 27 May 2015 09:10:54 +0530
Message-Id: <1432698054-10050-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

This patch adds transmission power setting support for IEEE-802.15.4
devices via nl802154.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 include/net/cfg802154.h   |    1 +
 net/ieee802154/nl802154.c |   30 ++++++++++++++++++++++++++++++
 net/ieee802154/rdev-ops.h |   12 ++++++++++++
 net/ieee802154/trace.h    |   15 +++++++++++++++
 net/mac802154/cfg.c       |   19 +++++++++++++++++++
 5 files changed, 77 insertions(+)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 4de59aa..2e3bb01 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -44,6 +44,7 @@ struct cfg802154_ops {
 	int	(*set_channel)(struct wpan_phy *wpan_phy, u8 page, u8 channel);
 	int	(*set_cca_mode)(struct wpan_phy *wpan_phy,
 				const struct wpan_phy_cca *cca);
+	int     (*set_tx_power)(struct wpan_phy *wpan_phy, s32 power);
 	int	(*set_pan_id)(struct wpan_phy *wpan_phy,
 			      struct wpan_dev *wpan_dev, __le16 pan_id);
 	int	(*set_short_addr)(struct wpan_phy *wpan_phy,
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 212a795..5c9d524 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -783,6 +783,28 @@ static int nl802154_set_cca_mode(struct sk_buff *skb, struct genl_info *info)
 	return rdev_set_cca_mode(rdev, &cca);
 }
 
+static int nl802154_set_tx_power(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg802154_registered_device *rdev = info->user_ptr[0];
+	s32 power;
+	int i;
+
+	if (!(rdev->wpan_phy.flags & WPAN_PHY_FLAG_TXPOWER))
+		return -EOPNOTSUPP;
+
+	if (!info->attrs[NL802154_ATTR_TX_POWER])
+		return -EINVAL;
+
+	power = nla_get_s32(info->attrs[NL802154_ATTR_TX_POWER]);
+
+	for (i = 0; i < rdev->wpan_phy.supported.tx_powers_size; i++) {
+		if (power == rdev->wpan_phy.supported.tx_powers[i])
+			return rdev_set_tx_power(rdev, power);
+	}
+
+	return -EINVAL;
+}
+
 static int nl802154_set_pan_id(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg802154_registered_device *rdev = info->user_ptr[0];
@@ -1094,6 +1116,14 @@ static const struct genl_ops nl802154_ops[] = {
 				  NL802154_FLAG_NEED_RTNL,
 	},
 	{
+		.cmd = NL802154_CMD_SET_TX_POWER,
+		.doit = nl802154_set_tx_power,
+		.policy = nl802154_policy,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = NL802154_FLAG_NEED_WPAN_PHY |
+				  NL802154_FLAG_NEED_RTNL,
+	},
+	{
 		.cmd = NL802154_CMD_SET_PAN_ID,
 		.doit = nl802154_set_pan_id,
 		.policy = nl802154_policy,
diff --git a/net/ieee802154/rdev-ops.h b/net/ieee802154/rdev-ops.h
index 7b5a9dd..3645611 100644
--- a/net/ieee802154/rdev-ops.h
+++ b/net/ieee802154/rdev-ops.h
@@ -75,6 +75,18 @@ rdev_set_cca_mode(struct cfg802154_registered_device *rdev,
 }
 
 static inline int
+rdev_set_tx_power(struct cfg802154_registered_device *rdev,
+		  s32 power)
+{
+	int ret;
+
+	trace_802154_rdev_set_tx_power(&rdev->wpan_phy, power);
+	ret = rdev->ops->set_tx_power(&rdev->wpan_phy, power);
+	trace_802154_rdev_return_int(&rdev->wpan_phy, ret);
+	return ret;
+}
+
+static inline int
 rdev_set_pan_id(struct cfg802154_registered_device *rdev,
 		struct wpan_dev *wpan_dev, __le16 pan_id)
 {
diff --git a/net/ieee802154/trace.h b/net/ieee802154/trace.h
index 5ac25eb..1f1cecc 100644
--- a/net/ieee802154/trace.h
+++ b/net/ieee802154/trace.h
@@ -93,6 +93,21 @@ TRACE_EVENT(802154_rdev_set_channel,
 		  __entry->page, __entry->channel)
 );
 
+TRACE_EVENT(802154_rdev_set_tx_power,
+	TP_PROTO(struct wpan_phy *wpan_phy, s32 power),
+	TP_ARGS(wpan_phy, power),
+	TP_STRUCT__entry(
+		WPAN_PHY_ENTRY
+		__field(s32, power)
+	),
+	TP_fast_assign(
+		WPAN_PHY_ASSIGN;
+		__entry->power = power;
+	),
+	TP_printk(WPAN_PHY_PR_FMT ", power: %d", WPAN_PHY_PR_ARG,
+		  __entry->power)
+);
+
 TRACE_EVENT(802154_rdev_set_cca_mode,
 	TP_PROTO(struct wpan_phy *wpan_phy, const struct wpan_phy_cca *cca),
 	TP_ARGS(wpan_phy, cca),
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index d5290ea..ab12fa2 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -106,6 +106,24 @@ ieee802154_set_cca_mode(struct wpan_phy *wpan_phy,
 }
 
 static int
+ieee802154_set_tx_power(struct wpan_phy *wpan_phy, s32 power)
+{
+	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
+	int ret;
+
+	ASSERT_RTNL();
+
+	if (wpan_phy->transmit_power == power)
+		return 0;
+
+	ret = drv_set_tx_power(local, power);
+	if (!ret)
+		wpan_phy->transmit_power = power;
+
+	return ret;
+}
+
+static int
 ieee802154_set_pan_id(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 		      __le16 pan_id)
 {
@@ -195,6 +213,7 @@ const struct cfg802154_ops mac802154_config_ops = {
 	.del_virtual_intf = ieee802154_del_iface,
 	.set_channel = ieee802154_set_channel,
 	.set_cca_mode = ieee802154_set_cca_mode,
+	.set_tx_power = ieee802154_set_tx_power,
 	.set_pan_id = ieee802154_set_pan_id,
 	.set_short_addr = ieee802154_set_short_addr,
 	.set_backoff_exponent = ieee802154_set_backoff_exponent,
-- 
1.7.9.5

