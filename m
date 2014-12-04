Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:33588 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176AbaLDK6Q (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Dec 2014 05:58:16 -0500
From: Stefan Schmidt <s.schmidt@samsung.com>
Subject: [PATCH bluetooth-next 3/5] net/ieee802154: Remove and add extra blank lines as needed.
Date: Thu,  4 Dec 2014 11:51:59 +0100
Message-Id: <1417690321-19450-3-git-send-email-s.schmidt@samsung.com>
In-Reply-To: <1417690321-19450-1-git-send-email-s.schmidt@samsung.com>
References: <1417690321-19450-1-git-send-email-s.schmidt@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>

Some have been missing and some have been needed. Just cosmetics.

Signed-off-by: Stefan Schmidt <s.schmidt@samsung.com>
---
 net/ieee802154/6lowpan_rtnl.c  |  1 -
 net/ieee802154/af_ieee802154.c |  4 ++--
 net/ieee802154/dgram.c         |  1 -
 net/ieee802154/netlink.c       |  1 -
 net/ieee802154/nl-mac.c        | 14 --------------
 net/ieee802154/nl-phy.c        |  1 -
 net/ieee802154/raw.c           |  1 -
 7 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index 16f5e91..27eaa65 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -439,7 +439,6 @@ static void lowpan_set_lockdep_class_one(struct net_device *dev,
 			  &lowpan_netdev_xmit_lock_key);
 }
 
-
 static int lowpan_dev_init(struct net_device *dev)
 {
 	netdev_for_each_tx_queue(dev, lowpan_set_lockdep_class_one, NULL);
diff --git a/net/ieee802154/af_ieee802154.c b/net/ieee802154/af_ieee802154.c
index 26da1e1..d0a1282 100644
--- a/net/ieee802154/af_ieee802154.c
+++ b/net/ieee802154/af_ieee802154.c
@@ -99,6 +99,7 @@ static int ieee802154_sock_release(struct socket *sock)
 	}
 	return 0;
 }
+
 static int ieee802154_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 				   struct msghdr *msg, size_t len)
 {
@@ -231,7 +232,6 @@ static const struct proto_ops ieee802154_dgram_ops = {
 #endif
 };
 
-
 /* Create a socket. Initialise the socket, blank the addresses
  * set the state.
  */
@@ -320,7 +320,6 @@ drop:
 	return NET_RX_DROP;
 }
 
-
 static struct packet_type ieee802154_packet_type = {
 	.type = htons(ETH_P_IEEE802154),
 	.func = ieee802154_rcv,
@@ -354,6 +353,7 @@ err_dgram:
 out:
 	return rc;
 }
+
 static void __exit af_ieee802154_remove(void)
 {
 	dev_remove_pack(&ieee802154_packet_type);
diff --git a/net/ieee802154/dgram.c b/net/ieee802154/dgram.c
index 3d58bef..8db240b 100644
--- a/net/ieee802154/dgram.c
+++ b/net/ieee802154/dgram.c
@@ -154,7 +154,6 @@ static int dgram_ioctl(struct sock *sk, int cmd, unsigned long arg)
 		spin_unlock_bh(&sk->sk_receive_queue.lock);
 		return put_user(amount, (int __user *)arg);
 	}
-
 	}
 
 	return -ENOIOCTLCMD;
diff --git a/net/ieee802154/netlink.c b/net/ieee802154/netlink.c
index 3cdfa78..fa14647 100644
--- a/net/ieee802154/netlink.c
+++ b/net/ieee802154/netlink.c
@@ -147,7 +147,6 @@ static const struct genl_multicast_group ieee802154_mcgrps[] = {
 	[IEEE802154_BEACON_MCGRP] = { .name = IEEE802154_MCAST_BEACON_NAME, },
 };
 
