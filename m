Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37151 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932259AbbHKToh (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Aug 2015 15:44:37 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/4] 6lowpan: add generic 6lowpan netdev private data
Date: Tue, 11 Aug 2015 21:44:08 +0200
Message-Id: <1439322250-32039-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1439322250-32039-1-git-send-email-alex.aring@gmail.com>
References: <1439322250-32039-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, lukasz.duda@nordicsemi.no, jukka.rissanen@linux.intel.com, Alexander Aring <alex.aring@gmail.com>

This patch introduced the 6lowpan netdev private data struct. We name it
lowpan_priv and it's placed at the beginning of netdev private data. All
lowpan interfaces should allocate this room at first of netdev private
data. 6LoWPAN LL private data can be allocate by additional netdev private
data, e.g. dev->priv_size should be "sizeof(struct lowpan_priv) +
sizeof(LL_LOWPAN_PRIVATE_DATA)".

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/6lowpan.h              | 23 +++++++++++++++++++++++
 net/6lowpan/Makefile               |  2 +-
 net/6lowpan/core.c                 | 20 ++++++++++++++++++++
 net/bluetooth/6lowpan.c            |  9 ++++++---
 net/ieee802154/6lowpan/6lowpan_i.h |  3 ++-
 net/ieee802154/6lowpan/core.c      |  4 +++-
 6 files changed, 55 insertions(+), 6 deletions(-)
 create mode 100644 net/6lowpan/core.c

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index dc03d77..a2f59ec 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -197,6 +197,27 @@
 #define LOWPAN_NHC_UDP_CS_P_11	0xF3 /* source & dest = 0xF0B + 4bit inline */
 #define LOWPAN_NHC_UDP_CS_C	0x04 /* checksum elided */
 
+#define LOWPAN_PRIV_SIZE(llpriv_size)	\
+	(sizeof(struct lowpan_priv) + llpriv_size)
+
+enum lowpan_lltypes {
+	LOWPAN_LLTYPE_BTLE,
+	LOWPAN_LLTYPE_IEEE802154,
+};
+
+struct lowpan_priv {
+	enum lowpan_lltypes lltype;
+
+	/* must be last */
+	u8 priv[0] __aligned(sizeof(void *));
+};
+
+static inline
+struct lowpan_priv *lowpan_priv(const struct net_device *dev)
+{
+	return netdev_priv(dev);
+}
+
 #ifdef DEBUG
 /* print data in line */
 static inline void raw_dump_inline(const char *caller, char *msg,
@@ -372,6 +393,8 @@ lowpan_uncompress_size(const struct sk_buff *skb, u16 *dgram_offset)
 	return skb->len + uncomp_header - ret;
 }
 
+void lowpan_netdev_setup(struct net_device *dev, enum lowpan_lltypes lltype);
+
 int
 lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
 			 const u8 *saddr, const u8 saddr_type,
diff --git a/net/6lowpan/Makefile b/net/6lowpan/Makefile
index eb8baa7..c6ffc55 100644
--- a/net/6lowpan/Makefile
+++ b/net/6lowpan/Makefile
@@ -1,6 +1,6 @@
 obj-$(CONFIG_6LOWPAN) += 6lowpan.o
 
-6lowpan-y := iphc.o nhc.o
+6lowpan-y := core.o iphc.o nhc.o
 
 #rfc6282 nhcs
 obj-$(CONFIG_6LOWPAN_NHC_DEST) += nhc_dest.o
diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
new file mode 100644
index 0000000..ed0eec9
--- /dev/null
+++ b/net/6lowpan/core.c
@@ -0,0 +1,20 @@
+/* This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Authors:
+ * (C) 2015 Pengutronix, Alexander Aring <aar@pengutronix.de>
+ */
+
+#include <net/6lowpan.h>
+
+void lowpan_netdev_setup(struct net_device *dev, enum lowpan_lltypes lltype)
+{
+	lowpan_priv(dev)->lltype = lltype;
+}
+EXPORT_SYMBOL(lowpan_netdev_setup);
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 24ed5b0..131e79c 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -85,7 +85,7 @@ struct lowpan_dev {
 
 static inline struct lowpan_dev *lowpan_dev(const struct net_device *netdev)
 {
-	return netdev_priv(netdev);
+	return (struct lowpan_dev *)lowpan_priv(netdev)->priv;
 }
 
 static inline void peer_add(struct lowpan_dev *dev, struct lowpan_peer *peer)
@@ -848,8 +848,9 @@ static int setup_netdev(struct l2cap_chan *chan, struct lowpan_dev **dev)
 	struct net_device *netdev;
 	int err = 0;
 
-	netdev = alloc_netdev(sizeof(struct lowpan_dev), IFACE_NAME_TEMPLATE,
-			      NET_NAME_UNKNOWN, netdev_setup);
+	netdev = alloc_netdev(LOWPAN_PRIV_SIZE(sizeof(struct lowpan_dev)),
+			      IFACE_NAME_TEMPLATE, NET_NAME_UNKNOWN,
+			      netdev_setup);
 	if (!netdev)
 		return -ENOMEM;
 
@@ -869,6 +870,8 @@ static int setup_netdev(struct l2cap_chan *chan, struct lowpan_dev **dev)
 	list_add_rcu(&(*dev)->list, &bt_6lowpan_devices);
 	spin_unlock(&devices_lock);
 
+	lowpan_netdev_setup(netdev, LOWPAN_LLTYPE_BTLE);
+
 	err = register_netdev(netdev);
 	if (err < 0) {
 		BT_INFO("register_netdev failed %d", err);
diff --git a/net/ieee802154/6lowpan/6lowpan_i.h b/net/ieee802154/6lowpan/6lowpan_i.h
index 923b680..ea339fa 100644
--- a/net/ieee802154/6lowpan/6lowpan_i.h
+++ b/net/ieee802154/6lowpan/6lowpan_i.h
@@ -5,6 +5,7 @@
 
 #include <net/ieee802154_netdev.h>
 #include <net/inet_frag.h>
+#include <net/6lowpan.h>
 
 struct lowpan_create_arg {
 	u16 tag;
@@ -46,7 +47,7 @@ struct lowpan_dev_info {
 static inline struct
 lowpan_dev_info *lowpan_dev_info(const struct net_device *dev)
 {
-	return netdev_priv(dev);
+	return (struct lowpan_dev_info *)lowpan_priv(dev)->priv;
 }
 
 int lowpan_frag_rcv(struct sk_buff *skb, const u8 frag_type);
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index a4edee8..180e9f5 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -138,6 +138,8 @@ static int lowpan_newlink(struct net *src_net, struct net_device *dev,
 	/* Set the lowpan hardware address to the wpan hardware address. */
 	memcpy(dev->dev_addr, real_dev->dev_addr, IEEE802154_ADDR_LEN);
 
+	lowpan_netdev_setup(dev, LOWPAN_LLTYPE_IEEE802154);
+
 	ret = register_netdevice(dev);
 	if (ret >= 0) {
 		real_dev->ieee802154_ptr->lowpan_dev = dev;
@@ -162,7 +164,7 @@ static void lowpan_dellink(struct net_device *dev, struct list_head *head)
 
 static struct rtnl_link_ops lowpan_link_ops __read_mostly = {
 	.kind		= "lowpan",
-	.priv_size	= sizeof(struct lowpan_dev_info),
+	.priv_size	= LOWPAN_PRIV_SIZE(sizeof(struct lowpan_dev_info)),
 	.setup		= lowpan_setup,
 	.newlink	= lowpan_newlink,
 	.dellink	= lowpan_dellink,
-- 
2.5.0

