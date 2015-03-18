Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:36366 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755603AbbCRLlI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 18 Mar 2015 07:41:08 -0400
Received: by wetk59 with SMTP id k59so29948192wet.3
        for <linux-wpan@vger.kernel.org>; Wed, 18 Mar 2015 04:41:06 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/2] nl802154: add set wpan phy cmd
Date: Wed, 18 Mar 2015 12:40:21 +0100
Message-Id: <1426678822-26644-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1426678822-26644-1-git-send-email-alex.aring@gmail.com>
References: <1426678822-26644-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds NL802154_CMD_SET_WPAN_PHY command to set all wpan phy
attributes instead of doing separate commands. This will improve
userspace application handling of nl802154.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/nl802154.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index a4daf91..111e9a1 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -437,6 +437,49 @@ static int nl802154_get_wpan_phy(struct sk_buff *skb, struct genl_info *info)
 	return genlmsg_reply(msg, info);
 }
 
+static int nl802154_set_wpan_phy(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg802154_registered_device *rdev = info->user_ptr[0];
+	int ret;
+
+	if (info->attrs[NL802154_ATTR_PAGE] &&
+	    info->attrs[NL802154_ATTR_CHANNEL]) {
+		u8 channel, page;
+
+		page = nla_get_u8(info->attrs[NL802154_ATTR_PAGE]);
+		channel = nla_get_u8(info->attrs[NL802154_ATTR_CHANNEL]);
+		if (page > IEEE802154_MAX_PAGE ||
+		    channel > IEEE802154_MAX_CHANNEL)
+			return -EINVAL;
+
+		ret = rdev_set_channel(rdev, page, channel);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (info->attrs[NL802154_ATTR_CCA_MODE]) {
+		struct wpan_phy_cca cca;
+
+		cca.mode = nla_get_u32(info->attrs[NL802154_ATTR_CCA_MODE]);
+		if (cca.mode < NL802154_CCA_ENERGY ||
+		    cca.mode > NL802154_CCA_ATTR_MAX)
+			return -EINVAL;
+
+		if (cca.mode == NL802154_CCA_ENERGY_CARRIER) {
+			if (!info->attrs[NL802154_ATTR_CCA_OPT])
+				return -EINVAL;
+
+			cca.opt = nla_get_u32(info->attrs[NL802154_ATTR_CCA_OPT]);
+			if (cca.opt > NL802154_CCA_OPT_ATTR_MAX)
+				return -EINVAL;
+		}
+
+		return rdev_set_cca_mode(rdev, &cca);
+	}
+
+	return 0;
+}
+
 static inline u64 wpan_dev_id(struct wpan_dev *wpan_dev)
 {
 	return (u64)wpan_dev->identifier |
@@ -896,6 +939,15 @@ static const struct genl_ops nl802154_ops[] = {
 				  NL802154_FLAG_NEED_RTNL,
 	},
 	{
+		.cmd = NL802154_CMD_SET_WPAN_PHY,
+		.doit = nl802154_set_wpan_phy,
+		.done = nl802154_dump_wpan_phy_done,
+		.policy = nl802154_policy,
+		.flags = GENL_ADMIN_PERM,
+		.internal_flags = NL802154_FLAG_NEED_WPAN_PHY |
+				  NL802154_FLAG_NEED_RTNL,
+	},
+	{
 		.cmd = NL802154_CMD_GET_INTERFACE,
 		.doit = nl802154_get_interface,
 		.dumpit = nl802154_dump_interface,
-- 
2.3.3

