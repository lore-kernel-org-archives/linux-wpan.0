Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:47608 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbaKIHhg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 9 Nov 2014 02:37:36 -0500
Received: by mail-wi0-f170.google.com with SMTP id r20so7523398wiv.3
        for <linux-wpan@vger.kernel.org>; Sat, 08 Nov 2014 23:37:35 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 11/15] ieee802154: add wpan_dev dump support
Date: Sun,  9 Nov 2014 08:36:55 +0100
Message-Id: <1415518619-4370-12-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
References: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for wpan_dev dump via nl802154 framework.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/nl802154.c | 145 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 32e8847..46df7dc 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -198,6 +198,8 @@ static const struct nla_policy nl802154_policy[NL802154_ATTR_MAX+1] = {
 					  .len = 20-1 },
 
 	[NL802154_ATTR_IFINDEX] = { .type = NLA_U32 },
+	[NL802154_ATTR_IFTYPE] = { .type = NLA_U32 },
+	[NL802154_ATTR_IFNAME] = { .type = NLA_NUL_STRING, .len = IFNAMSIZ-1 },
 
 	[NL802154_ATTR_WPAN_DEV] = { .type = NLA_U64 },
 
@@ -209,6 +211,18 @@ static const struct nla_policy nl802154_policy[NL802154_ATTR_MAX+1] = {
 	[NL802154_ATTR_CCA_MODE] = { .type = NLA_U8, },
 
 	[NL802154_ATTR_SUPPORTED_CHANNEL] = { .type = NLA_U32, },
+
+	[NL802154_ATTR_PAN_ID] = { .type = NLA_U16, },
+	[NL802154_ATTR_EXTENDED_ADDR] = { .type = NLA_U64 },
+	[NL802154_ATTR_SHORT_ADDR] = { .type = NLA_U16, },
+
+	[NL802154_ATTR_MIN_BE] = { .type = NLA_U8, },
+	[NL802154_ATTR_MAX_BE] = { .type = NLA_U8, },
+	[NL802154_ATTR_MAX_CSMA_BACKOFFS] = { .type = NLA_U8, },
+
+	[NL802154_ATTR_MAX_FRAME_RETRIES] = { .type = NLA_S8, },
+
+	[NL802154_ATTR_LBT_MODE] = { .type = NLA_U8, },
 };
 
 /* message building helper */
@@ -414,6 +428,128 @@ static int nl802154_get_wpan_phy(struct sk_buff *skb, struct genl_info *info)
 	return genlmsg_reply(msg, info);
 }
 
