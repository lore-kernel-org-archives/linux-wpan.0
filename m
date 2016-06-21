Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:45038 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752485AbcFUOrJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 21 Jun 2016 10:47:09 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC bluetooth-next] 6lowpan: add debugfs to get lltype
Date: Tue, 21 Jun 2016 16:46:56 +0200
Message-Id: <20160621144656.32469-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de, patrik.flykt@linux.intel.com, jukka.rissanen@linux.intel.com, Alexander Aring <aar@pengutronix.de>

This patch adds debugfs entry for get the link layer type for userspace.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
Patrik,

after changing the dev->addr_len = 6 in btle 6lowpan. I think you should
add this patch to the end of your patch series. Then a "recent" radvd will use
the correct hardware address length.

 net/6lowpan/debugfs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/6lowpan/debugfs.c b/net/6lowpan/debugfs.c
index 24915e0..25bed7a 100644
--- a/net/6lowpan/debugfs.c
+++ b/net/6lowpan/debugfs.c
@@ -280,6 +280,19 @@ static int lowpan_dev_debugfs_802154_init(const struct net_device *dev,
 	return 0;
 }
 
+static int lowpan_lltype_get(void *data, u64 *val)
+{
+	struct lowpan_dev *ldev = data;
+
+	rtnl_lock();
+	*val = ldev->lltype;
+	rtnl_unlock();
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(lowpan_lltype_fops, lowpan_lltype_get, NULL, "%llu\n");
+
 int lowpan_dev_debugfs_init(struct net_device *dev)
 {
 	struct lowpan_dev *ldev = lowpan_dev(dev);
@@ -291,6 +304,11 @@ int lowpan_dev_debugfs_init(struct net_device *dev)
 	if (!ldev->iface_debugfs)
 		goto fail;
 
+	dentry = debugfs_create_file("lltype", 0444, ldev->iface_debugfs,
+				     lowpan_dev(dev), &lowpan_lltype_fops);
+	if (!dentry)
+		goto remove_root;
+
 	contexts = debugfs_create_dir("contexts", ldev->iface_debugfs);
 	if (!contexts)
 		goto remove_root;
-- 
2.9.0

