Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35872 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758016AbbEVPoI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 22 May 2015 11:44:08 -0400
Received: by wizk4 with SMTP id k4so51658062wiz.1
        for <linux-wpan@vger.kernel.org>; Fri, 22 May 2015 08:44:07 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 3/4] mac802154: use atomic ops for sequence incrementation
Date: Fri, 22 May 2015 17:43:53 +0200
Message-Id: <1432309434-8215-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1432309434-8215-1-git-send-email-alex.aring@gmail.com>
References: <1432309434-8215-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch will use atomic operations for sequence number incrementation
while MAC header generation. Upper layers like af_802154 or 6LoWPAN
could call this function in a parallel context while generating 802.15.4
MAC header before queuing into wpan interfaces transmit queue.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 include/net/cfg802154.h         | 4 ++--
 include/net/ieee802154_netdev.h | 1 -
 net/ieee802154/6lowpan/core.c   | 8 --------
 net/mac802154/ieee802154_i.h    | 1 -
 net/mac802154/iface.c           | 9 ++++++---
 net/mac802154/mac_cmd.c         | 1 -
 net/mac802154/mib.c             | 9 ---------
 7 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index c6aa1d2..4de59aa 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -177,9 +177,9 @@ struct wpan_dev {
 	__le64 extended_addr;
 
 	/* MAC BSN field */
-	u8 bsn;
+	atomic_t bsn;
 	/* MAC DSN field */
-	u8 dsn;
+	atomic_t dsn;
 
 	u8 min_be;
 	u8 max_be;
diff --git a/include/net/ieee802154_netdev.h b/include/net/ieee802154_netdev.h
index 94a2970..144fefb 100644
--- a/include/net/ieee802154_netdev.h
+++ b/include/net/ieee802154_netdev.h
@@ -431,7 +431,6 @@ struct ieee802154_mlme_ops {
 	 */
 	__le16 (*get_pan_id)(const struct net_device *dev);
 	__le16 (*get_short_addr)(const struct net_device *dev);
-	u8 (*get_dsn)(const struct net_device *dev);
 };
 
 static inline struct ieee802154_mlme_ops *
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 0ae5822..2e77fad 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -69,13 +69,6 @@ static __le16 lowpan_get_short_addr(const struct net_device *dev)
 	return ieee802154_mlme_ops(real_dev)->get_short_addr(real_dev);
 }
 
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
@@ -106,7 +99,6 @@ static const struct net_device_ops lowpan_netdev_ops = {
 static struct ieee802154_mlme_ops lowpan_mlme = {
 	.get_pan_id = lowpan_get_pan_id,
 	.get_short_addr = lowpan_get_short_addr,
-	.get_dsn = lowpan_get_dsn,
 };
 
 static void lowpan_setup(struct net_device *dev)
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 127ba18..56b3847 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -141,7 +141,6 @@ __le16 mac802154_dev_get_short_addr(const struct net_device *dev);
 __le16 mac802154_dev_get_pan_id(const struct net_device *dev);
 void mac802154_dev_set_pan_id(struct net_device *dev, __le16 val);
 void mac802154_dev_set_page_channel(struct net_device *dev, u8 page, u8 chan);
-u8 mac802154_dev_get_dsn(const struct net_device *dev);
 
 int mac802154_get_params(struct net_device *dev,
 			 struct ieee802154_llsec_params *params);
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 22f478b..0ec7bc4 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -368,7 +368,7 @@ static int mac802154_header_create(struct sk_buff *skb,
 	hdr.fc.type = cb->type;
 	hdr.fc.security_enabled = cb->secen;
 	hdr.fc.ack_request = cb->ackreq;
-	hdr.seq = ieee802154_mlme_ops(dev)->get_dsn(dev);
+	hdr.seq = atomic_inc_return(&dev->ieee802154_ptr->dsn) & 0xFF;
 
 	if (mac802154_set_header_security(sdata, &hdr, cb) < 0)
 		return -EINVAL;
@@ -468,13 +468,16 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata,
 		       enum nl802154_iftype type)
 {
 	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
+	u8 tmp;
 
 	/* set some type-dependent values */
 	sdata->vif.type = type;
 	sdata->wpan_dev.iftype = type;
 
-	get_random_bytes(&wpan_dev->bsn, 1);
-	get_random_bytes(&wpan_dev->dsn, 1);
+	get_random_bytes(&tmp, sizeof(tmp));
+	atomic_set(&wpan_dev->bsn, tmp);
+	get_random_bytes(&tmp, sizeof(tmp));
+	atomic_set(&wpan_dev->dsn, tmp);
 
 	/* defaults per 802.15.4-2011 */
 	wpan_dev->min_be = 3;
diff --git a/net/mac802154/mac_cmd.c b/net/mac802154/mac_cmd.c
index 6dcbb3b..3b347d4 100644
--- a/net/mac802154/mac_cmd.c
+++ b/net/mac802154/mac_cmd.c
@@ -153,7 +153,6 @@ struct ieee802154_mlme_ops mac802154_mlme_wpan = {
 	.start_req = mac802154_mlme_start_req,
 	.get_pan_id = mac802154_dev_get_pan_id,
 	.get_short_addr = mac802154_dev_get_short_addr,
-	.get_dsn = mac802154_dev_get_dsn,
 
 	.llsec = &mac802154_llsec_ops,
 
diff --git a/net/mac802154/mib.c b/net/mac802154/mib.c
index 033dfc7..00a62de 100644
--- a/net/mac802154/mib.c
+++ b/net/mac802154/mib.c
@@ -76,15 +76,6 @@ void mac802154_dev_set_pan_id(struct net_device *dev, __le16 val)
 	spin_unlock_bh(&sdata->mib_lock);
 }
 
-u8 mac802154_dev_get_dsn(const struct net_device *dev)
-{
-	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-
-	BUG_ON(dev->type != ARPHRD_IEEE802154);
-
-	return sdata->wpan_dev.dsn++;
-}
-
 void mac802154_dev_set_page_channel(struct net_device *dev, u8 page, u8 chan)
 {
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-- 
2.4.1