+static inline u64 wpan_dev_id(struct wpan_dev *wpan_dev)
+{
+	return (u64)wpan_dev->identifier |
+	       ((u64)wpan_phy_to_rdev(wpan_dev->wpan_phy)->wpan_phy_idx << 32);
+}
+
+static int
+nl802154_send_iface(struct sk_buff *msg, u32 portid, u32 seq, int flags,
+		    struct cfg802154_registered_device *rdev,
+		    struct wpan_dev *wpan_dev)
+{
+	struct net_device *dev = wpan_dev->netdev;
+	void *hdr;
+
+	hdr = nl802154hdr_put(msg, portid, seq, flags,
+			      NL802154_CMD_NEW_INTERFACE);
+	if (!hdr)
+		return -1;
+
+	if (dev &&
+	    (nla_put_u32(msg, NL802154_ATTR_IFINDEX, dev->ifindex) ||
+	     nla_put_string(msg, NL802154_ATTR_IFNAME, dev->name)))
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, NL802154_ATTR_WPAN_PHY, rdev->wpan_phy_idx) ||
+	    nla_put_u32(msg, NL802154_ATTR_IFTYPE, wpan_dev->iftype) ||
+	    nla_put_u64(msg, NL802154_ATTR_WPAN_DEV, wpan_dev_id(wpan_dev)) ||
+	    nla_put_u32(msg, NL802154_ATTR_GENERATION,
+			rdev->devlist_generation ^
+			(cfg802154_rdev_list_generation << 2)))
+		goto nla_put_failure;
+
+	/* address settings */
+	if (nla_put_le64(msg, NL802154_ATTR_EXTENDED_ADDR,
+			 wpan_dev->extended_addr) ||
+	    nla_put_le16(msg, NL802154_ATTR_SHORT_ADDR,
+			 wpan_dev->short_addr) ||
+	    nla_put_le16(msg, NL802154_ATTR_PAN_ID, wpan_dev->pan_id))
+		goto nla_put_failure;
+
+	/* ARET handling */
+	if (nla_put_s8(msg, NL802154_ATTR_MAX_FRAME_RETRIES,
+		       wpan_dev->frame_retries) ||
+	    nla_put_u8(msg, NL802154_ATTR_MAX_BE, wpan_dev->max_be) ||
+	    nla_put_u8(msg, NL802154_ATTR_MAX_CSMA_BACKOFFS,
+		       wpan_dev->csma_retries) ||
+	    nla_put_u8(msg, NL802154_ATTR_MIN_BE, wpan_dev->min_be))
+		goto nla_put_failure;
+
+	/* listen before transmit */
+	if (nla_put_u8(msg, NL802154_ATTR_LBT_MODE, wpan_dev->lbt))
+		goto nla_put_failure;
+
+	return genlmsg_end(msg, hdr);
+
+nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	return -EMSGSIZE;
+}
+
+static int
+nl802154_dump_interface(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	int wp_idx = 0;
+	int if_idx = 0;
+	int wp_start = cb->args[0];
+	int if_start = cb->args[1];
+	struct cfg802154_registered_device *rdev;
+	struct wpan_dev *wpan_dev;
+
+	rtnl_lock();
+	list_for_each_entry(rdev, &cfg802154_rdev_list, list) {
+		/* TODO netns compare */
+		if (wp_idx < wp_start) {
+			wp_idx++;
+			continue;
+		}
+		if_idx = 0;
+
+		list_for_each_entry(wpan_dev, &rdev->wpan_dev_list, list) {
+			if (if_idx < if_start) {
+				if_idx++;
+				continue;
+			}
+			if (nl802154_send_iface(skb, NETLINK_CB(cb->skb).portid,
+						cb->nlh->nlmsg_seq, NLM_F_MULTI,
+						rdev, wpan_dev) < 0) {
+				goto out;
+			}
+			if_idx++;
+		}
+
+		wp_idx++;
+	}
+out:
+	rtnl_unlock();
+
+	cb->args[0] = wp_idx;
+	cb->args[1] = if_idx;
+
+	return skb->len;
+}
+
+static int nl802154_get_interface(struct sk_buff *skb, struct genl_info *info)
+{
+	struct sk_buff *msg;
+	struct cfg802154_registered_device *rdev = info->user_ptr[0];
+	struct wpan_dev *wdev = info->user_ptr[1];
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	if (nl802154_send_iface(msg, info->snd_portid, info->snd_seq, 0,
+				rdev, wdev) < 0) {
+		nlmsg_free(msg);
+		return -ENOBUFS;
+	}
+
+	return genlmsg_reply(msg, info);
+}
+
 #define NL802154_FLAG_NEED_WPAN_PHY	0x01
 #define NL802154_FLAG_NEED_NETDEV	0x02
 #define NL802154_FLAG_NEED_RTNL		0x04
@@ -515,6 +651,15 @@ static const struct genl_ops nl802154_ops[] = {
 		.internal_flags = NL802154_FLAG_NEED_WPAN_PHY |
 				  NL802154_FLAG_NEED_RTNL,
 	},
+	{
+		.cmd = NL802154_CMD_GET_INTERFACE,
+		.doit = nl802154_get_interface,
+		.dumpit = nl802154_dump_interface,
+		.policy = nl802154_policy,
+		/* can be retrieved by unprivileged users */
+		.internal_flags = NL802154_FLAG_NEED_WPAN_DEV |
+				  NL802154_FLAG_NEED_RTNL,
+	},
 };
 
 /* initialisation/exit functions */
-- 
2.1.3

