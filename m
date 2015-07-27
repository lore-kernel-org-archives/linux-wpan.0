Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38773 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823AbbG0NGT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Jul 2015 09:06:19 -0400
Received: by wibxm9 with SMTP id xm9so115793737wib.1
        for <linux-wpan@vger.kernel.org>; Mon, 27 Jul 2015 06:06:18 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFCv2 bluetooth-next 6/6] ieee802154: add ack request default handling
Date: Mon, 27 Jul 2015 15:06:19 +0200
Message-Id: <1438002379-17294-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1438002379-17294-1-git-send-email-alex.aring@gmail.com>
References: <1438002379-17294-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch introduce a new mib entry which isn't part of 802.15.4 but
useful as default behaviour to set the ack request bit or not if we
don't know if the ack request bit should set. This is currently used for
stacks like IEEE 802.15.4 6LoWPAN.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h     |  5 +++++
 include/net/nl802154.h      |  4 ++++
 net/ieee802154/6lowpan/tx.c |  2 +-
 net/ieee802154/nl802154.c   | 33 +++++++++++++++++++++++++++++++++
 net/ieee802154/rdev-ops.h   | 13 +++++++++++++
 net/ieee802154/trace.h      | 19 +++++++++++++++++++
 net/mac802154/cfg.c         | 11 +++++++++++
 7 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 382f94b..21353f8 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -63,6 +63,8 @@ struct cfg802154_ops {
 					 s8 max_frame_retries);
 	int	(*set_lbt_mode)(struct wpan_phy *wpan_phy,
 				struct wpan_dev *wpan_dev, bool mode);
+	int	(*set_ackreq_default)(struct wpan_phy *wpan_phy,
+				      struct wpan_dev *wpan_dev, bool ackreq);
 };
 
 static inline bool
@@ -193,6 +195,9 @@ struct wpan_dev {
 	bool lbt;
 
 	bool promiscuous_mode;
+
+	/* fallback for acknowledgment bit setting */
+	bool ackreq;
 };
 
 #define to_phy(_dev)	container_of(_dev, struct wpan_phy, dev)
