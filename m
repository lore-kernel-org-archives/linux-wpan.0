Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35453 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541AbbJBS2R (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 2 Oct 2015 14:28:17 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] 6lowpan: move shared settings to lowpan_netdev_setup
Date: Fri,  2 Oct 2015 20:28:04 +0200
Message-Id: <1443810484-10528-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>

This patch moves values for all lowpan interface to the shared
implementation of 6lowpan. This patch also quietly fixes the forgotten
IFF_NO_QUEUE flag for the bluetooth 6LoWPAN interface. An identically
commit is 4afbc0d ("net: 6lowpan: convert to using IFF_NO_QUEUE") which
wasn't changed for bluetooth 6lowpan.

All 6lowpan interfaces should be virtual with IFF_NO_QUEUE, using EUI64
address length, the mtu size is 1280 (IPV6_MIN_MTU) and the netdev type
is ARPHRD_6LOWPAN.

Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/6lowpan.h         | 2 ++
 net/6lowpan/core.c            | 5 +++++
 net/bluetooth/6lowpan.c       | 6 ------
 net/ieee802154/6lowpan/core.c | 4 ----
 4 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
index c17f556..07db532 100644
--- a/include/net/6lowpan.h
+++ b/include/net/6lowpan.h
@@ -61,6 +61,8 @@
 #define UIP_PROTO_UDP			17 /* ipv6 next header value for UDP */
 #define UIP_FRAGH_LEN			8  /* ipv6 fragment header size */
 
+#define EUI64_ADDR_LEN		8
+
 #define LOWPAN_NHC_MAX_ID_LEN	1
 /* Max IPHC Header len without IPv6 hdr specific inline data.
  * Useful for getting the "extra" bytes we need at worst case compression.
diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
index ae1896f..83b19e0 100644
--- a/net/6lowpan/core.c
+++ b/net/6lowpan/core.c
@@ -17,6 +17,11 @@
 
 void lowpan_netdev_setup(struct net_device *dev, enum lowpan_lltypes lltype)
 {
+	dev->addr_len = EUI64_ADDR_LEN;
+	dev->type = ARPHRD_6LOWPAN;
+	dev->mtu = IPV6_MIN_MTU;
+	dev->priv_flags |= IFF_NO_QUEUE;
+
 	lowpan_priv(dev)->lltype = lltype;
 }
 EXPORT_SYMBOL(lowpan_netdev_setup);
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 131e79c..bc840a5 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -35,7 +35,6 @@ static struct dentry *lowpan_enable_debugfs;
 static struct dentry *lowpan_control_debugfs;
 
 #define IFACE_NAME_TEMPLATE "bt%d"
-#define EUI64_ADDR_LEN 8
 
 struct skb_cb {
 	struct in6_addr addr;
@@ -674,13 +673,8 @@ static struct header_ops header_ops = {
 
 static void netdev_setup(struct net_device *dev)
 {
-	dev->addr_len		= EUI64_ADDR_LEN;
-	dev->type		= ARPHRD_6LOWPAN;
-
 	dev->hard_header_len	= 0;
 	dev->needed_tailroom	= 0;
-	dev->mtu		= IPV6_MIN_MTU;
-	dev->tx_queue_len	= 0;
 	dev->flags		= IFF_RUNNING | IFF_POINTOPOINT |
 				  IFF_MULTICAST;
 	dev->watchdog_timeo	= 0;
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 44420ed..20c49c7 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -101,13 +101,9 @@ static const struct net_device_ops lowpan_netdev_ops = {
 
 static void lowpan_setup(struct net_device *ldev)
 {
-	ldev->addr_len		= IEEE802154_ADDR_LEN;
 	memset(ldev->broadcast, 0xff, IEEE802154_ADDR_LEN);
-	ldev->type		= ARPHRD_6LOWPAN;
 	/* We need an ipv6hdr as minimum len when calling xmit */
 	ldev->hard_header_len	= sizeof(struct ipv6hdr);
-	ldev->mtu		= IPV6_MIN_MTU;
-	ldev->priv_flags	|= IFF_NO_QUEUE;
 	ldev->flags		= IFF_BROADCAST | IFF_MULTICAST;
 
 	ldev->netdev_ops	= &lowpan_netdev_ops;
-- 
2.6.0

