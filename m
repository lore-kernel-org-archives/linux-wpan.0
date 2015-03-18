Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:33078 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755939AbbCRLlK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 18 Mar 2015 07:41:10 -0400
Received: by weop45 with SMTP id p45so30002214weo.0
        for <linux-wpan@vger.kernel.org>; Wed, 18 Mar 2015 04:41:08 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/2] nl802154: add set interface cmd
Date: Wed, 18 Mar 2015 12:40:22 +0100
Message-Id: <1426678822-26644-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1426678822-26644-1-git-send-email-alex.aring@gmail.com>
References: <1426678822-26644-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch introduce the NL802154_CMD_SET_INTERFACE command which
handles setting of all wpan interface mac attributes. This will reduce
the complexity of several netlink commands for each attributes and
userspace applications are easier to implement.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/nl802154.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 111e9a1..b1d8e51 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -603,6 +603,108 @@ static int nl802154_get_interface(struct sk_buff *skb, struct genl_info *info)
 	return genlmsg_reply(msg, info);
 }
 
+static int nl802154_set_interface(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg802154_registered_device *rdev = info->user_ptr[0];
+	struct net_device *dev = info->user_ptr[1];
+	struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
+	int ret;
+
+	if (info->attrs[NL802154_ATTR_PAN_ID]) {
+		__le16 pan_id;
+
+		if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR)
+			return -EINVAL;
+
+		if (netif_running(dev))
+			return -EBUSY;
+
+		pan_id = nla_get_le16(info->attrs[NL802154_ATTR_PAN_ID]);
+		ret = rdev_set_pan_id(rdev, wpan_dev, pan_id);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (info->attrs[NL802154_ATTR_SHORT_ADDR]) {
+		__le16 short_addr;
+
+		if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR)
+			return -EINVAL;
+
+		if (netif_running(dev))
+			return -EBUSY;
+
+		short_addr = nla_get_le16(info->attrs[NL802154_ATTR_SHORT_ADDR]);
+
+		ret = rdev_set_short_addr(rdev, wpan_dev, short_addr);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (info->attrs[NL802154_ATTR_MAX_FRAME_RETRIES]) {
+		s8 max_frame_retries;
+
+		if (netif_running(dev))
+			return -EBUSY;
+
+		max_frame_retries = nla_get_s8(
+				info->attrs[NL802154_ATTR_MAX_FRAME_RETRIES]);
+		if (max_frame_retries < -1 || max_frame_retries > 7)
+			return -EINVAL;
+
+		ret = rdev_set_max_frame_retries(rdev, wpan_dev,
+						 max_frame_retries);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (info->attrs[NL802154_ATTR_MIN_BE] &&
+	    info->attrs[NL802154_ATTR_MAX_BE]) {
+		u8 min_be, max_be;
+
+		if (netif_running(dev))
+			return -EBUSY;
+
+		min_be = nla_get_u8(info->attrs[NL802154_ATTR_MIN_BE]);
+		max_be = nla_get_u8(info->attrs[NL802154_ATTR_MAX_BE]);
+		if (max_be < 3 || max_be > 8 || min_be > max_be)
+			return -EINVAL;
+
+		ret = rdev_set_backoff_exponent(rdev, wpan_dev, min_be, max_be);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (info->attrs[NL802154_ATTR_MAX_CSMA_BACKOFFS]) {
+		u8 max_csma_backoffs;
+
+		if (netif_running(dev))
+			return -EBUSY;
+
+		max_csma_backoffs = nla_get_u8(
+				info->attrs[NL802154_ATTR_MAX_CSMA_BACKOFFS]);
+		if (max_csma_backoffs > 5)
+			return -EINVAL;
+
+		ret = rdev_set_max_csma_backoffs(rdev, wpan_dev,
+						 max_csma_backoffs);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (info->attrs[NL802154_ATTR_LBT_MODE]) {
+		bool mode;
+
+		if (netif_running(dev))
+			return -EBUSY;
+
+		mode = !!nla_get_u8(info->attrs[NL802154_ATTR_LBT_MODE]);
+		return rdev_set_lbt_mode(rdev, wpan_dev, mode);
+	}
+
+	return 0;
+}
+
 static int nl802154_new_interface(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg802154_registered_device *rdev = info->user_ptr[0];
@@ -965,6 +1067,14 @@ static const struct genl_ops nl802154_ops[] = {
 				  NL802154_FLAG_NEED_RTNL,
 	},
 	{
+		.cmd = NL802154_CMD_SET_INTERFACE,
+		.doit = nl802154_set_interface,
+		.policy = nl802154_policy,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = NL802154_FLAG_NEED_NETDEV |
+				  NL802154_FLAG_NEED_RTNL,
+	},
+	{
 		.cmd = NL802154_CMD_DEL_INTERFACE,
 		.doit = nl802154_del_interface,
 		.policy = nl802154_policy,
-- 
2.3.3

