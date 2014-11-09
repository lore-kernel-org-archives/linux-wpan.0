Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:44671 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbaKIHhf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 9 Nov 2014 02:37:35 -0500
Received: by mail-wg0-f49.google.com with SMTP id x13so6522779wgg.22
        for <linux-wpan@vger.kernel.org>; Sat, 08 Nov 2014 23:37:34 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 10/15] ieee802154: add wpan_phy dump support
Date: Sun,  9 Nov 2014 08:36:54 +0100
Message-Id: <1415518619-4370-11-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
References: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for dumping wpan_phy attributes via nl802154.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/core.c     |   2 +-
 net/ieee802154/core.h     |   1 +
 net/ieee802154/nl802154.c | 221 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 223 insertions(+), 1 deletion(-)

diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index ae5ecbc..18bc7e7 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -27,7 +27,7 @@
 
 /* RCU-protected (and RTNL for writers) */
 LIST_HEAD(cfg802154_rdev_list);
-static int cfg802154_rdev_list_generation;
+int cfg802154_rdev_list_generation;
 
 static int wpan_phy_match(struct device *dev, const void *data)
 {
diff --git a/net/ieee802154/core.h b/net/ieee802154/core.h
index c8319bf..f3e9558 100644
--- a/net/ieee802154/core.h
+++ b/net/ieee802154/core.h
@@ -36,6 +36,7 @@ wpan_phy_to_rdev(struct wpan_phy *wpan_phy)
 }
 
 extern struct list_head cfg802154_rdev_list;
+extern int cfg802154_rdev_list_generation;
 
 /* free object */
 void cfg802154_dev_free(struct cfg802154_registered_device *rdev);
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 5dec0bb..32e8847 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -193,6 +193,22 @@ cfg802154_get_dev_from_info(struct net *netns, struct genl_info *info)
 
 /* policy for the attributes */
 static const struct nla_policy nl802154_policy[NL802154_ATTR_MAX+1] = {
+	[NL802154_ATTR_WPAN_PHY] = { .type = NLA_U32 },
+	[NL802154_ATTR_WPAN_PHY_NAME] = { .type = NLA_NUL_STRING,
+					  .len = 20-1 },
+
+	[NL802154_ATTR_IFINDEX] = { .type = NLA_U32 },
+
+	[NL802154_ATTR_WPAN_DEV] = { .type = NLA_U64 },
+
+	[NL802154_ATTR_PAGE] = { .type = NLA_U8, },
+	[NL802154_ATTR_CHANNEL] = { .type = NLA_U8, },
+
+	[NL802154_ATTR_TX_POWER] = { .type = NLA_S8, },
+
+	[NL802154_ATTR_CCA_MODE] = { .type = NLA_U8, },
+
+	[NL802154_ATTR_SUPPORTED_CHANNEL] = { .type = NLA_U32, },
 };
 
 /* message building helper */
@@ -203,6 +219,201 @@ static inline void *nl802154hdr_put(struct sk_buff *skb, u32 portid, u32 seq,
 	return genlmsg_put(skb, portid, seq, &nl802154_fam, flags, cmd);
 }
 
