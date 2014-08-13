Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:38300 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbaHMNq7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 13 Aug 2014 09:46:59 -0400
Received: by mail-lb0-f178.google.com with SMTP id c11so8165630lbj.23
        for <linux-wpan@vger.kernel.org>; Wed, 13 Aug 2014 06:46:57 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Wed, 13 Aug 2014 15:46:27 +0200
Message-Id: <1407937595-16415-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407937595-16415-1-git-send-email-alex.aring@gmail.com>
References: <1407937595-16415-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 04/12] mac802154: introduce IEEE802154_DEV_TO_SUB_IF
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This function adds a wrapper to call netdev_priv to getting the sdata
attribute. There exists a similar function in the wirless stack.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h |  6 ++++++
 net/mac802154/mac_cmd.c      |  2 +-
 net/mac802154/main.c         | 11 ++++------
 net/mac802154/mib.c          | 49 ++++++++++++++++++++++----------------------
 net/mac802154/wpan.c         | 20 ++++++++----------
 5 files changed, 45 insertions(+), 43 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index f4d102a..f4d3816 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -116,6 +116,12 @@ hw_to_local(struct ieee802154_hw *hw)
 	return container_of(hw, struct ieee802154_local, hw);
 }
 
+static inline struct ieee802154_sub_if_data *
+IEEE802154_DEV_TO_SUB_IF(const struct net_device *dev)
+{
+	return netdev_priv(dev);
+}
+
 extern struct ieee802154_reduced_mlme_ops mac802154_mlme_reduced;
 extern struct ieee802154_mlme_ops mac802154_mlme_wpan;
 
