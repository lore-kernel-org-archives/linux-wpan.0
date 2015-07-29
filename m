Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35767 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbbG2MYp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Jul 2015 08:24:45 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 2/2] 6lowpan: add generic 6lowpan netdev private data
Date: Wed, 29 Jul 2015 14:24:34 +0200
Message-Id: <1438172674-31028-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1438172674-31028-1-git-send-email-alex.aring@gmail.com>
References: <1438172674-31028-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, lukasz.duda@nordicsemi.no, Alexander Aring <alex.aring@gmail.com>

This patch introduced the 6lowpan netdev private data struct. We name it
lowpan_priv and it's placed at the beginning of netdev private data. All
lowpan interfaces should allocate this room at first of netdev private
data. 6LoWPAN L2 private data can be allocate by additional netdev private
data, e.g. dev->priv_size should be "sizeof(struct lowpan_priv) +
sizeof(L2_LOWPAN_PRIVATE_DATA)".

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/6lowpan.h              | 18 ++++++++++++++++++
 net/bluetooth/6lowpan.c            |  7 +++++--
 net/ieee802154/6lowpan/6lowpan_i.h |  3 ++-
 net/ieee802154/6lowpan/core.c      |  5 ++++-
 4 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index dc03d77..7fe7665 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -197,6 +197,24 @@
 #define LOWPAN_NHC_UDP_CS_P_11	0xF3 /* source & dest = 0xF0B + 4bit inline */
 #define LOWPAN_NHC_UDP_CS_C	0x04 /* checksum elided */
 
+enum lowpan_l2_types {
+	LOWPAN_L2_TYPE_BTLE,
+	LOWPAN_L2_TYPE_IEEE802154,
+};
+
+struct lowpan_priv {
+	enum lowpan_l2_types l2_type;
+
+	/* must be last */
+	u8 priv[0] __aligned(sizeof(void *));
+};
+
+static inline
+struct lowpan_priv *lowpan_priv(const struct net_device *dev)
+{
+	return ((struct lowpan_priv *)netdev_priv(dev));
+}
+
 #ifdef DEBUG
 /* print data in line */
 static inline void raw_dump_inline(const char *caller, char *msg,
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 93c6ba0..ff14760 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -85,7 +85,7 @@ struct lowpan_dev {
 
 static inline struct lowpan_dev *lowpan_dev(const struct net_device *netdev)
 {
-	return netdev_priv(netdev);
+	return (struct lowpan_dev *)lowpan_priv(netdev)->priv;
 }
 
 static inline void peer_add(struct lowpan_dev *dev, struct lowpan_peer *peer)
@@ -848,7 +848,8 @@ static int setup_netdev(struct l2cap_chan *chan, struct lowpan_dev **dev)
 	struct net_device *netdev;
 	int err = 0;
 
-	netdev = alloc_netdev(sizeof(struct lowpan_dev), IFACE_NAME_TEMPLATE,
+	netdev = alloc_netdev(sizeof(struct lowpan_priv) +
+			      sizeof(struct lowpan_dev), IFACE_NAME_TEMPLATE,
 			      NET_NAME_UNKNOWN, netdev_setup);
 	if (!netdev)
 		return -ENOMEM;
@@ -859,6 +860,8 @@ static int setup_netdev(struct l2cap_chan *chan, struct lowpan_dev **dev)
 	SET_NETDEV_DEV(netdev, &chan->conn->hcon->hdev->dev);
 	SET_NETDEV_DEVTYPE(netdev, &bt_type);
 
+	lowpan_priv(netdev)->l2_type = LOWPAN_L2_TYPE_BTLE;
+
 	err = register_netdev(netdev);
 	if (err < 0) {
 		BT_INFO("register_netdev failed %d", err);
diff --git a/net/ieee802154/6lowpan/6lowpan_i.h b/net/ieee802154/6lowpan/6lowpan_i.h
index e50f69d..0dd4e46 100644
--- a/net/ieee802154/6lowpan/6lowpan_i.h
+++ b/net/ieee802154/6lowpan/6lowpan_i.h
@@ -5,6 +5,7 @@
 
 #include <net/ieee802154_netdev.h>
 #include <net/inet_frag.h>
+#include <net/6lowpan.h>
 
 struct lowpan_create_arg {
 	u16 tag;
@@ -52,7 +53,7 @@ struct lowpan_dev_info {
 static inline struct
 lowpan_dev_info *lowpan_dev_info(const struct net_device *dev)
 {
-	return netdev_priv(dev);
+	return (struct lowpan_dev_info *)lowpan_priv(dev)->priv;
 }
 
 extern struct list_head lowpan_devices;
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index f20a387..21c9380 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -153,6 +153,8 @@ static int lowpan_newlink(struct net *src_net, struct net_device *dev,
 	list_add_tail(&entry->list, &lowpan_devices);
 	mutex_unlock(&lowpan_dev_info(dev)->dev_list_mtx);
 
+	lowpan_priv(dev)->l2_type = LOWPAN_L2_TYPE_IEEE802154;
+
 	ret = register_netdevice(dev);
 	if (ret >= 0) {
 		if (!lowpan_open_count)
@@ -193,7 +195,8 @@ static void lowpan_dellink(struct net_device *dev, struct list_head *head)
 
 static struct rtnl_link_ops lowpan_link_ops __read_mostly = {
 	.kind		= "lowpan",
-	.priv_size	= sizeof(struct lowpan_dev_info),
+	.priv_size	= sizeof(struct lowpan_priv) +
+			  sizeof(struct lowpan_dev_info),
 	.setup		= lowpan_setup,
 	.newlink	= lowpan_newlink,
 	.dellink	= lowpan_dellink,
-- 
2.5.0

