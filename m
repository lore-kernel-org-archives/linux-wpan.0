Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:55862 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbaJYTRE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 25 Oct 2014 15:17:04 -0400
Received: by mail-la0-f46.google.com with SMTP id gi9so4055323lab.5
        for <linux-wpan@vger.kernel.org>; Sat, 25 Oct 2014 12:17:02 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 08/10] mac802154: introduce IEEE802154_DEV_TO_SUB_IF
Date: Sat, 25 Oct 2014 17:16:40 +0200
Message-Id: <1414250202-32384-9-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414250202-32384-1-git-send-email-alex.aring@gmail.com>
References: <1414250202-32384-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This function adds a wrapper to call netdev_priv to getting the sdata
attribute. This is similar like the IEEE80211_DEV_TO_SUB_IF function
inside wireless stack implementation.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h |  6 ++++++
 net/mac802154/iface.c        | 18 ++++++++--------
 net/mac802154/mac_cmd.c      |  2 +-
 net/mac802154/main.c         | 11 ++++------
 net/mac802154/mib.c          | 49 ++++++++++++++++++++++----------------------
 net/mac802154/monitor.c      |  4 ++--
 6 files changed, 47 insertions(+), 43 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 41e29b0..61885aa 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -107,6 +107,12 @@ hw_to_local(struct ieee802154_hw *hw)
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
 
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index c0dbb40..cdd661f 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -33,7 +33,7 @@
 
 static int mac802154_wpan_update_llsec(struct net_device *dev)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	struct ieee802154_mlme_ops *ops = ieee802154_mlme_ops(dev);
 	int rc = 0;
 
@@ -56,7 +56,7 @@ static int mac802154_wpan_update_llsec(struct net_device *dev)
 static int
 mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	struct sockaddr_ieee802154 *sa =
 		(struct sockaddr_ieee802154 *)&ifr->ifr_addr;
 	int err = -ENOIOCTLCMD;
@@ -123,7 +123,7 @@ static int mac802154_wpan_mac_addr(struct net_device *dev, void *p)
 int mac802154_set_mac_params(struct net_device *dev,
 			     const struct ieee802154_mac_params *params)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
 	mutex_lock(&sdata->local->iflist_mtx);
 	sdata->mac_params = *params;