diff --git a/net/mac802154/mac_cmd.c b/net/mac802154/mac_cmd.c
index 2abbc39..df73ce7 100644
--- a/net/mac802154/mac_cmd.c
+++ b/net/mac802154/mac_cmd.c
@@ -79,7 +79,7 @@ static int mac802154_mlme_start_req(struct net_device *dev,
 
 static struct wpan_phy *mac802154_get_phy(const struct net_device *dev)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 2f070e9..df197f4 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -31,7 +31,7 @@
 
 int mac802154_slave_open(struct net_device *dev)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	struct ieee802154_sub_if_data *subif;
 	struct ieee802154_local *local = sdata->local;
 	int res = 0;
@@ -81,7 +81,7 @@ err:
 
 int mac802154_slave_close(struct net_device *dev)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	struct ieee802154_local *local = sdata->local;
 
 	ASSERT_RTNL();
@@ -101,13 +101,12 @@ int mac802154_slave_close(struct net_device *dev)
 static int
 mac802154_netdev_register(struct wpan_phy *phy, struct net_device *dev)
 {
-	struct ieee802154_sub_if_data *sdata;
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	struct ieee802154_local *local;
 	int err;
 
 	local = wpan_phy_priv(phy);
 
-	sdata = netdev_priv(dev);
 	sdata->dev = dev;
 	sdata->local = local;
 
@@ -138,12 +137,10 @@ mac802154_netdev_register(struct wpan_phy *phy, struct net_device *dev)
 static void
 mac802154_del_iface(struct wpan_phy *phy, struct net_device *dev)
 {
-	struct ieee802154_sub_if_data *sdata;
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
 	ASSERT_RTNL();
 
-	sdata = netdev_priv(dev);
-
 	BUG_ON(sdata->local->phy != phy);
 
 	mutex_lock(&sdata->local->iflist_mtx);
diff --git a/net/mac802154/mib.c b/net/mac802154/mib.c
index 62dc94c..683e9e8 100644
--- a/net/mac802154/mib.c
+++ b/net/mac802154/mib.c
@@ -42,7 +42,7 @@ struct hw_addr_filt_notify_work {
 
 static struct ieee802154_local *mac802154_slave_get_priv(struct net_device *dev)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
@@ -66,7 +66,7 @@ static void hw_addr_notify(struct work_struct *work)
 
 static void set_hw_addr_filt(struct net_device *dev, unsigned long changed)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	struct hw_addr_filt_notify_work *work;
 
 	work = kzalloc(sizeof(*work), GFP_ATOMIC);
@@ -81,7 +81,7 @@ static void set_hw_addr_filt(struct net_device *dev, unsigned long changed)
 
 void mac802154_dev_set_short_addr(struct net_device *dev, __le16 val)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
@@ -98,7 +98,7 @@ void mac802154_dev_set_short_addr(struct net_device *dev, __le16 val)
 
 __le16 mac802154_dev_get_short_addr(const struct net_device *dev)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	__le16 ret;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
@@ -112,7 +112,7 @@ __le16 mac802154_dev_get_short_addr(const struct net_device *dev)
 
 void mac802154_dev_set_ieee_addr(struct net_device *dev)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	struct ieee802154_local *local = sdata->local;
 
 	sdata->extended_addr = ieee802154_devaddr_from_raw(dev->dev_addr);
@@ -126,7 +126,7 @@ void mac802154_dev_set_ieee_addr(struct net_device *dev)
 
 __le16 mac802154_dev_get_pan_id(const struct net_device *dev)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	__le16 ret;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
@@ -140,7 +140,7 @@ __le16 mac802154_dev_get_pan_id(const struct net_device *dev)
 
 void mac802154_dev_set_pan_id(struct net_device *dev, __le16 val)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
@@ -157,7 +157,7 @@ void mac802154_dev_set_pan_id(struct net_device *dev, __le16 val)
 
 u8 mac802154_dev_get_dsn(const struct net_device *dev)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
@@ -168,8 +168,9 @@ static void phy_chan_notify(struct work_struct *work)
 {
 	struct phy_chan_notify_work *nw = container_of(work,
 					  struct phy_chan_notify_work, work);
-	struct ieee802154_local *local = mac802154_slave_get_priv(nw->dev);
-	struct ieee802154_sub_if_data *sdata = netdev_priv(nw->dev);
+	struct net_device *dev = nw->dev;
+	struct ieee802154_local *local = mac802154_slave_get_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	int res;
 
 	mutex_lock(&sdata->local->phy->pib_lock);
@@ -187,7 +188,7 @@ static void phy_chan_notify(struct work_struct *work)
 
 void mac802154_dev_set_page_channel(struct net_device *dev, u8 page, u8 chan)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	struct phy_chan_notify_work *work;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
@@ -218,7 +219,7 @@ void mac802154_dev_set_page_channel(struct net_device *dev, u8 page, u8 chan)
 int mac802154_get_params(struct net_device *dev,
 			 struct ieee802154_llsec_params *params)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
@@ -234,7 +235,7 @@ int mac802154_set_params(struct net_device *dev,
 			 const struct ieee802154_llsec_params *params,
 			 int changed)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
@@ -251,7 +252,7 @@ int mac802154_add_key(struct net_device *dev,
 		      const struct ieee802154_llsec_key_id *id,
 		      const struct ieee802154_llsec_key *key)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
@@ -266,7 +267,7 @@ int mac802154_add_key(struct net_device *dev,
 int mac802154_del_key(struct net_device *dev,
 		      const struct ieee802154_llsec_key_id *id)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
@@ -282,7 +283,7 @@ int mac802154_del_key(struct net_device *dev,
 int mac802154_add_dev(struct net_device *dev,
 		      const struct ieee802154_llsec_device *llsec_dev)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
@@ -296,7 +297,7 @@ int mac802154_add_dev(struct net_device *dev,
 
 int mac802154_del_dev(struct net_device *dev, __le64 dev_addr)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
@@ -313,7 +314,7 @@ int mac802154_add_devkey(struct net_device *dev,
 			 __le64 device_addr,
 			 const struct ieee802154_llsec_device_key *key)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
@@ -329,7 +330,7 @@ int mac802154_del_devkey(struct net_device *dev,
 			 __le64 device_addr,
 			 const struct ieee802154_llsec_device_key *key)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
@@ -345,7 +346,7 @@ int mac802154_del_devkey(struct net_device *dev,
 int mac802154_add_seclevel(struct net_device *dev,
 			   const struct ieee802154_llsec_seclevel *sl)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
@@ -360,7 +361,7 @@ int mac802154_add_seclevel(struct net_device *dev,
 int mac802154_del_seclevel(struct net_device *dev,
 			   const struct ieee802154_llsec_seclevel *sl)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
@@ -375,7 +376,7 @@ int mac802154_del_seclevel(struct net_device *dev,
 
 void mac802154_lock_table(struct net_device *dev)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
@@ -385,7 +386,7 @@ void mac802154_lock_table(struct net_device *dev)
 void mac802154_get_table(struct net_device *dev,
 			 struct ieee802154_llsec_table **t)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
@@ -394,7 +395,7 @@ void mac802154_get_table(struct net_device *dev,
 
 void mac802154_unlock_table(struct net_device *dev)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
diff --git a/net/mac802154/wpan.c b/net/mac802154/wpan.c
index c480501..ec20d66 100644
--- a/net/mac802154/wpan.c
+++ b/net/mac802154/wpan.c
@@ -37,7 +37,7 @@
 
 static int mac802154_wpan_update_llsec(struct net_device *dev)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	struct ieee802154_mlme_ops *ops = ieee802154_mlme_ops(dev);
 	int rc = 0;
 
@@ -60,7 +60,7 @@ static int mac802154_wpan_update_llsec(struct net_device *dev)
 static int
 mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	struct sockaddr_ieee802154 *sa =
 		(struct sockaddr_ieee802154 *)&ifr->ifr_addr;
 	int err = -ENOIOCTLCMD;
@@ -127,7 +127,7 @@ static int mac802154_wpan_mac_addr(struct net_device *dev, void *p)
 int mac802154_set_mac_params(struct net_device *dev,
 			     const struct ieee802154_mac_params *params)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
 	mutex_lock(&sdata->local->iflist_mtx);
 	sdata->mac_params = *params;
@@ -139,7 +139,7 @@ int mac802154_set_mac_params(struct net_device *dev,
 void mac802154_get_mac_params(struct net_device *dev,
 			      struct ieee802154_mac_params *params)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
 	mutex_lock(&sdata->local->iflist_mtx);
 	*params = sdata->mac_params;
@@ -149,7 +149,7 @@ void mac802154_get_mac_params(struct net_device *dev,
 static int mac802154_wpan_open(struct net_device *dev)
 {
 	int rc;
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	struct wpan_phy *phy = sdata->local->phy;
 
 	rc = mac802154_slave_open(dev);
@@ -245,7 +245,7 @@ static int mac802154_header_create(struct sk_buff *skb,
 				   unsigned len)
 {
 	struct ieee802154_hdr hdr;
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	struct ieee802154_mac_cb *cb = mac_cb(skb);
 	int hlen;
 
@@ -314,12 +314,10 @@ mac802154_header_parse(const struct sk_buff *skb, unsigned char *haddr)
 static netdev_tx_t
 mac802154_wpan_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct ieee802154_sub_if_data *sdata;
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	u8 chan, page;
 	int rc;
 
-	sdata = netdev_priv(dev);
-
 	spin_lock_bh(&sdata->mib_lock);
 	chan = sdata->chan;
 	page = sdata->page;
@@ -361,7 +359,7 @@ static const struct net_device_ops mac802154_wpan_ops = {
 
 static void mac802154_wpan_free(struct net_device *dev)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
 	mac802154_llsec_destroy(&sdata->sec);
 
@@ -388,7 +386,7 @@ void mac802154_wpan_setup(struct net_device *dev)
 	dev->netdev_ops		= &mac802154_wpan_ops;
 	dev->ml_priv		= &mac802154_mlme_wpan;
 
-	sdata = netdev_priv(dev);
+	sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	sdata->type = NL802154_IFTYPE_NODE;
 
 	sdata->chan = MAC802154_CHAN_NONE;
-- 
2.0.3