-
 int __init ieee802154_nl_init(void)
 {
 	return genl_register_family_with_ops_groups(&nl802154_family,
diff --git a/net/ieee802154/nl-mac.c b/net/ieee802154/nl-mac.c
index 1f085ed..cd91949 100644
--- a/net/ieee802154/nl-mac.c
+++ b/net/ieee802154/nl-mac.c
@@ -346,7 +346,6 @@ int ieee802154_start_req(struct sk_buff *skb, struct genl_info *info)
 	else
 		page = 0;
 
-
 	if (addr.short_addr == cpu_to_le16(IEEE802154_ADDR_BROADCAST)) {
 		ieee802154_nl_start_confirm(dev, IEEE802154_NO_SHORT_ADDRESS);
 		dev_put(dev);
@@ -397,7 +396,6 @@ int ieee802154_scan_req(struct sk_buff *skb, struct genl_info *info)
 	else
 		page = 0;
 
-
 	ret = ieee802154_mlme_ops(dev)->scan_req(dev, type, channels,
 						 page, duration);
 
@@ -548,8 +546,6 @@ out:
 	return rc;
 }
 
-
-
 static int
 ieee802154_llsec_parse_key_id(struct genl_info *info,
 			      struct ieee802154_llsec_key_id *desc)
@@ -765,8 +761,6 @@ out:
 	return rc;
 }
 
-
-
 struct llsec_dump_data {
 	struct sk_buff *skb;
 	int s_idx, s_idx2;
@@ -843,8 +837,6 @@ ieee802154_nl_llsec_change(struct sk_buff *skb, struct genl_info *info,
 	return rc;
 }
 
-
-
 static int
 ieee802154_llsec_parse_key(struct genl_info *info,
 			   struct ieee802154_llsec_key *key)
@@ -989,8 +981,6 @@ int ieee802154_llsec_dump_keys(struct sk_buff *skb, struct netlink_callback *cb)
 	return ieee802154_llsec_dump_table(skb, cb, llsec_iter_keys);
 }
 
-
-
 static int
 llsec_parse_dev(struct genl_info *info,
 		struct ieee802154_llsec_device *dev)
@@ -1121,8 +1111,6 @@ int ieee802154_llsec_dump_devs(struct sk_buff *skb, struct netlink_callback *cb)
 	return ieee802154_llsec_dump_table(skb, cb, llsec_iter_devs);
 }
 
-
-
 static int llsec_add_devkey(struct net_device *dev, struct genl_info *info)
 {
 	struct ieee802154_mlme_ops *ops = ieee802154_mlme_ops(dev);
@@ -1237,8 +1225,6 @@ int ieee802154_llsec_dump_devkeys(struct sk_buff *skb,
 	return ieee802154_llsec_dump_table(skb, cb, llsec_iter_devkeys);
 }
 
-
-
 static int
 llsec_parse_seclevel(struct genl_info *info,
 		     struct ieee802154_llsec_seclevel *sl)
diff --git a/net/ieee802154/nl-phy.c b/net/ieee802154/nl-phy.c
index 6246354..7baf98b 100644
--- a/net/ieee802154/nl-phy.c
+++ b/net/ieee802154/nl-phy.c
@@ -94,7 +94,6 @@ int ieee802154_list_phy(struct sk_buff *skb, struct genl_info *info)
 	if (name[nla_len(info->attrs[IEEE802154_ATTR_PHY_NAME]) - 1] != '\0')
 		return -EINVAL; /* phy name should be null-terminated */
 
-
 	phy = wpan_phy_find(name);
 	if (!phy)
 		return -ENODEV;
diff --git a/net/ieee802154/raw.c b/net/ieee802154/raw.c
index 3ffcf4a..f0c61e5 100644
--- a/net/ieee802154/raw.c
+++ b/net/ieee802154/raw.c
@@ -221,7 +221,6 @@ static int raw_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	return NET_RX_SUCCESS;
 }
 
-
 void ieee802154_raw_deliver(struct net_device *dev, struct sk_buff *skb)
 {
 	struct sock *sk;
-- 
1.9.3

