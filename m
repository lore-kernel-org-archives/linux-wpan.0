Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:52034 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbaKQHVi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 17 Nov 2014 02:21:38 -0500
Received: by mail-wi0-f182.google.com with SMTP id h11so8055543wiw.3
        for <linux-wpan@vger.kernel.org>; Sun, 16 Nov 2014 23:21:36 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 13/13] ieee802154: fix byteorder for short address and panid
Date: Mon, 17 Nov 2014 08:20:55 +0100
Message-Id: <1416208855-8623-14-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1416208855-8623-1-git-send-email-alex.aring@gmail.com>
References: <1416208855-8623-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch changes the byteorder handling for short and panid handling.
We now except to get little endian in nl802154 for these attributes.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h   |  4 ++--
 net/ieee802154/nl802154.c |  8 ++++----
 net/ieee802154/rdev-ops.h |  4 ++--
 net/mac802154/cfg.c       | 14 +++++++-------
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 228f1f7..7f713ac 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -40,9 +40,9 @@ struct cfg802154_ops {
 				    struct wpan_dev *wpan_dev);
 	int	(*set_channel)(struct wpan_phy *wpan_phy, u8 page, u8 channel);
 	int	(*set_pan_id)(struct wpan_phy *wpan_phy,
-			      struct wpan_dev *wpan_dev, u16 pan_id);
+			      struct wpan_dev *wpan_dev, __le16 pan_id);
 	int	(*set_short_addr)(struct wpan_phy *wpan_phy,
-				  struct wpan_dev *wpan_dev, u16 short_addr);
+				  struct wpan_dev *wpan_dev, __le16 short_addr);
 	int	(*set_backoff_exponent)(struct wpan_phy *wpan_phy,
 					struct wpan_dev *wpan_dev, u8 min_be,
 					u8 max_be);
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index b82b016..8896477 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -627,7 +627,7 @@ static int nl802154_set_pan_id(struct sk_buff *skb, struct genl_info *info)
 	struct cfg802154_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
 	struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
-	u16 pan_id;
+	__le16 pan_id;
 
 	/* conflict here while tx/rx calls */
 	if (netif_running(dev))
@@ -640,7 +640,7 @@ static int nl802154_set_pan_id(struct sk_buff *skb, struct genl_info *info)
 	if (!info->attrs[NL802154_ATTR_PAN_ID])
 		return -EINVAL;
 
-	pan_id = nla_get_u16(info->attrs[NL802154_ATTR_PAN_ID]);
+	pan_id = nla_get_le16(info->attrs[NL802154_ATTR_PAN_ID]);
 
 	return rdev_set_pan_id(rdev, wpan_dev, pan_id);
 }
@@ -650,7 +650,7 @@ static int nl802154_set_short_addr(struct sk_buff *skb, struct genl_info *info)
 	struct cfg802154_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
 	struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
-	u16 short_addr;
+	__le16 short_addr;
 
 	/* conflict here while tx/rx calls */
 	if (netif_running(dev))
@@ -663,7 +663,7 @@ static int nl802154_set_short_addr(struct sk_buff *skb, struct genl_info *info)
 	if (!info->attrs[NL802154_ATTR_SHORT_ADDR])
 		return -EINVAL;
 
-	short_addr = nla_get_u16(info->attrs[NL802154_ATTR_SHORT_ADDR]);
+	short_addr = nla_get_le16(info->attrs[NL802154_ATTR_SHORT_ADDR]);
 
 	return rdev_set_short_addr(rdev, wpan_dev, short_addr);
 }
diff --git a/net/ieee802154/rdev-ops.h b/net/ieee802154/rdev-ops.h
index 40ffbc0..aff54fb 100644
--- a/net/ieee802154/rdev-ops.h
+++ b/net/ieee802154/rdev-ops.h
@@ -43,14 +43,14 @@ rdev_set_channel(struct cfg802154_registered_device *rdev, u8 page, u8 channel)
 
 static inline int
 rdev_set_pan_id(struct cfg802154_registered_device *rdev,
-		struct wpan_dev *wpan_dev, u16 pan_id)
+		struct wpan_dev *wpan_dev, __le16 pan_id)
 {
 	return rdev->ops->set_pan_id(&rdev->wpan_phy, wpan_dev, pan_id);
 }
 
 static inline int
 rdev_set_short_addr(struct cfg802154_registered_device *rdev,
-		    struct wpan_dev *wpan_dev, u16 short_addr)
+		    struct wpan_dev *wpan_dev, __le16 short_addr)
 {
 	return rdev->ops->set_short_addr(&rdev->wpan_phy, wpan_dev, short_addr);
 }
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 7def262..c035708 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -88,7 +88,7 @@ ieee802154_set_channel(struct wpan_phy *wpan_phy, u8 page, u8 channel)
 
 static int
 ieee802154_set_pan_id(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
-		      u16 pan_id)
+		      __le16 pan_id)
 {
 	ASSERT_RTNL();
 
@@ -99,10 +99,10 @@ ieee802154_set_pan_id(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 	 *
 	 * This could useful to simple deassociate an device.
 	 */
-	if (pan_id == IEEE802154_PAN_ID_BROADCAST)
+	if (pan_id == cpu_to_le16(IEEE802154_PAN_ID_BROADCAST))
 		return -EINVAL;
 
-	wpan_dev->pan_id = cpu_to_le16(pan_id);
+	wpan_dev->pan_id = pan_id;
 	return 0;
 }
 
@@ -125,7 +125,7 @@ ieee802154_set_backoff_exponent(struct wpan_phy *wpan_phy,
 
 static int
 ieee802154_set_short_addr(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
-			  u16 short_addr)
+			  __le16 short_addr)
 {
 	ASSERT_RTNL();
 
@@ -140,11 +140,11 @@ ieee802154_set_short_addr(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 	 * I think we should allow to set these settings but
 	 * don't allow to allow socket communication with it.
 	 */
-	if (short_addr == IEEE802154_ADDR_SHORT_UNSPEC ||
-	    short_addr == IEEE802154_ADDR_SHORT_BROADCAST)
+	if (short_addr == cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC) ||
+	    short_addr == cpu_to_le16(IEEE802154_ADDR_SHORT_BROADCAST))
 		return -EINVAL;
 
-	wpan_dev->short_addr = cpu_to_le16(short_addr);
+	wpan_dev->short_addr = short_addr;
 	return 0;
 }
 
-- 
2.1.3