+static int
+nl802154_send_wpan_phy_channels(struct cfg802154_registered_device *rdev,
+				struct sk_buff *msg)
+{
+	struct nlattr *nl_page;
+	unsigned long page;
+
+	nl_page = nla_nest_start(msg, NL802154_ATTR_CHANNELS_SUPPORTED);
+	if (!nl_page)
+		return -ENOBUFS;
+
+	for (page = 0; page < WPAN_NUM_PAGES; page++) {
+		if (nla_put_u32(msg, NL802154_ATTR_SUPPORTED_CHANNEL,
+				rdev->wpan_phy.channels_supported[page]))
+			return -ENOBUFS;
+	}
+	nla_nest_end(msg, nl_page);
+
+	return 0;
+}
+
+static int nl802154_send_wpan_phy(struct cfg802154_registered_device *rdev,
+				  enum nl802154_commands cmd,
+				  struct sk_buff *msg, u32 portid, u32 seq,
+				  int flags)
+{
+	void *hdr;
+
+	hdr = nl802154hdr_put(msg, portid, seq, flags, cmd);
+	if (!hdr)
+		return -ENOBUFS;
+
+	if (nla_put_u32(msg, NL802154_ATTR_WPAN_PHY, rdev->wpan_phy_idx) ||
+	    nla_put_string(msg, NL802154_ATTR_WPAN_PHY_NAME,
+			   wpan_phy_name(&rdev->wpan_phy)) ||
+	    nla_put_u32(msg, NL802154_ATTR_GENERATION,
+			cfg802154_rdev_list_generation))
+		goto nla_put_failure;
+
+	if (cmd != NL802154_CMD_NEW_WPAN_PHY)
+		goto finish;
+
+	/* DUMP PHY PIB */
+
+	/* current channel settings */
+	if (nla_put_u8(msg, NL802154_ATTR_PAGE,
+		       rdev->wpan_phy.current_page) ||
+	    nla_put_u8(msg, NL802154_ATTR_CHANNEL,
+		       rdev->wpan_phy.current_channel))
+		goto nla_put_failure;
+
+	/* supported channels array */
+	if (nl802154_send_wpan_phy_channels(rdev, msg))
+		goto nla_put_failure;
+
+	/* cca mode */
+	if (nla_put_u8(msg, NL802154_ATTR_CCA_MODE,
+		       rdev->wpan_phy.cca_mode))
+		goto nla_put_failure;
+
+	if (nla_put_s8(msg, NL802154_ATTR_TX_POWER,
+		       rdev->wpan_phy.transmit_power))
+		goto nla_put_failure;
+
+finish:
+	return genlmsg_end(msg, hdr);
+
+nla_put_failure:
+	genlmsg_cancel(msg, hdr);
+	return -EMSGSIZE;
+}
+
+struct nl802154_dump_wpan_phy_state {
+	s64 filter_wpan_phy;
+	long start;
+
+};
+
+static int nl802154_dump_wpan_phy_parse(struct sk_buff *skb,
+					struct netlink_callback *cb,
+					struct nl802154_dump_wpan_phy_state *state)
+{
+	struct nlattr **tb = nl802154_fam.attrbuf;
+	int ret = nlmsg_parse(cb->nlh, GENL_HDRLEN + nl802154_fam.hdrsize,
+			      tb, nl802154_fam.maxattr, nl802154_policy);
+
+	/* TODO check if we can handle error here,
+	 * we have no backward compatibility
+	 */
+	if (ret)
+		return 0;
+
+	if (tb[NL802154_ATTR_WPAN_PHY])
+		state->filter_wpan_phy = nla_get_u32(tb[NL802154_ATTR_WPAN_PHY]);
+	if (tb[NL802154_ATTR_WPAN_DEV])
+		state->filter_wpan_phy = nla_get_u64(tb[NL802154_ATTR_WPAN_DEV]) >> 32;
+	if (tb[NL802154_ATTR_IFINDEX]) {
+		struct net_device *netdev;
+		struct cfg802154_registered_device *rdev;
+		int ifidx = nla_get_u32(tb[NL802154_ATTR_IFINDEX]);
+
+		/* TODO netns */
+		netdev = __dev_get_by_index(&init_net, ifidx);
+		if (!netdev)
+			return -ENODEV;
+		if (netdev->ieee802154_ptr) {
+			rdev = wpan_phy_to_rdev(
+					netdev->ieee802154_ptr->wpan_phy);
+			state->filter_wpan_phy = rdev->wpan_phy_idx;
+		}
+	}
+
+	return 0;
+}
+
+static int
+nl802154_dump_wpan_phy(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	int idx = 0, ret;
+	struct nl802154_dump_wpan_phy_state *state = (void *)cb->args[0];
+	struct cfg802154_registered_device *rdev;
+
+	rtnl_lock();
+	if (!state) {
+		state = kzalloc(sizeof(*state), GFP_KERNEL);
+		if (!state) {
+			rtnl_unlock();
+			return -ENOMEM;
+		}
+		state->filter_wpan_phy = -1;
+		ret = nl802154_dump_wpan_phy_parse(skb, cb, state);
+		if (ret) {
+			kfree(state);
+			rtnl_unlock();
+			return ret;
+		}
+		cb->args[0] = (long)state;
+	}
+
+	list_for_each_entry(rdev, &cfg802154_rdev_list, list) {
+		/* TODO net ns compare */
+		if (++idx <= state->start)
+			continue;
+		if (state->filter_wpan_phy != -1 &&
+		    state->filter_wpan_phy != rdev->wpan_phy_idx)
+			continue;
+		/* attempt to fit multiple wpan_phy data chunks into the skb */
+		ret = nl802154_send_wpan_phy(rdev,
+					     NL802154_CMD_NEW_WPAN_PHY,
+					     skb,
+					     NETLINK_CB(cb->skb).portid,
+					     cb->nlh->nlmsg_seq, NLM_F_MULTI);
+		if (ret < 0) {
+			if ((ret == -ENOBUFS || ret == -EMSGSIZE) &&
+			    !skb->len && cb->min_dump_alloc < 4096) {
+				cb->min_dump_alloc = 4096;
+				rtnl_unlock();
+				return 1;
+			}
+			idx--;
+			break;
+		}
+		break;
+	}
+	rtnl_unlock();
+
+	state->start = idx;
+
+	return skb->len;
+}
+
+static int nl802154_dump_wpan_phy_done(struct netlink_callback *cb)
+{
+	kfree((void *)cb->args[0]);
+	return 0;
+}
+
+static int nl802154_get_wpan_phy(struct sk_buff *skb, struct genl_info *info)
+{
+	struct sk_buff *msg;
+	struct cfg802154_registered_device *rdev = info->user_ptr[0];
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	if (nl802154_send_wpan_phy(rdev, NL802154_CMD_NEW_WPAN_PHY, msg,
+				   info->snd_portid, info->snd_seq, 0) < 0) {
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
@@ -294,6 +505,16 @@ static void nl802154_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
 }
 
 static const struct genl_ops nl802154_ops[] = {
+	{
+		.cmd = NL802154_CMD_GET_WPAN_PHY,
+		.doit = nl802154_get_wpan_phy,
+		.dumpit = nl802154_dump_wpan_phy,
+		.done = nl802154_dump_wpan_phy_done,
+		.policy = nl802154_policy,
+		/* can be retrieved by unprivileged users */
+		.internal_flags = NL802154_FLAG_NEED_WPAN_PHY |
+				  NL802154_FLAG_NEED_RTNL,
+	},
 };
 
 /* initialisation/exit functions */
-- 
2.1.3

