Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:36892 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbaJYTEs (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 25 Oct 2014 15:04:48 -0400
Received: by mail-la0-f42.google.com with SMTP id gf13so4593041lab.15
        for <linux-wpan@vger.kernel.org>; Sat, 25 Oct 2014 12:04:46 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 04/10] mac802154: rename mac802154_sub_if_data
Date: Sat, 25 Oct 2014 17:16:36 +0200
Message-Id: <1414250202-32384-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414250202-32384-1-git-send-email-alex.aring@gmail.com>
References: <1414250202-32384-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Like wireless this structure should named ieee802154_sub_if_data and not
mac802154_sub_if_data. This patch renames the struct and variables to
sdata instead priv sometimes.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h |   2 +-
 net/mac802154/iface.c        | 137 +++++++++++++++---------------
 net/mac802154/mac_cmd.c      |   4 +-
 net/mac802154/main.c         |  54 ++++++------
 net/mac802154/mib.c          | 192 +++++++++++++++++++++----------------------
 net/mac802154/monitor.c      |  22 ++---
 net/mac802154/tx.c           |   4 +-
 7 files changed, 208 insertions(+), 207 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index eb55cd2..daaca37 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -66,7 +66,7 @@ struct ieee802154_local {
  * Each ieee802154 device/transceiver may have several slaves and able
  * to be associated with several networks at the same time.
  */
-struct mac802154_sub_if_data {
+struct ieee802154_sub_if_data {
 	struct list_head list; /* the ieee802154_priv->slaves list */
 
 	struct ieee802154_local *hw;
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 10f1ee2..d3eb8a4 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -33,7 +33,7 @@
 
 static int mac802154_wpan_update_llsec(struct net_device *dev)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 	struct ieee802154_mlme_ops *ops = ieee802154_mlme_ops(dev);
 	int rc = 0;
 
@@ -41,10 +41,10 @@ static int mac802154_wpan_update_llsec(struct net_device *dev)
 		struct ieee802154_llsec_params params;
 		int changed = 0;
 
-		params.pan_id = priv->pan_id;
+		params.pan_id = sdata->pan_id;
 		changed |= IEEE802154_LLSEC_PARAM_PAN_ID;
 
-		params.hwaddr = priv->extended_addr;
+		params.hwaddr = sdata->extended_addr;
 		changed |= IEEE802154_LLSEC_PARAM_HWADDR;
 
 		rc = ops->llsec->set_params(dev, &params, changed);
@@ -56,20 +56,20 @@ static int mac802154_wpan_update_llsec(struct net_device *dev)
 static int
 mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 	struct sockaddr_ieee802154 *sa =
 		(struct sockaddr_ieee802154 *)&ifr->ifr_addr;
 	int err = -ENOIOCTLCMD;
 
-	spin_lock_bh(&priv->mib_lock);
+	spin_lock_bh(&sdata->mib_lock);
 
 	switch (cmd) {
 	case SIOCGIFADDR:
 	{
 		u16 pan_id, short_addr;
 
-		pan_id = le16_to_cpu(priv->pan_id);
-		short_addr = le16_to_cpu(priv->short_addr);
+		pan_id = le16_to_cpu(sdata->pan_id);
+		short_addr = le16_to_cpu(sdata->short_addr);
 		if (pan_id == IEEE802154_PANID_BROADCAST ||
 		    short_addr == IEEE802154_ADDR_BROADCAST) {
 			err = -EADDRNOTAVAIL;
@@ -96,14 +96,14 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 			break;
 		}
 
-		priv->pan_id = cpu_to_le16(sa->addr.pan_id);
-		priv->short_addr = cpu_to_le16(sa->addr.short_addr);
+		sdata->pan_id = cpu_to_le16(sa->addr.pan_id);
+		sdata->short_addr = cpu_to_le16(sa->addr.short_addr);
 
 		err = mac802154_wpan_update_llsec(dev);
 		break;
 	}
 
-	spin_unlock_bh(&priv->mib_lock);
+	spin_unlock_bh(&sdata->mib_lock);
 	return err;
 }
 
@@ -123,11 +123,11 @@ static int mac802154_wpan_mac_addr(struct net_device *dev, void *p)
 int mac802154_set_mac_params(struct net_device *dev,
 			     const struct ieee802154_mac_params *params)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 
-	mutex_lock(&priv->hw->slaves_mtx);
-	priv->mac_params = *params;
-	mutex_unlock(&priv->hw->slaves_mtx);
+	mutex_lock(&sdata->hw->slaves_mtx);
+	sdata->mac_params = *params;
+	mutex_unlock(&sdata->hw->slaves_mtx);
 
 	return 0;
 }
@@ -135,18 +135,18 @@ int mac802154_set_mac_params(struct net_device *dev,
 void mac802154_get_mac_params(struct net_device *dev,
 			      struct ieee802154_mac_params *params)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 
-	mutex_lock(&priv->hw->slaves_mtx);
-	*params = priv->mac_params;
-	mutex_unlock(&priv->hw->slaves_mtx);
+	mutex_lock(&sdata->hw->slaves_mtx);
+	*params = sdata->mac_params;
+	mutex_unlock(&sdata->hw->slaves_mtx);
 }
 
 static int mac802154_wpan_open(struct net_device *dev)
 {
 	int rc;
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
-	struct wpan_phy *phy = priv->hw->phy;
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct wpan_phy *phy = sdata->hw->phy;
 
 	rc = mac802154_slave_open(dev);
 	if (rc < 0)
@@ -155,40 +155,40 @@ static int mac802154_wpan_open(struct net_device *dev)
 	mutex_lock(&phy->pib_lock);
 
 	if (phy->set_txpower) {
-		rc = phy->set_txpower(phy, priv->mac_params.transmit_power);
+		rc = phy->set_txpower(phy, sdata->mac_params.transmit_power);
 		if (rc < 0)
 			goto out;
 	}
 
 	if (phy->set_lbt) {
-		rc = phy->set_lbt(phy, priv->mac_params.lbt);
+		rc = phy->set_lbt(phy, sdata->mac_params.lbt);
 		if (rc < 0)
 			goto out;
 	}
 
 	if (phy->set_cca_mode) {
-		rc = phy->set_cca_mode(phy, priv->mac_params.cca_mode);
+		rc = phy->set_cca_mode(phy, sdata->mac_params.cca_mode);
 		if (rc < 0)
 			goto out;
 	}
 
 	if (phy->set_cca_ed_level) {
-		rc = phy->set_cca_ed_level(phy, priv->mac_params.cca_ed_level);
+		rc = phy->set_cca_ed_level(phy, sdata->mac_params.cca_ed_level);
 		if (rc < 0)
 			goto out;
 	}
 
 	if (phy->set_csma_params) {
-		rc = phy->set_csma_params(phy, priv->mac_params.min_be,
-					  priv->mac_params.max_be,
-					  priv->mac_params.csma_retries);
+		rc = phy->set_csma_params(phy, sdata->mac_params.min_be,
+					  sdata->mac_params.max_be,
+					  sdata->mac_params.csma_retries);
 		if (rc < 0)
 			goto out;
 	}
 
 	if (phy->set_frame_retries) {
 		rc = phy->set_frame_retries(phy,
-					    priv->mac_params.frame_retries);
+					    sdata->mac_params.frame_retries);
 		if (rc < 0)
 			goto out;
 	}
@@ -201,14 +201,14 @@ out:
 	return rc;
 }
 
-static int mac802154_set_header_security(struct mac802154_sub_if_data *priv,
+static int mac802154_set_header_security(struct ieee802154_sub_if_data *sdata,
 					 struct ieee802154_hdr *hdr,
 					 const struct ieee802154_mac_cb *cb)
 {
 	struct ieee802154_llsec_params params;
 	u8 level;
 
-	mac802154_llsec_get_params(&priv->sec, &params);
+	mac802154_llsec_get_params(&sdata->sec, &params);
 
 	if (!params.enabled && cb->secen_override && cb->secen)
 		return -EINVAL;
@@ -241,7 +241,7 @@ static int mac802154_header_create(struct sk_buff *skb,
 				   unsigned len)
 {
 	struct ieee802154_hdr hdr;
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 	struct ieee802154_mac_cb *cb = mac_cb(skb);
 	int hlen;
 
@@ -254,25 +254,25 @@ static int mac802154_header_create(struct sk_buff *skb,
 	hdr.fc.ack_request = cb->ackreq;
 	hdr.seq = ieee802154_mlme_ops(dev)->get_dsn(dev);
 
-	if (mac802154_set_header_security(priv, &hdr, cb) < 0)
+	if (mac802154_set_header_security(sdata, &hdr, cb) < 0)
 		return -EINVAL;
 
 	if (!saddr) {
-		spin_lock_bh(&priv->mib_lock);
+		spin_lock_bh(&sdata->mib_lock);
 
-		if (priv->short_addr == cpu_to_le16(IEEE802154_ADDR_BROADCAST) ||
-		    priv->short_addr == cpu_to_le16(IEEE802154_ADDR_UNDEF) ||
-		    priv->pan_id == cpu_to_le16(IEEE802154_PANID_BROADCAST)) {
+		if (sdata->short_addr == cpu_to_le16(IEEE802154_ADDR_BROADCAST) ||
+		    sdata->short_addr == cpu_to_le16(IEEE802154_ADDR_UNDEF) ||
+		    sdata->pan_id == cpu_to_le16(IEEE802154_PANID_BROADCAST)) {
 			hdr.source.mode = IEEE802154_ADDR_LONG;
-			hdr.source.extended_addr = priv->extended_addr;
+			hdr.source.extended_addr = sdata->extended_addr;
 		} else {
 			hdr.source.mode = IEEE802154_ADDR_SHORT;
-			hdr.source.short_addr = priv->short_addr;
+			hdr.source.short_addr = sdata->short_addr;
 		}
 
-		hdr.source.pan_id = priv->pan_id;
+		hdr.source.pan_id = sdata->pan_id;
 
-		spin_unlock_bh(&priv->mib_lock);
+		spin_unlock_bh(&sdata->mib_lock);
 	} else {
 		hdr.source = *(const struct ieee802154_addr *)saddr;
 	}
@@ -310,16 +310,16 @@ mac802154_header_parse(const struct sk_buff *skb, unsigned char *haddr)
 static netdev_tx_t
 mac802154_wpan_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct mac802154_sub_if_data *priv;
+	struct ieee802154_sub_if_data *sdata;
 	u8 chan, page;
 	int rc;
 
-	priv = netdev_priv(dev);
+	sdata = netdev_priv(dev);
 
-	spin_lock_bh(&priv->mib_lock);
-	chan = priv->chan;
-	page = priv->page;
-	spin_unlock_bh(&priv->mib_lock);
+	spin_lock_bh(&sdata->mib_lock);
+	chan = sdata->chan;
+	page = sdata->page;
+	spin_unlock_bh(&sdata->mib_lock);
 
 	if (chan == MAC802154_CHAN_NONE ||
 	    page >= WPAN_NUM_PAGES ||
@@ -328,7 +328,7 @@ mac802154_wpan_xmit(struct sk_buff *skb, struct net_device *dev)
 		return NETDEV_TX_OK;
 	}
 
-	rc = mac802154_llsec_encrypt(&priv->sec, skb);
+	rc = mac802154_llsec_encrypt(&sdata->sec, skb);
 	if (rc) {
 		pr_warn("encryption failed: %i\n", rc);
 		kfree_skb(skb);
@@ -339,7 +339,7 @@ mac802154_wpan_xmit(struct sk_buff *skb, struct net_device *dev)
 	dev->stats.tx_packets++;
 	dev->stats.tx_bytes += skb->len;
 
-	return mac802154_tx(priv->hw, skb, page, chan);
+	return mac802154_tx(sdata->hw, skb, page, chan);
 }
 
 static struct header_ops mac802154_header_ops = {
@@ -357,16 +357,16 @@ static const struct net_device_ops mac802154_wpan_ops = {
 
 static void mac802154_wpan_free(struct net_device *dev)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 
-	mac802154_llsec_destroy(&priv->sec);
+	mac802154_llsec_destroy(&sdata->sec);
 
 	free_netdev(dev);
 }
 
 void mac802154_wpan_setup(struct net_device *dev)
 {
-	struct mac802154_sub_if_data *priv;
+	struct ieee802154_sub_if_data *sdata;
 
 	dev->addr_len		= IEEE802154_ADDR_LEN;
 	memset(dev->broadcast, 0xff, IEEE802154_ADDR_LEN);
@@ -384,28 +384,29 @@ void mac802154_wpan_setup(struct net_device *dev)
 	dev->netdev_ops		= &mac802154_wpan_ops;
 	dev->ml_priv		= &mac802154_mlme_wpan;
 
-	priv = netdev_priv(dev);
-	priv->type = IEEE802154_DEV_WPAN;
+	sdata = netdev_priv(dev);
+	sdata->type = IEEE802154_DEV_WPAN;
 
-	priv->chan = MAC802154_CHAN_NONE;
-	priv->page = 0;
+	sdata->chan = MAC802154_CHAN_NONE;
+	sdata->page = 0;
 
-	spin_lock_init(&priv->mib_lock);
-	mutex_init(&priv->sec_mtx);
+	spin_lock_init(&sdata->mib_lock);
+	mutex_init(&sdata->sec_mtx);
 
-	get_random_bytes(&priv->bsn, 1);
-	get_random_bytes(&priv->dsn, 1);
+	get_random_bytes(&sdata->bsn, 1);
+	get_random_bytes(&sdata->dsn, 1);
 
 	/* defaults per 802.15.4-2011 */
-	priv->mac_params.min_be = 3;
-	priv->mac_params.max_be = 5;
-	priv->mac_params.csma_retries = 4;
-	priv->mac_params.frame_retries = -1; /* for compatibility, actual default is 3 */
+	sdata->mac_params.min_be = 3;
+	sdata->mac_params.max_be = 5;
+	sdata->mac_params.csma_retries = 4;
+	/* for compatibility, actual default is 3 */
+	sdata->mac_params.frame_retries = -1;
 
-	priv->pan_id = cpu_to_le16(IEEE802154_PANID_BROADCAST);
-	priv->short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
+	sdata->pan_id = cpu_to_le16(IEEE802154_PANID_BROADCAST);
+	sdata->short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
 
-	mac802154_llsec_init(&priv->sec);
+	mac802154_llsec_init(&sdata->sec);
 }
 
 static int mac802154_process_data(struct net_device *dev, struct sk_buff *skb)
@@ -414,7 +415,7 @@ static int mac802154_process_data(struct net_device *dev, struct sk_buff *skb)
 }
 
 static int
-mac802154_subif_frame(struct mac802154_sub_if_data *sdata, struct sk_buff *skb,
+mac802154_subif_frame(struct ieee802154_sub_if_data *sdata, struct sk_buff *skb,
 		      const struct ieee802154_hdr *hdr)
 {
 	__le16 span, sshort;
@@ -568,7 +569,7 @@ static int mac802154_parse_frame_start(struct sk_buff *skb,
 void mac802154_wpans_rx(struct ieee802154_local *local, struct sk_buff *skb)
 {
 	int ret;
-	struct mac802154_sub_if_data *sdata;
+	struct ieee802154_sub_if_data *sdata;
 	struct ieee802154_hdr hdr;
 
 	ret = mac802154_parse_frame_start(skb, &hdr);
diff --git a/net/mac802154/mac_cmd.c b/net/mac802154/mac_cmd.c
index ad09d54..bccaefb 100644
--- a/net/mac802154/mac_cmd.c
+++ b/net/mac802154/mac_cmd.c
@@ -75,11 +75,11 @@ static int mac802154_mlme_start_req(struct net_device *dev,
 
 static struct wpan_phy *mac802154_get_phy(const struct net_device *dev)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
-	return to_phy(get_device(&priv->hw->phy->dev));
+	return to_phy(get_device(&sdata->hw->phy->dev));
 }
 
 static struct ieee802154_llsec_ops mac802154_llsec_ops = {
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 387d4cf..6f630d4 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -31,28 +31,28 @@
 
 int mac802154_slave_open(struct net_device *dev)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
-	struct mac802154_sub_if_data *subif;
-	struct ieee802154_local *local = priv->hw;
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_sub_if_data *subif;
+	struct ieee802154_local *local = sdata->hw;
 	int res = 0;
 
 	ASSERT_RTNL();
 
-	if (priv->type == IEEE802154_DEV_WPAN) {
-		mutex_lock(&priv->hw->slaves_mtx);
-		list_for_each_entry(subif, &priv->hw->slaves, list) {
-			if (subif != priv && subif->type == priv->type &&
+	if (sdata->type == IEEE802154_DEV_WPAN) {
+		mutex_lock(&sdata->hw->slaves_mtx);
+		list_for_each_entry(subif, &sdata->hw->slaves, list) {
+			if (subif != sdata && subif->type == sdata->type &&
 			    subif->running) {
-				mutex_unlock(&priv->hw->slaves_mtx);
+				mutex_unlock(&sdata->hw->slaves_mtx);
 				return -EBUSY;
 			}
 		}
-		mutex_unlock(&priv->hw->slaves_mtx);
+		mutex_unlock(&sdata->hw->slaves_mtx);
 	}
 
-	mutex_lock(&priv->hw->slaves_mtx);
-	priv->running = true;
-	mutex_unlock(&priv->hw->slaves_mtx);
+	mutex_lock(&sdata->hw->slaves_mtx);
+	sdata->running = true;
+	mutex_unlock(&sdata->hw->slaves_mtx);
 
 	if (local->open_count++ == 0) {
 		res = local->ops->start(&local->hw);
@@ -74,23 +74,23 @@ int mac802154_slave_open(struct net_device *dev)
 	netif_start_queue(dev);
 	return 0;
 err:
-	priv->hw->open_count--;
+	sdata->hw->open_count--;
 
 	return res;
 }
 
 int mac802154_slave_close(struct net_device *dev)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
-	struct ieee802154_local *local = priv->hw;
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_local *local = sdata->hw;
 
 	ASSERT_RTNL();
 
 	netif_stop_queue(dev);
 
-	mutex_lock(&priv->hw->slaves_mtx);
-	priv->running = false;
-	mutex_unlock(&priv->hw->slaves_mtx);
+	mutex_lock(&sdata->hw->slaves_mtx);
+	sdata->running = false;
+	mutex_unlock(&sdata->hw->slaves_mtx);
 
 	if (!--local->open_count)
 		local->ops->stop(&local->hw);
@@ -101,15 +101,15 @@ int mac802154_slave_close(struct net_device *dev)
 static int
 mac802154_netdev_register(struct wpan_phy *phy, struct net_device *dev)
 {
-	struct mac802154_sub_if_data *priv;
+	struct ieee802154_sub_if_data *sdata;
 	struct ieee802154_local *local;
 	int err;
 
 	local = wpan_phy_priv(phy);
 
-	priv = netdev_priv(dev);
-	priv->dev = dev;
-	priv->hw = local;
+	sdata = netdev_priv(dev);
+	sdata->dev = dev;
+	sdata->hw = local;
 
 	dev->needed_headroom = local->hw.extra_tx_headroom;
 
@@ -128,7 +128,7 @@ mac802154_netdev_register(struct wpan_phy *phy, struct net_device *dev)
 
 	rtnl_lock();
 	mutex_lock(&local->slaves_mtx);
-	list_add_tail_rcu(&priv->list, &local->slaves);
+	list_add_tail_rcu(&sdata->list, &local->slaves);
 	mutex_unlock(&local->slaves_mtx);
 	rtnl_unlock();
 
@@ -138,7 +138,7 @@ mac802154_netdev_register(struct wpan_phy *phy, struct net_device *dev)
 static void
 mac802154_del_iface(struct wpan_phy *phy, struct net_device *dev)
 {
-	struct mac802154_sub_if_data *sdata;
+	struct ieee802154_sub_if_data *sdata;
 
 	ASSERT_RTNL();
 
@@ -162,12 +162,12 @@ mac802154_add_iface(struct wpan_phy *phy, const char *name, int type)
 
 	switch (type) {
 	case IEEE802154_DEV_MONITOR:
-		dev = alloc_netdev(sizeof(struct mac802154_sub_if_data),
+		dev = alloc_netdev(sizeof(struct ieee802154_sub_if_data),
 				   name, NET_NAME_UNKNOWN,
 				   mac802154_monitor_setup);
 		break;
 	case IEEE802154_DEV_WPAN:
-		dev = alloc_netdev(sizeof(struct mac802154_sub_if_data),
+		dev = alloc_netdev(sizeof(struct ieee802154_sub_if_data),
 				   name, NET_NAME_UNKNOWN,
 				   mac802154_wpan_setup);
 		break;
@@ -382,7 +382,7 @@ EXPORT_SYMBOL(ieee802154_register_hw);
 void ieee802154_unregister_hw(struct ieee802154_hw *hw)
 {
 	struct ieee802154_local *local = mac802154_to_priv(hw);
-	struct mac802154_sub_if_data *sdata, *next;
+	struct ieee802154_sub_if_data *sdata, *next;
 
 	flush_workqueue(local->dev_workqueue);
 	destroy_workqueue(local->dev_workqueue);
diff --git a/net/mac802154/mib.c b/net/mac802154/mib.c
index 5d9592a..ef05b3b 100644
--- a/net/mac802154/mib.c
+++ b/net/mac802154/mib.c
@@ -38,11 +38,11 @@ struct hw_addr_filt_notify_work {
 
 static struct ieee802154_local *mac802154_slave_get_priv(struct net_device *dev)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
-	return priv->hw;
+	return sdata->hw;
 }
 
 static void hw_addr_notify(struct work_struct *work)
@@ -62,7 +62,7 @@ static void hw_addr_notify(struct work_struct *work)
 
 static void set_hw_addr_filt(struct net_device *dev, unsigned long changed)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 	struct hw_addr_filt_notify_work *work;
 
 	work = kzalloc(sizeof(*work), GFP_ATOMIC);
@@ -72,92 +72,92 @@ static void set_hw_addr_filt(struct net_device *dev, unsigned long changed)
 	INIT_WORK(&work->work, hw_addr_notify);
 	work->dev = dev;
 	work->changed = changed;
-	queue_work(priv->hw->dev_workqueue, &work->work);
+	queue_work(sdata->hw->dev_workqueue, &work->work);
 }
 
 void mac802154_dev_set_short_addr(struct net_device *dev, __le16 val)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
-	spin_lock_bh(&priv->mib_lock);
-	priv->short_addr = val;
-	spin_unlock_bh(&priv->mib_lock);
+	spin_lock_bh(&sdata->mib_lock);
+	sdata->short_addr = val;
+	spin_unlock_bh(&sdata->mib_lock);
 
-	if ((priv->hw->ops->set_hw_addr_filt) &&
-	    (priv->hw->hw.hw_filt.short_addr != priv->short_addr)) {
-		priv->hw->hw.hw_filt.short_addr = priv->short_addr;
+	if ((sdata->hw->ops->set_hw_addr_filt) &&
+	    (sdata->hw->hw.hw_filt.short_addr != sdata->short_addr)) {
+		sdata->hw->hw.hw_filt.short_addr = sdata->short_addr;
 		set_hw_addr_filt(dev, IEEE802154_AFILT_SADDR_CHANGED);
 	}
 }
 
 __le16 mac802154_dev_get_short_addr(const struct net_device *dev)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 	__le16 ret;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
-	spin_lock_bh(&priv->mib_lock);
-	ret = priv->short_addr;
-	spin_unlock_bh(&priv->mib_lock);
+	spin_lock_bh(&sdata->mib_lock);
+	ret = sdata->short_addr;
+	spin_unlock_bh(&sdata->mib_lock);
 
 	return ret;
 }
 
 void mac802154_dev_set_ieee_addr(struct net_device *dev)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
-	struct ieee802154_local *local = priv->hw;
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
+	struct ieee802154_local *local = sdata->hw;
 
-	priv->extended_addr = ieee802154_devaddr_from_raw(dev->dev_addr);
+	sdata->extended_addr = ieee802154_devaddr_from_raw(dev->dev_addr);
 
 	if (local->ops->set_hw_addr_filt &&
-	    local->hw.hw_filt.ieee_addr != priv->extended_addr) {
-		local->hw.hw_filt.ieee_addr = priv->extended_addr;
+	    local->hw.hw_filt.ieee_addr != sdata->extended_addr) {
+		local->hw.hw_filt.ieee_addr = sdata->extended_addr;
 		set_hw_addr_filt(dev, IEEE802154_AFILT_IEEEADDR_CHANGED);
 	}
 }
 
 __le16 mac802154_dev_get_pan_id(const struct net_device *dev)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 	__le16 ret;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
-	spin_lock_bh(&priv->mib_lock);
-	ret = priv->pan_id;
-	spin_unlock_bh(&priv->mib_lock);
+	spin_lock_bh(&sdata->mib_lock);
+	ret = sdata->pan_id;
+	spin_unlock_bh(&sdata->mib_lock);
 
 	return ret;
 }
 
 void mac802154_dev_set_pan_id(struct net_device *dev, __le16 val)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
-	spin_lock_bh(&priv->mib_lock);
-	priv->pan_id = val;
-	spin_unlock_bh(&priv->mib_lock);
+	spin_lock_bh(&sdata->mib_lock);
+	sdata->pan_id = val;
+	spin_unlock_bh(&sdata->mib_lock);
 
-	if ((priv->hw->ops->set_hw_addr_filt) &&
-	    (priv->hw->hw.hw_filt.pan_id != priv->pan_id)) {
-		priv->hw->hw.hw_filt.pan_id = priv->pan_id;
+	if ((sdata->hw->ops->set_hw_addr_filt) &&
+	    (sdata->hw->hw.hw_filt.pan_id != sdata->pan_id)) {
+		sdata->hw->hw.hw_filt.pan_id = sdata->pan_id;
 		set_hw_addr_filt(dev, IEEE802154_AFILT_PANID_CHANGED);
 	}
 }
 
 u8 mac802154_dev_get_dsn(const struct net_device *dev)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
-	return priv->dsn++;
+	return sdata->dsn++;
 }
 
 static void phy_chan_notify(struct work_struct *work)
@@ -165,38 +165,38 @@ static void phy_chan_notify(struct work_struct *work)
 	struct phy_chan_notify_work *nw = container_of(work,
 					  struct phy_chan_notify_work, work);
 	struct ieee802154_local *local = mac802154_slave_get_priv(nw->dev);
-	struct mac802154_sub_if_data *priv = netdev_priv(nw->dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(nw->dev);
 	int res;
 
-	mutex_lock(&priv->hw->phy->pib_lock);
-	res = local->ops->set_channel(&local->hw, priv->page, priv->chan);
+	mutex_lock(&sdata->hw->phy->pib_lock);
+	res = local->ops->set_channel(&local->hw, sdata->page, sdata->chan);
 	if (res) {
 		pr_debug("set_channel failed\n");
 	} else {
-		priv->hw->phy->current_channel = priv->chan;
-		priv->hw->phy->current_page = priv->page;
+		sdata->hw->phy->current_channel = sdata->chan;
+		sdata->hw->phy->current_page = sdata->page;
 	}
-	mutex_unlock(&priv->hw->phy->pib_lock);
+	mutex_unlock(&sdata->hw->phy->pib_lock);
 
 	kfree(nw);
 }
 
 void mac802154_dev_set_page_channel(struct net_device *dev, u8 page, u8 chan)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 	struct phy_chan_notify_work *work;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
-	spin_lock_bh(&priv->mib_lock);
-	priv->page = page;
-	priv->chan = chan;
-	spin_unlock_bh(&priv->mib_lock);
+	spin_lock_bh(&sdata->mib_lock);
+	sdata->page = page;
+	sdata->chan = chan;
+	spin_unlock_bh(&sdata->mib_lock);
 
-	mutex_lock(&priv->hw->phy->pib_lock);
-	if (priv->hw->phy->current_channel != priv->chan ||
-	    priv->hw->phy->current_page != priv->page) {
-		mutex_unlock(&priv->hw->phy->pib_lock);
+	mutex_lock(&sdata->hw->phy->pib_lock);
+	if (sdata->hw->phy->current_channel != sdata->chan ||
+	    sdata->hw->phy->current_page != sdata->page) {
+		mutex_unlock(&sdata->hw->phy->pib_lock);
 
 		work = kzalloc(sizeof(*work), GFP_ATOMIC);
 		if (!work)
@@ -204,9 +204,9 @@ void mac802154_dev_set_page_channel(struct net_device *dev, u8 page, u8 chan)
 
 		INIT_WORK(&work->work, phy_chan_notify);
 		work->dev = dev;
-		queue_work(priv->hw->dev_workqueue, &work->work);
+		queue_work(sdata->hw->dev_workqueue, &work->work);
 	} else {
-		mutex_unlock(&priv->hw->phy->pib_lock);
+		mutex_unlock(&sdata->hw->phy->pib_lock);
 	}
 }
 
@@ -214,14 +214,14 @@ void mac802154_dev_set_page_channel(struct net_device *dev, u8 page, u8 chan)
 int mac802154_get_params(struct net_device *dev,
 			 struct ieee802154_llsec_params *params)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
-	mutex_lock(&priv->sec_mtx);
-	res = mac802154_llsec_get_params(&priv->sec, params);
-	mutex_unlock(&priv->sec_mtx);
+	mutex_lock(&sdata->sec_mtx);
+	res = mac802154_llsec_get_params(&sdata->sec, params);
+	mutex_unlock(&sdata->sec_mtx);
 
 	return res;
 }
@@ -230,14 +230,14 @@ int mac802154_set_params(struct net_device *dev,
 			 const struct ieee802154_llsec_params *params,
 			 int changed)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
-	mutex_lock(&priv->sec_mtx);
-	res = mac802154_llsec_set_params(&priv->sec, params, changed);
-	mutex_unlock(&priv->sec_mtx);
+	mutex_lock(&sdata->sec_mtx);
+	res = mac802154_llsec_set_params(&sdata->sec, params, changed);
+	mutex_unlock(&sdata->sec_mtx);
 
 	return res;
 }
@@ -247,14 +247,14 @@ int mac802154_add_key(struct net_device *dev,
 		      const struct ieee802154_llsec_key_id *id,
 		      const struct ieee802154_llsec_key *key)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
-	mutex_lock(&priv->sec_mtx);
-	res = mac802154_llsec_key_add(&priv->sec, id, key);
-	mutex_unlock(&priv->sec_mtx);
+	mutex_lock(&sdata->sec_mtx);
+	res = mac802154_llsec_key_add(&sdata->sec, id, key);
+	mutex_unlock(&sdata->sec_mtx);
 
 	return res;
 }
@@ -262,14 +262,14 @@ int mac802154_add_key(struct net_device *dev,
 int mac802154_del_key(struct net_device *dev,
 		      const struct ieee802154_llsec_key_id *id)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
-	mutex_lock(&priv->sec_mtx);
-	res = mac802154_llsec_key_del(&priv->sec, id);
-	mutex_unlock(&priv->sec_mtx);
+	mutex_lock(&sdata->sec_mtx);
+	res = mac802154_llsec_key_del(&sdata->sec, id);
+	mutex_unlock(&sdata->sec_mtx);
 
 	return res;
 }
@@ -278,28 +278,28 @@ int mac802154_del_key(struct net_device *dev,
 int mac802154_add_dev(struct net_device *dev,
 		      const struct ieee802154_llsec_device *llsec_dev)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
-	mutex_lock(&priv->sec_mtx);
-	res = mac802154_llsec_dev_add(&priv->sec, llsec_dev);
-	mutex_unlock(&priv->sec_mtx);
+	mutex_lock(&sdata->sec_mtx);
+	res = mac802154_llsec_dev_add(&sdata->sec, llsec_dev);
+	mutex_unlock(&sdata->sec_mtx);
 
 	return res;
 }
 
 int mac802154_del_dev(struct net_device *dev, __le64 dev_addr)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
-	mutex_lock(&priv->sec_mtx);
-	res = mac802154_llsec_dev_del(&priv->sec, dev_addr);
-	mutex_unlock(&priv->sec_mtx);
+	mutex_lock(&sdata->sec_mtx);
+	res = mac802154_llsec_dev_del(&sdata->sec, dev_addr);
+	mutex_unlock(&sdata->sec_mtx);
 
 	return res;
 }
@@ -309,14 +309,14 @@ int mac802154_add_devkey(struct net_device *dev,
 			 __le64 device_addr,
 			 const struct ieee802154_llsec_device_key *key)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
-	mutex_lock(&priv->sec_mtx);
-	res = mac802154_llsec_devkey_add(&priv->sec, device_addr, key);
-	mutex_unlock(&priv->sec_mtx);
+	mutex_lock(&sdata->sec_mtx);
+	res = mac802154_llsec_devkey_add(&sdata->sec, device_addr, key);
+	mutex_unlock(&sdata->sec_mtx);
 
 	return res;
 }
@@ -325,14 +325,14 @@ int mac802154_del_devkey(struct net_device *dev,
 			 __le64 device_addr,
 			 const struct ieee802154_llsec_device_key *key)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
-	mutex_lock(&priv->sec_mtx);
-	res = mac802154_llsec_devkey_del(&priv->sec, device_addr, key);
-	mutex_unlock(&priv->sec_mtx);
+	mutex_lock(&sdata->sec_mtx);
+	res = mac802154_llsec_devkey_del(&sdata->sec, device_addr, key);
+	mutex_unlock(&sdata->sec_mtx);
 
 	return res;
 }
@@ -341,14 +341,14 @@ int mac802154_del_devkey(struct net_device *dev,
 int mac802154_add_seclevel(struct net_device *dev,
 			   const struct ieee802154_llsec_seclevel *sl)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
-	mutex_lock(&priv->sec_mtx);
-	res = mac802154_llsec_seclevel_add(&priv->sec, sl);
-	mutex_unlock(&priv->sec_mtx);
+	mutex_lock(&sdata->sec_mtx);
+	res = mac802154_llsec_seclevel_add(&sdata->sec, sl);
+	mutex_unlock(&sdata->sec_mtx);
 
 	return res;
 }
@@ -356,14 +356,14 @@ int mac802154_add_seclevel(struct net_device *dev,
 int mac802154_del_seclevel(struct net_device *dev,
 			   const struct ieee802154_llsec_seclevel *sl)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 	int res;
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
-	mutex_lock(&priv->sec_mtx);
-	res = mac802154_llsec_seclevel_del(&priv->sec, sl);
-	mutex_unlock(&priv->sec_mtx);
+	mutex_lock(&sdata->sec_mtx);
+	res = mac802154_llsec_seclevel_del(&sdata->sec, sl);
+	mutex_unlock(&sdata->sec_mtx);
 
 	return res;
 }
@@ -371,28 +371,28 @@ int mac802154_del_seclevel(struct net_device *dev,
 
 void mac802154_lock_table(struct net_device *dev)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
-	mutex_lock(&priv->sec_mtx);
+	mutex_lock(&sdata->sec_mtx);
 }
 
 void mac802154_get_table(struct net_device *dev,
 			 struct ieee802154_llsec_table **t)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
-	*t = &priv->sec.table;
+	*t = &sdata->sec.table;
 }
 
 void mac802154_unlock_table(struct net_device *dev)
 {
-	struct mac802154_sub_if_data *priv = netdev_priv(dev);
+	struct ieee802154_sub_if_data *sdata = netdev_priv(dev);
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
-	mutex_unlock(&priv->sec_mtx);
+	mutex_unlock(&sdata->sec_mtx);
 }
diff --git a/net/mac802154/monitor.c b/net/mac802154/monitor.c
index a107fd2..bd63e12 100644
--- a/net/mac802154/monitor.c
+++ b/net/mac802154/monitor.c
@@ -33,14 +33,14 @@
 static netdev_tx_t mac802154_monitor_xmit(struct sk_buff *skb,
 					  struct net_device *dev)
 {
-	struct mac802154_sub_if_data *priv;
+	struct ieee802154_sub_if_data *sdata;
 	u8 chan, page;
 
-	priv = netdev_priv(dev);
+	sdata = netdev_priv(dev);
 
 	/* FIXME: locking */
-	chan = priv->hw->phy->current_channel;
-	page = priv->hw->phy->current_page;
+	chan = sdata->hw->phy->current_channel;
+	page = sdata->hw->phy->current_page;
 
 	if (chan == MAC802154_CHAN_NONE) /* not initialized */
 		return NETDEV_TX_OK;
@@ -53,14 +53,14 @@ static netdev_tx_t mac802154_monitor_xmit(struct sk_buff *skb,
 	dev->stats.tx_packets++;
 	dev->stats.tx_bytes += skb->len;
 
-	return mac802154_tx(priv->hw, skb, page, chan);
+	return mac802154_tx(sdata->hw, skb, page, chan);
 }
 
 
 void mac802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
 {
 	struct sk_buff *skb2;
-	struct mac802154_sub_if_data *sdata;
+	struct ieee802154_sub_if_data *sdata;
 	u16 crc = crc_ccitt(0, skb->data, skb->len);
 	u8 *data;
 
@@ -90,7 +90,7 @@ static const struct net_device_ops mac802154_monitor_ops = {
 
 void mac802154_monitor_setup(struct net_device *dev)
 {
-	struct mac802154_sub_if_data *priv;
+	struct ieee802154_sub_if_data *sdata;
 
 	dev->addr_len		= 0;
 	dev->hard_header_len	= 0;
@@ -105,9 +105,9 @@ void mac802154_monitor_setup(struct net_device *dev)
 	dev->netdev_ops		= &mac802154_monitor_ops;
 	dev->ml_priv		= &mac802154_mlme_reduced;
 
-	priv = netdev_priv(dev);
-	priv->type = IEEE802154_DEV_MONITOR;
+	sdata = netdev_priv(dev);
+	sdata->type = IEEE802154_DEV_MONITOR;
 
-	priv->chan = MAC802154_CHAN_NONE; /* not initialized */
-	priv->page = 0;
+	sdata->chan = MAC802154_CHAN_NONE; /* not initialized */
+	sdata->page = 0;
 }
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index d4c92bd..d20dadd 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -41,7 +41,7 @@ struct xmit_work {
 static void mac802154_xmit_worker(struct work_struct *work)
 {
 	struct xmit_work *xw = container_of(work, struct xmit_work, work);
-	struct mac802154_sub_if_data *sdata;
+	struct ieee802154_sub_if_data *sdata;
 	int res;
 
 	mutex_lock(&xw->local->phy->pib_lock);
@@ -81,7 +81,7 @@ netdev_tx_t mac802154_tx(struct ieee802154_local *local, struct sk_buff *skb,
 			 u8 page, u8 chan)
 {
 	struct xmit_work *work;
-	struct mac802154_sub_if_data *sdata;
+	struct ieee802154_sub_if_data *sdata;
 
 	if (!(local->phy->channels_supported[page] & (1 << chan))) {
 		WARN_ON(1);
-- 
2.1.2

