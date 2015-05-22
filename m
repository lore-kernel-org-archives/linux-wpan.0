Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37987 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756729AbbEVI5X (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 22 May 2015 04:57:23 -0400
Received: by wichy4 with SMTP id hy4so40031039wic.1
        for <linux-wpan@vger.kernel.org>; Fri, 22 May 2015 01:57:22 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 3/4] mac802154: remove mib lock
Date: Fri, 22 May 2015 10:57:10 +0200
Message-Id: <1432285031-3360-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1432285031-3360-1-git-send-email-alex.aring@gmail.com>
References: <1432285031-3360-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes the mib lock. The new locking mechanism is to protect
the mib values with the rtnl lock. Note that this isn't always necessary
if we have an interface up the most mib values are readonly (e.g.
address settings). With this behaviour we can remove locking in
hotpath like frame parsing completely. It depends on context if we need
to hold the rtnl lock or not, this makes the callbacks of
ieee802154_mlme_ops unnecessary because these callbacks hols always the
locks.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/ieee802154_netdev.h | 10 -------
 net/ieee802154/6lowpan/core.c   | 28 -------------------
 net/ieee802154/6lowpan/tx.c     |  2 +-
 net/ieee802154/nl-mac.c         | 14 +++++++---
 net/ieee802154/socket.c         | 12 ++++-----
 net/mac802154/ieee802154_i.h    |  7 -----
 net/mac802154/iface.c           | 13 +++------
 net/mac802154/mac_cmd.c         |  7 ++---
 net/mac802154/mib.c             | 59 -----------------------------------------
 net/mac802154/rx.c              |  5 ----
 10 files changed, 22 insertions(+), 135 deletions(-)

diff --git a/include/net/ieee802154_netdev.h b/include/net/ieee802154_netdev.h
index 94a2970..84a72a1 100644
--- a/include/net/ieee802154_netdev.h
+++ b/include/net/ieee802154_netdev.h
@@ -422,16 +422,6 @@ struct ieee802154_mlme_ops {
 			       struct ieee802154_mac_params *params);
 
 	struct ieee802154_llsec_ops *llsec;
-
-	/* The fields below are required. */
-
-	/*
-	 * FIXME: these should become the part of PIB/MIB interface.
-	 * However we still don't have IB interface of any kind
-	 */
-	__le16 (*get_pan_id)(const struct net_device *dev);
-	__le16 (*get_short_addr)(const struct net_device *dev);
-	u8 (*get_dsn)(const struct net_device *dev);
 };
 
 static inline struct ieee802154_mlme_ops *
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
index 2349070..98acf73 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -207,7 +207,7 @@ static int lowpan_header(struct sk_buff *skb, struct net_device *dev)
 
 	/* prepare wpan address data */
 	sa.mode = IEEE802154_ADDR_LONG;
-	sa.pan_id = ieee802154_mlme_ops(dev)->get_pan_id(dev);
+	sa.pan_id = lowpan_dev_info(dev)->real_dev->ieee802154_ptr->pan_id;
 	sa.extended_addr = ieee802154_devaddr_from_raw(saddr);
 
 	/* intra-PAN communications */
