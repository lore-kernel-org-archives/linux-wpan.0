Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:65313 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbaJMIdZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 13 Oct 2014 04:33:25 -0400
Received: by mail-wg0-f50.google.com with SMTP id a1so8024032wgh.33
        for <linux-wpan@vger.kernel.org>; Mon, 13 Oct 2014 01:33:24 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/2] ieee802154: 6lowpan: improve packet registration
Date: Mon, 13 Oct 2014 10:33:06 +0200
Message-Id: <1413189187-27123-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch improves the packet registration handling. Instead of
registration with module init we have a open count variable and
registration the lowpan packet handler when it's needed.

The open count variable should be protected by RTNL.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan_rtnl.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index c7e07b8..da78fae 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -58,6 +58,7 @@
 #include "reassembly.h"
 
 static LIST_HEAD(lowpan_devices);
+static int lowpan_open_count;
 
 /* private device info */
 struct lowpan_dev_info {
@@ -571,11 +572,17 @@ drop:
 	return NET_RX_DROP;
 }
 
+static struct packet_type lowpan_packet_type = {
+	.type = htons(ETH_P_IEEE802154),
+	.func = lowpan_rcv,
+};
+
 static int lowpan_newlink(struct net *src_net, struct net_device *dev,
 			  struct nlattr *tb[], struct nlattr *data[])
 {
 	struct net_device *real_dev;
 	struct lowpan_dev_record *entry;
+	int ret;
 
 	pr_debug("adding new link\n");
 
@@ -610,9 +617,14 @@ static int lowpan_newlink(struct net *src_net, struct net_device *dev,
 	list_add_tail(&entry->list, &lowpan_devices);
 	mutex_unlock(&lowpan_dev_info(dev)->dev_list_mtx);
 
-	register_netdevice(dev);
+	ret = register_netdevice(dev);
+	if (ret >= 0) {
+		if (!lowpan_open_count)
+			dev_add_pack(&lowpan_packet_type);
+		lowpan_open_count++;
+	}
 
-	return 0;
+	return ret;
 }
 
 static void lowpan_dellink(struct net_device *dev, struct list_head *head)
@@ -623,6 +635,10 @@ static void lowpan_dellink(struct net_device *dev, struct list_head *head)
 
 	ASSERT_RTNL();
 
+	lowpan_open_count--;
+	if (!lowpan_open_count)
+		dev_remove_pack(&lowpan_packet_type);
+
 	mutex_lock(&lowpan_dev_info(dev)->dev_list_mtx);
 	list_for_each_entry_safe(entry, tmp, &lowpan_devices, list) {
 		if (entry->ldev == dev) {
@@ -685,11 +701,6 @@ static struct notifier_block lowpan_dev_notifier = {
 	.notifier_call = lowpan_device_event,
 };
 
-static struct packet_type lowpan_packet_type = {
-	.type = htons(ETH_P_IEEE802154),
-	.func = lowpan_rcv,
-};
-
 static int __init lowpan_init_module(void)
 {
 	int err = 0;
@@ -702,8 +713,6 @@ static int __init lowpan_init_module(void)
 	if (err < 0)
 		goto out_frag;
 
-	dev_add_pack(&lowpan_packet_type);
-
 	err = register_netdevice_notifier(&lowpan_dev_notifier);
 	if (err < 0)
 		goto out_pack;
@@ -711,7 +720,6 @@ static int __init lowpan_init_module(void)
 	return 0;
 
 out_pack:
-	dev_remove_pack(&lowpan_packet_type);
 	lowpan_netlink_fini();
 out_frag:
 	lowpan_net_frag_exit();
@@ -723,8 +731,6 @@ static void __exit lowpan_cleanup_module(void)
 {
 	lowpan_netlink_fini();
 
-	dev_remove_pack(&lowpan_packet_type);
-
 	lowpan_net_frag_exit();
 
 	unregister_netdevice_notifier(&lowpan_dev_notifier);
-- 
2.1.2