@@ -135,7 +135,7 @@ int mac802154_set_mac_params(struct net_device *dev,
 void mac802154_get_mac_params(struct net_device *dev,
 			      struct ieee802154_mac_params *params)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
 	mutex_lock(&sdata->local->iflist_mtx);
 	*params = sdata->mac_params;
@@ -145,7 +145,7 @@ void mac802154_get_mac_params(struct net_device *dev,
 static int mac802154_wpan_open(struct net_device *dev)
 {
 	int rc;
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	struct wpan_phy *phy = sdata->local->phy;
 
 	rc = mac802154_slave_open(dev);
@@ -241,7 +241,7 @@ static int mac802154_header_create(struct sk_buff *skb,
 				   unsigned len)
 {
 	struct ieee802154_hdr hdr;
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	struct ieee802154_mac_cb *cb = mac_cb(skb);
 	int hlen;
 
@@ -314,7 +314,7 @@ mac802154_wpan_xmit(struct sk_buff *skb, struct net_device *dev)
 	u8 chan, page;
 	int rc;
 
-	sdata = netdev_priv(dev);
+	sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
 	spin_lock_bh(&sdata->mib_lock);
 	chan = sdata->chan;
@@ -357,7 +357,7 @@ static const struct net_device_ops mac802154_wpan_ops = {
 
 static void mac802154_wpan_free(struct net_device *dev)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
 	mac802154_llsec_destroy(&sdata->sec);
 
@@ -384,7 +384,7 @@ void mac802154_wpan_setup(struct net_device *dev)
 	dev->netdev_ops		= &mac802154_wpan_ops;
 	dev->ml_priv		= &mac802154_mlme_wpan;
 
-	sdata = netdev_priv(dev);
+	sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	sdata->type = IEEE802154_DEV_WPAN;
 
 	sdata->chan = MAC802154_CHAN_NONE;
diff --git a/net/mac802154/mac_cmd.c b/net/mac802154/mac_cmd.c
index 5ee1088..ed767f5 100644
--- a/net/mac802154/mac_cmd.c
+++ b/net/mac802154/mac_cmd.c
@@ -75,7 +75,7 @@ static int mac802154_mlme_start_req(struct net_device *dev,
 
 static struct wpan_phy *mac802154_get_phy(const struct net_device *dev)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index c7799fa..a34006e 100644
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
index 1ffca5c..d7a2504 100644
--- a/net/mac802154/mib.c
+++ b/net/mac802154/mib.c
@@ -38,7 +38,7 @@ struct hw_addr_filt_notify_work {
 
 static struct ieee802154_local *mac802154_slave_get_priv(struct net_device *dev)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
@@ -62,7 +62,7 @@ static void hw_addr_notify(struct work_struct *work)
 
 static void set_hw_addr_filt(struct net_device *dev, unsigned long changed)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	struct hw_addr_filt_notify_work *work;
 
 	work = kzalloc(sizeof(*work), GFP_ATOMIC);
@@ -77,7 +77,7 @@ static void set_hw_addr_filt(struct net_device *dev, unsigned long changed)
 
 void mac802154_dev_set_short_addr(struct net_device *dev, __le16 val)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
@@ -94,7 +94,7 @@ void mac802154_dev_set_short_addr(struct net_device *dev, __le16 val)
 
 __le16 mac802154_dev_get_short_addr(const struct net_device *dev)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	__le16 ret;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
@@ -108,7 +108,7 @@ __le16 mac802154_dev_get_short_addr(const struct net_device *dev)
 
 void mac802154_dev_set_ieee_addr(struct net_device *dev)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	struct ieee802154_local *local = sdata->local;
 
 	sdata->extended_addr = ieee802154_devaddr_from_raw(dev->dev_addr);
@@ -122,7 +122,7 @@ void mac802154_dev_set_ieee_addr(struct net_device *dev)
 
 __le16 mac802154_dev_get_pan_id(const struct net_device *dev)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	__le16 ret;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
@@ -136,7 +136,7 @@ __le16 mac802154_dev_get_pan_id(const struct net_device *dev)
 
 void mac802154_dev_set_pan_id(struct net_device *dev, __le16 val)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
@@ -153,7 +153,7 @@ void mac802154_dev_set_pan_id(struct net_device *dev, __le16 val)
 
 u8 mac802154_dev_get_dsn(const struct net_device *dev)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
@@ -164,8 +164,9 @@ static void phy_chan_notify(struct work_struct *work)
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
@@ -183,7 +184,7 @@ static void phy_chan_notify(struct work_struct *work)
 
 void mac802154_dev_set_page_channel(struct net_device *dev, u8 page, u8 chan)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	struct phy_chan_notify_work *work;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
@@ -214,7 +215,7 @@ void mac802154_dev_set_page_channel(struct net_device *dev, u8 page, u8 chan)
 int mac802154_get_params(struct net_device *dev,
 			 struct ieee802154_llsec_params *params)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
@@ -230,7 +231,7 @@ int mac802154_set_params(struct net_device *dev,
 			 const struct ieee802154_llsec_params *params,
 			 int changed)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
@@ -247,7 +248,7 @@ int mac802154_add_key(struct net_device *dev,
 		      const struct ieee802154_llsec_key_id *id,
 		      const struct ieee802154_llsec_key *key)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
@@ -262,7 +263,7 @@ int mac802154_add_key(struct net_device *dev,
 int mac802154_del_key(struct net_device *dev,
 		      const struct ieee802154_llsec_key_id *id)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
@@ -278,7 +279,7 @@ int mac802154_del_key(struct net_device *dev,
 int mac802154_add_dev(struct net_device *dev,
 		      const struct ieee802154_llsec_device *llsec_dev)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
@@ -292,7 +293,7 @@ int mac802154_add_dev(struct net_device *dev,
 
 int mac802154_del_dev(struct net_device *dev, __le64 dev_addr)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
@@ -309,7 +310,7 @@ int mac802154_add_devkey(struct net_device *dev,
 			 __le64 device_addr,
 			 const struct ieee802154_llsec_device_key *key)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
@@ -325,7 +326,7 @@ int mac802154_del_devkey(struct net_device *dev,
 			 __le64 device_addr,
 			 const struct ieee802154_llsec_device_key *key)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
@@ -341,7 +342,7 @@ int mac802154_del_devkey(struct net_device *dev,
 int mac802154_add_seclevel(struct net_device *dev,
 			   const struct ieee802154_llsec_seclevel *sl)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
@@ -356,7 +357,7 @@ int mac802154_add_seclevel(struct net_device *dev,
 int mac802154_del_seclevel(struct net_device *dev,
 			   const struct ieee802154_llsec_seclevel *sl)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
@@ -371,7 +372,7 @@ int mac802154_del_seclevel(struct net_device *dev,
 
 void mac802154_lock_table(struct net_device *dev)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
@@ -381,7 +382,7 @@ void mac802154_lock_table(struct net_device *dev)
 void mac802154_get_table(struct net_device *dev,
 			 struct ieee802154_llsec_table **t)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
@@ -390,7 +391,7 @@ void mac802154_get_table(struct net_device *dev,
 
 void mac802154_unlock_table(struct net_device *dev)
 {
-	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
diff --git a/net/mac802154/monitor.c b/net/mac802154/monitor.c
index 9d2ac5e..f8ea6dc 100644
--- a/net/mac802154/monitor.c
+++ b/net/mac802154/monitor.c
@@ -36,7 +36,7 @@ static netdev_tx_t mac802154_monitor_xmit(struct sk_buff *skb,
 	struct ieee802154_sub_if_data *sdata;
 	u8 chan, page;
 
-	sdata = netdev_priv(dev);
+	sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 
 	/* FIXME: locking */
 	chan = sdata->local->phy->current_channel;
@@ -105,7 +105,7 @@ void mac802154_monitor_setup(struct net_device *dev)
 	dev->netdev_ops		= &mac802154_monitor_ops;
 	dev->ml_priv		= &mac802154_mlme_reduced;
 
-	sdata = netdev_priv(dev);
+	sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	sdata->type = IEEE802154_DEV_MONITOR;
 
 	sdata->chan = MAC802154_CHAN_NONE; /* not initialized */
-- 
2.1.2