diff --git a/net/ieee802154/nl-mac.c b/net/ieee802154/nl-mac.c
index cdc1cc3..ada58a8 100644
--- a/net/ieee802154/nl-mac.c
+++ b/net/ieee802154/nl-mac.c
@@ -97,8 +97,10 @@ static int ieee802154_nl_fill_iface(struct sk_buff *msg, u32 portid,
 	BUG_ON(!phy);
 	get_device(&phy->dev);
 
-	short_addr = ops->get_short_addr(dev);
-	pan_id = ops->get_pan_id(dev);
+	rtnl_lock();
+	short_addr = dev->ieee802154_ptr->short_addr;
+	pan_id = dev->ieee802154_ptr->pan_id;
+	rtnl_unlock();
 
 	if (nla_put_string(msg, IEEE802154_ATTR_DEV_NAME, dev->name) ||
 	    nla_put_string(msg, IEEE802154_ATTR_PHY_NAME, wpan_phy_name(phy)) ||
@@ -244,7 +246,9 @@ int ieee802154_associate_resp(struct sk_buff *skb, struct genl_info *info)
 	addr.mode = IEEE802154_ADDR_LONG;
 	addr.extended_addr = nla_get_hwaddr(
 			info->attrs[IEEE802154_ATTR_DEST_HW_ADDR]);
-	addr.pan_id = ieee802154_mlme_ops(dev)->get_pan_id(dev);
+	rtnl_lock();
+	addr.pan_id = dev->ieee802154_ptr->pan_id;
+	rtnl_unlock();
 
 	ret = ieee802154_mlme_ops(dev)->assoc_resp(dev, &addr,
 		nla_get_shortaddr(info->attrs[IEEE802154_ATTR_DEST_SHORT_ADDR]),
@@ -281,7 +285,9 @@ int ieee802154_disassociate_req(struct sk_buff *skb, struct genl_info *info)
 		addr.short_addr = nla_get_shortaddr(
 				info->attrs[IEEE802154_ATTR_DEST_SHORT_ADDR]);
 	}
-	addr.pan_id = ieee802154_mlme_ops(dev)->get_pan_id(dev);
+	rtnl_lock();
+	addr.pan_id = dev->ieee802154_ptr->pan_id;
+	rtnl_unlock();
 
 	ret = ieee802154_mlme_ops(dev)->disassoc_req(dev, &addr,
 			nla_get_u8(info->attrs[IEEE802154_ATTR_REASON]));
diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 7aaaf96..e5cc253 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -64,10 +64,8 @@ ieee802154_get_dev(struct net *net, const struct ieee802154_addr *addr)
 			if (tmp->type != ARPHRD_IEEE802154)
 				continue;
 
-			pan_id = ieee802154_mlme_ops(tmp)->get_pan_id(tmp);
-			short_addr =
-				ieee802154_mlme_ops(tmp)->get_short_addr(tmp);
-
+			pan_id = tmp->ieee802154_ptr->pan_id;
+			short_addr = tmp->ieee802154_ptr->short_addr;
 			if (pan_id == addr->pan_id &&
 			    short_addr == addr->short_addr) {
 				dev = tmp;
@@ -797,9 +795,9 @@ static int ieee802154_dgram_deliver(struct net_device *dev, struct sk_buff *skb)
 	/* Data frame processing */
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
-	pan_id = ieee802154_mlme_ops(dev)->get_pan_id(dev);
-	short_addr = ieee802154_mlme_ops(dev)->get_short_addr(dev);
-	hw_addr = ieee802154_devaddr_from_raw(dev->dev_addr);
+	pan_id = dev->ieee802154_ptr->pan_id;
+	short_addr = dev->ieee802154_ptr->short_addr;
+	hw_addr = dev->ieee802154_ptr->extended_addr;
 
 	read_lock(&dgram_lock);
 	sk_for_each(sk, &dgram_head) {
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 127ba18..eec668f 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -86,8 +86,6 @@ struct ieee802154_sub_if_data {
 	unsigned long state;
 	char name[IFNAMSIZ];
 
-	spinlock_t mib_lock;
-
 	/* protects sec from concurrent access by netlink. access by
 	 * encrypt/decrypt/header_create safe without additional protection.
 	 */
@@ -136,12 +134,7 @@ ieee802154_subif_start_xmit(struct sk_buff *skb, struct net_device *dev);
 enum hrtimer_restart ieee802154_xmit_ifs_timer(struct hrtimer *timer);
 
 /* MIB callbacks */
-void mac802154_dev_set_short_addr(struct net_device *dev, __le16 val);
-__le16 mac802154_dev_get_short_addr(const struct net_device *dev);
-__le16 mac802154_dev_get_pan_id(const struct net_device *dev);
-void mac802154_dev_set_pan_id(struct net_device *dev, __le16 val);
 void mac802154_dev_set_page_channel(struct net_device *dev, u8 page, u8 chan);
-u8 mac802154_dev_get_dsn(const struct net_device *dev);
 
 int mac802154_get_params(struct net_device *dev,
 			 struct ieee802154_llsec_params *params);
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 22f478b..866d27f 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -63,7 +63,6 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 	int err = -ENOIOCTLCMD;
 
 	rtnl_lock();
-	spin_lock_bh(&sdata->mib_lock);
 
 	switch (cmd) {
 	case SIOCGIFADDR:
@@ -88,7 +87,6 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 	}
 	case SIOCSIFADDR:
 		if (netif_running(dev)) {
-			spin_unlock_bh(&sdata->mib_lock);
 			rtnl_unlock();
 			return -EBUSY;
 		}
@@ -111,7 +109,6 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 		break;
 	}
 
-	spin_unlock_bh(&sdata->mib_lock);
 	rtnl_unlock();
 	return err;
 }
@@ -368,14 +365,15 @@ static int mac802154_header_create(struct sk_buff *skb,
 	hdr.fc.type = cb->type;
 	hdr.fc.security_enabled = cb->secen;
 	hdr.fc.ack_request = cb->ackreq;
-	hdr.seq = ieee802154_mlme_ops(dev)->get_dsn(dev);
+	/* TODO: use atomic_t as dsn, dsn need to be locked when AF_IEEE802154
+	 * and IEEE802154 6LoWPAN call this at the same time.
+	 */
+	hdr.seq = dev->ieee802154_ptr->dsn++;
 
 	if (mac802154_set_header_security(sdata, &hdr, cb) < 0)
 		return -EINVAL;
 
 	if (!saddr) {
-		spin_lock_bh(&sdata->mib_lock);
-
 		if (wpan_dev->short_addr == cpu_to_le16(IEEE802154_ADDR_BROADCAST) ||
 		    wpan_dev->short_addr == cpu_to_le16(IEEE802154_ADDR_UNDEF) ||
 		    wpan_dev->pan_id == cpu_to_le16(IEEE802154_PANID_BROADCAST)) {
@@ -387,8 +385,6 @@ static int mac802154_header_create(struct sk_buff *skb,
 		}
 
 		hdr.source.pan_id = wpan_dev->pan_id;
-
-		spin_unlock_bh(&sdata->mib_lock);
 	} else {
 		hdr.source = *(const struct ieee802154_addr *)saddr;
 	}
@@ -497,7 +493,6 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata,
 		sdata->dev->ml_priv = &mac802154_mlme_wpan;
 		wpan_dev->promiscuous_mode = false;
 
-		spin_lock_init(&sdata->mib_lock);
 		mutex_init(&sdata->sec_mtx);
 
 		mac802154_llsec_init(&sdata->sec);
diff --git a/net/mac802154/mac_cmd.c b/net/mac802154/mac_cmd.c
index 6dcbb3b..5220c2b2 100644
--- a/net/mac802154/mac_cmd.c
+++ b/net/mac802154/mac_cmd.c
@@ -43,8 +43,8 @@ static int mac802154_mlme_start_req(struct net_device *dev,
 
 	BUG_ON(addr->mode != IEEE802154_ADDR_SHORT);
 
-	mac802154_dev_set_pan_id(dev, addr->pan_id);
-	mac802154_dev_set_short_addr(dev, addr->short_addr);
+	dev->ieee802154_ptr->pan_id = addr->pan_id;
+	dev->ieee802154_ptr->short_addr = addr->short_addr;
 	mac802154_dev_set_page_channel(dev, page, channel);
 
 	if (ops->llsec) {
@@ -151,9 +151,6 @@ static struct ieee802154_llsec_ops mac802154_llsec_ops = {
 
 struct ieee802154_mlme_ops mac802154_mlme_wpan = {
 	.start_req = mac802154_mlme_start_req,
-	.get_pan_id = mac802154_dev_get_pan_id,
-	.get_short_addr = mac802154_dev_get_short_addr,
-	.get_dsn = mac802154_dev_get_dsn,
 
 	.llsec = &mac802154_llsec_ops,
 
diff --git a/net/mac802154/mib.c b/net/mac802154/mib.c
index 033dfc7..73f94fb 100644
--- a/net/mac802154/mib.c
+++ b/net/mac802154/mib.c
@@ -26,65 +26,6 @@
 #include "ieee802154_i.h"
 #include "driver-ops.h"
 
-void mac802154_dev_set_short_addr(struct net_device *dev, __le16 val)
-{
-	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-
-	BUG_ON(dev->type != ARPHRD_IEEE802154);
-
-	spin_lock_bh(&sdata->mib_lock);
-	sdata->wpan_dev.short_addr = val;
-	spin_unlock_bh(&sdata->mib_lock);
-}
-
-__le16 mac802154_dev_get_short_addr(const struct net_device *dev)
-{
-	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-	__le16 ret;
-
-	BUG_ON(dev->type != ARPHRD_IEEE802154);
-
-	spin_lock_bh(&sdata->mib_lock);
-	ret = sdata->wpan_dev.short_addr;
-	spin_unlock_bh(&sdata->mib_lock);
-
-	return ret;
-}
-
-__le16 mac802154_dev_get_pan_id(const struct net_device *dev)
-{
-	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-	__le16 ret;
-
-	BUG_ON(dev->type != ARPHRD_IEEE802154);
-
-	spin_lock_bh(&sdata->mib_lock);
-	ret = sdata->wpan_dev.pan_id;
-	spin_unlock_bh(&sdata->mib_lock);
-
-	return ret;
-}
-
-void mac802154_dev_set_pan_id(struct net_device *dev, __le16 val)
-{
-	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
-
-	BUG_ON(dev->type != ARPHRD_IEEE802154);
-
-	spin_lock_bh(&sdata->mib_lock);
-	sdata->wpan_dev.pan_id = val;
-	spin_unlock_bh(&sdata->mib_lock);
-}
-
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
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index c0d67b2..e0f1006 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -47,8 +47,6 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 
 	pr_debug("getting packet via slave interface %s\n", sdata->dev->name);
 
-	spin_lock_bh(&sdata->mib_lock);
-
 	span = wpan_dev->pan_id;
 	sshort = wpan_dev->short_addr;
 
@@ -83,13 +81,10 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 			skb->pkt_type = PACKET_OTHERHOST;
 		break;
 	default:
-		spin_unlock_bh(&sdata->mib_lock);
 		pr_debug("invalid dest mode\n");
 		goto fail;
 	}
 
-	spin_unlock_bh(&sdata->mib_lock);
-
 	skb->dev = sdata->dev;
 
 	rc = mac802154_llsec_decrypt(&sdata->sec, skb);
-- 
2.4.1