diff --git a/include/net/nl802154.h b/include/net/nl802154.h
index b0ab530..cf2713d 100644
--- a/include/net/nl802154.h
+++ b/include/net/nl802154.h
@@ -52,6 +52,8 @@ enum nl802154_commands {
 
 	NL802154_CMD_SET_LBT_MODE,
 
+	NL802154_CMD_SET_ACKREQ_DEFAULT,
+
 	/* add new commands above here */
 
 	/* used to define NL802154_CMD_MAX below */
@@ -104,6 +106,8 @@ enum nl802154_attrs {
 
 	NL802154_ATTR_SUPPORTED_COMMANDS,
 
+	NL802154_ATTR_ACKREQ_DEFAULT,
+
 	/* add attributes here, update the policy in nl802154.c */
 
 	__NL802154_ATTR_AFTER_LAST,
diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index 2597abb..1bf4a30 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -224,7 +224,7 @@ static int lowpan_header(struct sk_buff *skb, struct net_device *dev)
 	} else {
 		da.mode = IEEE802154_ADDR_LONG;
 		da.extended_addr = ieee802154_devaddr_from_raw(daddr);
-		cb->ackreq = wpan_dev->frame_retries >= 0;
+		cb->ackreq = wpan_dev->ackreq;
 	}
 
 	return dev_hard_header(skb, lowpan_dev_info(dev)->real_dev,
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 68f2401..1b00a14 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -230,6 +230,8 @@ static const struct nla_policy nl802154_policy[NL802154_ATTR_MAX+1] = {
 	[NL802154_ATTR_WPAN_PHY_CAPS] = { .type = NLA_NESTED },
 
 	[NL802154_ATTR_SUPPORTED_COMMANDS] = { .type = NLA_NESTED },
+
+	[NL802154_ATTR_ACKREQ_DEFAULT] = { .type = NLA_U8 },
 };
 
 /* message building helper */
@@ -458,6 +460,7 @@ static int nl802154_send_wpan_phy(struct cfg802154_registered_device *rdev,
 	CMD(set_max_csma_backoffs, SET_MAX_CSMA_BACKOFFS);
 	CMD(set_max_frame_retries, SET_MAX_FRAME_RETRIES);
 	CMD(set_lbt_mode, SET_LBT_MODE);
+	CMD(set_ackreq_default, SET_ACKREQ_DEFAULT);
 
 	if (rdev->wpan_phy.flags & WPAN_PHY_FLAG_TXPOWER)
 		CMD(set_tx_power, SET_TX_POWER);
@@ -656,6 +659,10 @@ nl802154_send_iface(struct sk_buff *msg, u32 portid, u32 seq, int flags,
 	if (nla_put_u8(msg, NL802154_ATTR_LBT_MODE, wpan_dev->lbt))
 		goto nla_put_failure;
 
+	/* ackreq default behaviour */
+	if (nla_put_u8(msg, NL802154_ATTR_ACKREQ_DEFAULT, wpan_dev->ackreq))
+		goto nla_put_failure;
+
 	genlmsg_end(msg, hdr);
 	return 0;
 
@@ -1042,6 +1049,24 @@ static int nl802154_set_lbt_mode(struct sk_buff *skb, struct genl_info *info)
 	return rdev_set_lbt_mode(rdev, wpan_dev, mode);
 }
 
+static int
+nl802154_set_ackreq_default(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg802154_registered_device *rdev = info->user_ptr[0];
+	struct net_device *dev = info->user_ptr[1];
+	struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
+	bool ackreq;
+
+	if (netif_running(dev))
+		return -EBUSY;
+
+	if (!info->attrs[NL802154_ATTR_ACKREQ_DEFAULT])
+		return -EINVAL;
+
+	ackreq = !!nla_get_u8(info->attrs[NL802154_ATTR_ACKREQ_DEFAULT]);
+	return rdev_set_ackreq_default(rdev, wpan_dev, ackreq);
+}
+
 #define NL802154_FLAG_NEED_WPAN_PHY	0x01
 #define NL802154_FLAG_NEED_NETDEV	0x02
 #define NL802154_FLAG_NEED_RTNL		0x04
@@ -1248,6 +1273,14 @@ static const struct genl_ops nl802154_ops[] = {
 		.internal_flags = NL802154_FLAG_NEED_NETDEV |
 				  NL802154_FLAG_NEED_RTNL,
 	},
+	{
+		.cmd = NL802154_CMD_SET_ACKREQ_DEFAULT,
+		.doit = nl802154_set_ackreq_default,
+		.policy = nl802154_policy,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = NL802154_FLAG_NEED_NETDEV |
+				  NL802154_FLAG_NEED_RTNL,
+	},
 };
 
 /* initialisation/exit functions */
diff --git a/net/ieee802154/rdev-ops.h b/net/ieee802154/rdev-ops.h
index 8d5960a..03b3575 100644
--- a/net/ieee802154/rdev-ops.h
+++ b/net/ieee802154/rdev-ops.h
@@ -195,4 +195,17 @@ rdev_set_lbt_mode(struct cfg802154_registered_device *rdev,
 	return ret;
 }
 
+static inline int
+rdev_set_ackreq_default(struct cfg802154_registered_device *rdev,
+			struct wpan_dev *wpan_dev, bool ackreq)
+{
+	int ret;
+
+	trace_802154_rdev_set_ackreq_default(&rdev->wpan_phy, wpan_dev,
+					     ackreq);
+	ret = rdev->ops->set_ackreq_default(&rdev->wpan_phy, wpan_dev, ackreq);
+	trace_802154_rdev_return_int(&rdev->wpan_phy, ret);
+	return ret;
+}
+
 #endif /* __CFG802154_RDEV_OPS */
diff --git a/net/ieee802154/trace.h b/net/ieee802154/trace.h
index 4399b7f..9a471e4 100644
--- a/net/ieee802154/trace.h
+++ b/net/ieee802154/trace.h
@@ -275,6 +275,25 @@ TRACE_EVENT(802154_rdev_set_lbt_mode,
 		WPAN_DEV_PR_ARG, BOOL_TO_STR(__entry->mode))
 );
 
+TRACE_EVENT(802154_rdev_set_ackreq_default,
+	TP_PROTO(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
+		 bool ackreq),
+	TP_ARGS(wpan_phy, wpan_dev, ackreq),
+	TP_STRUCT__entry(
+		WPAN_PHY_ENTRY
+		WPAN_DEV_ENTRY
+		__field(bool, ackreq)
+	),
+	TP_fast_assign(
+		WPAN_PHY_ASSIGN;
+		WPAN_DEV_ASSIGN;
+		__entry->ackreq = ackreq;
+	),
+	TP_printk(WPAN_PHY_PR_FMT ", " WPAN_DEV_PR_FMT
+		", ackreq default: %s", WPAN_PHY_PR_ARG,
+		WPAN_DEV_PR_ARG, BOOL_TO_STR(__entry->ackreq))
+);
+
 TRACE_EVENT(802154_rdev_return_int,
 	TP_PROTO(struct wpan_phy *wpan_phy, int ret),
 	TP_ARGS(wpan_phy, ret),
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index cecfcda..c865ebb 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -256,6 +256,16 @@ ieee802154_set_lbt_mode(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 	return 0;
 }
 
+static int
+ieee802154_set_ackreq_default(struct wpan_phy *wpan_phy,
+			      struct wpan_dev *wpan_dev, bool ackreq)
+{
+	ASSERT_RTNL();
+
+	wpan_dev->ackreq = ackreq;
+	return 0;
+}
+
 const struct cfg802154_ops mac802154_config_ops = {
 	.add_virtual_intf_deprecated = ieee802154_add_iface_deprecated,
 	.del_virtual_intf_deprecated = ieee802154_del_iface_deprecated,
@@ -273,4 +283,5 @@ const struct cfg802154_ops mac802154_config_ops = {
 	.set_max_csma_backoffs = ieee802154_set_max_csma_backoffs,
 	.set_max_frame_retries = ieee802154_set_max_frame_retries,
 	.set_lbt_mode = ieee802154_set_lbt_mode,
+	.set_ackreq_default = ieee802154_set_ackreq_default,
 };
-- 
2.4.6

