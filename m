Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:60325 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbbHTKJ4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 20 Aug 2015 06:09:56 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH] nl802154: stricter input checking for boolean inputs
Date: Thu, 20 Aug 2015 12:09:47 +0200
Message-Id: <1440065387-7457-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

So far we handled boolean input by forcing them with !! and assigning
them into a bool. This allowed userspace to send values > 1 which were
used as 1. We should be stricter here and return -EINVAL for all but
0 or 1.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 net/ieee802154/nl802154.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 1b00a14..3f89c0a 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -1034,7 +1034,7 @@ static int nl802154_set_lbt_mode(struct sk_buff *skb, struct genl_info *info)
 	struct cfg802154_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
 	struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
-	bool mode;
+	int mode;
 
 	if (netif_running(dev))
 		return -EBUSY;
@@ -1042,7 +1042,11 @@ static int nl802154_set_lbt_mode(struct sk_buff *skb, struct genl_info *info)
 	if (!info->attrs[NL802154_ATTR_LBT_MODE])
 		return -EINVAL;
 
-	mode = !!nla_get_u8(info->attrs[NL802154_ATTR_LBT_MODE]);
+	mode = nla_get_u8(info->attrs[NL802154_ATTR_LBT_MODE]);
+
+	if (mode != 0 && mode != 1)
+		return -EINVAL;
+
 	if (!wpan_phy_supported_bool(mode, rdev->wpan_phy.supported.lbt))
 		return -EINVAL;
 
@@ -1055,7 +1059,7 @@ nl802154_set_ackreq_default(struct sk_buff *skb, struct genl_info *info)
 	struct cfg802154_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
 	struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
-	bool ackreq;
+	int ackreq;
 
 	if (netif_running(dev))
 		return -EBUSY;
@@ -1063,7 +1067,11 @@ nl802154_set_ackreq_default(struct sk_buff *skb, struct genl_info *info)
 	if (!info->attrs[NL802154_ATTR_ACKREQ_DEFAULT])
 		return -EINVAL;
 
-	ackreq = !!nla_get_u8(info->attrs[NL802154_ATTR_ACKREQ_DEFAULT]);
+	ackreq = nla_get_u8(info->attrs[NL802154_ATTR_ACKREQ_DEFAULT]);
+
+	if (ackreq != 0 && ackreq != 1)
+		return -EINVAL;
+
 	return rdev_set_ackreq_default(rdev, wpan_dev, ackreq);
 }
 
-- 
2.4.3

