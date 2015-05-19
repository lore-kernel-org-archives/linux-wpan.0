Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:50610 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbbEST4h (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 May 2015 15:56:37 -0400
Date: Tue, 19 May 2015 22:50:11 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCH 5/8] ieee802154 6lowpan: Don't implement ieee802154_mlme_ops.
Message-ID: <20150519195011.GQ11014@wantstofly.org>
References: <cover.1432064518.git.buytenh@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1432064518.git.buytenh@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

ieee802154_mlme_ops are implemented only by ARPHRD_IEEE802154
devices.

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
---
 net/ieee802154/6lowpan/core.c | 28 ----------------------------
 net/ieee802154/6lowpan/tx.c   |  7 ++++---
 2 files changed, 4 insertions(+), 31 deletions(-)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 0ae5822..f20a387 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -55,27 +55,6 @@
 LIST_HEAD(lowpan_devices);
 static int lowpan_open_count;
 
-static __le16 lowpan_get_pan_id(const struct net_device *dev)
-{
-	struct net_device *real_dev = lowpan_dev_info(dev)->real_dev;
-
-	return ieee802154_mlme_ops(real_dev)->get_pan_id(real_dev);
-}
-
-static __le16 lowpan_get_short_addr(const struct net_device *dev)
-{
-	struct net_device *real_dev = lowpan_dev_info(dev)->real_dev;
-
-	return ieee802154_mlme_ops(real_dev)->get_short_addr(real_dev);
-}
-
-static u8 lowpan_get_dsn(const struct net_device *dev)
-{
-	struct net_device *real_dev = lowpan_dev_info(dev)->real_dev;
-
-	return ieee802154_mlme_ops(real_dev)->get_dsn(real_dev);
-}
-
 static struct header_ops lowpan_header_ops = {
 	.create	= lowpan_header_create,
 };
@@ -103,12 +82,6 @@ static const struct net_device_ops lowpan_netdev_ops = {
 	.ndo_start_xmit		= lowpan_xmit,
 };
 
-static struct ieee802154_mlme_ops lowpan_mlme = {
-	.get_pan_id = lowpan_get_pan_id,
-	.get_short_addr = lowpan_get_short_addr,
-	.get_dsn = lowpan_get_dsn,
-};
-
 static void lowpan_setup(struct net_device *dev)
 {
 	dev->addr_len		= IEEE802154_ADDR_LEN;
@@ -124,7 +97,6 @@ static void lowpan_setup(struct net_device *dev)
 
 	dev->netdev_ops		= &lowpan_netdev_ops;
 	dev->header_ops		= &lowpan_header_ops;
-	dev->ml_priv		= &lowpan_mlme;
 	dev->destructor		= free_netdev;
 	dev->features		|= NETIF_F_NETNS_LOCAL;
 }
diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index 2349070..754e1df 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -190,6 +190,7 @@ err:
 
 static int lowpan_header(struct sk_buff *skb, struct net_device *dev)
 {
+	struct net_device *real_dev = lowpan_dev_info(dev)->real_dev;
 	struct ieee802154_addr sa, da;
 	struct ieee802154_mac_cb *cb = mac_cb_init(skb);
 	struct lowpan_addr_info info;
@@ -207,7 +208,7 @@ static int lowpan_header(struct sk_buff *skb, struct net_device *dev)
 
 	/* prepare wpan address data */
 	sa.mode = IEEE802154_ADDR_LONG;
-	sa.pan_id = ieee802154_mlme_ops(dev)->get_pan_id(dev);
+	sa.pan_id = ieee802154_mlme_ops(real_dev)->get_pan_id(real_dev);
 	sa.extended_addr = ieee802154_devaddr_from_raw(saddr);
 
 	/* intra-PAN communications */
@@ -226,8 +227,8 @@ static int lowpan_header(struct sk_buff *skb, struct net_device *dev)
 		cb->ackreq = true;
 	}
 
-	return dev_hard_header(skb, lowpan_dev_info(dev)->real_dev,
-			ETH_P_IPV6, (void *)&da, (void *)&sa, 0);
+	return dev_hard_header(skb, real_dev, ETH_P_IPV6,
+				(void *)&da, (void *)&sa, 0);
 }
 
 netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *dev)
-- 
2.1.0

