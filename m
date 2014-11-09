Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:48698 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbaKIHhZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 9 Nov 2014 02:37:25 -0500
Received: by mail-wi0-f170.google.com with SMTP id r20so7523209wiv.3
        for <linux-wpan@vger.kernel.org>; Sat, 08 Nov 2014 23:37:24 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 01/15] mac802154: move mac pib attributes into wpan_dev
Date: Sun,  9 Nov 2014 08:36:45 +0100
Message-Id: <1415518619-4370-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
References: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch moves all mac pib attributes into the wpan_dev struct.
Furthermore we can easier access these attributes over the netdev
802154_ptr pointer. Currently this is only possible over a complicated
callback structure in mac802154 because subif data structure is
accessable inside mac802154 only.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h      | 24 +++++++++++++++----
 net/mac802154/ieee802154_i.h | 10 --------
 net/mac802154/iface.c        | 55 +++++++++++++++++++++++++-------------------
 net/mac802154/mib.c          | 10 ++++----
 net/mac802154/rx.c           |  7 +++---
 5 files changed, 59 insertions(+), 47 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 9d99b96..ac8dd3b 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -52,14 +52,9 @@ struct wpan_phy {
 	u32 channels_supported[32];
 	s8 transmit_power;
 	u8 cca_mode;
-	u8 min_be;
-	u8 max_be;
-	u8 csma_retries;
-	s8 frame_retries;
 
 	__le64 perm_extended_addr;
 
-	bool lbt;
 	s32 cca_ed_level;
 
 	struct device dev;
@@ -69,6 +64,25 @@ struct wpan_phy {
 
 struct wpan_dev {
 	struct wpan_phy *wpan_phy;
+
+	/* MAC PIB */
+	__le16 pan_id;
+	__le16 short_addr;
+	__le64 extended_addr;
+
+	/* MAC BSN field */
+	u8 bsn;
+	/* MAC DSN field */
+	u8 dsn;
+
+	u8 min_be;
+	u8 max_be;
+	u8 csma_retries;
+	s8 frame_retries;
+
+	bool lbt;
+
+	bool promiscuous_mode;
 };
 
 #define to_phy(_dev)	container_of(_dev, struct wpan_phy, dev)
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 4acacea..803f529 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -84,18 +84,8 @@ struct ieee802154_sub_if_data {
 
 	spinlock_t mib_lock;
 
-	__le16 pan_id;
-	__le16 short_addr;
-	__le64 extended_addr;
-	bool promiscuous_mode;
-
 	struct ieee802154_mac_params mac_params;
 
-	/* MAC BSN field */
-	u8 bsn;
-	/* MAC DSN field */
-	u8 dsn;
-
 	/* protects sec from concurrent access by netlink. access by
 	 * encrypt/decrypt/header_create safe without additional protection.
 	 */
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 384f4bb..6669da7 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -35,16 +35,17 @@ static int mac802154_wpan_update_llsec(struct net_device *dev)
 {
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	struct ieee802154_mlme_ops *ops = ieee802154_mlme_ops(dev);
+	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
 	int rc = 0;
 
 	if (ops->llsec) {
 		struct ieee802154_llsec_params params;
 		int changed = 0;
 
-		params.pan_id = sdata->pan_id;
+		params.pan_id = wpan_dev->pan_id;
 		changed |= IEEE802154_LLSEC_PARAM_PAN_ID;
 
-		params.hwaddr = sdata->extended_addr;
+		params.hwaddr = wpan_dev->extended_addr;
 		changed |= IEEE802154_LLSEC_PARAM_HWADDR;
 
 		rc = ops->llsec->set_params(dev, &params, changed);
@@ -57,6 +58,7 @@ static int
 mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
+	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
 	struct sockaddr_ieee802154 *sa =
 		(struct sockaddr_ieee802154 *)&ifr->ifr_addr;
 	int err = -ENOIOCTLCMD;
@@ -68,8 +70,8 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 	{
 		u16 pan_id, short_addr;
 
-		pan_id = le16_to_cpu(sdata->pan_id);
-		short_addr = le16_to_cpu(sdata->short_addr);
+		pan_id = le16_to_cpu(wpan_dev->pan_id);
+		short_addr = le16_to_cpu(wpan_dev->short_addr);
 		if (pan_id == IEEE802154_PANID_BROADCAST ||
 		    short_addr == IEEE802154_ADDR_BROADCAST) {
 			err = -EADDRNOTAVAIL;
@@ -96,8 +98,8 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 			break;
 		}
 
-		sdata->pan_id = cpu_to_le16(sa->addr.pan_id);
-		sdata->short_addr = cpu_to_le16(sa->addr.short_addr);
+		wpan_dev->pan_id = cpu_to_le16(sa->addr.pan_id);
+		wpan_dev->short_addr = cpu_to_le16(sa->addr.short_addr);
 
 		err = mac802154_wpan_update_llsec(dev);
 		break;
@@ -121,7 +123,7 @@ static int mac802154_wpan_mac_addr(struct net_device *dev, void *p)
 		return -EINVAL;
 
 	memcpy(dev->dev_addr, addr->sa_data, dev->addr_len);
-	sdata->extended_addr = extended_addr;
+	sdata->wpan_dev.extended_addr = extended_addr;
 
 	return mac802154_wpan_update_llsec(dev);
 }
@@ -172,6 +174,7 @@ static int mac802154_wpan_open(struct net_device *dev)
 	int rc;
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	struct ieee802154_local *local = sdata->local;
+	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
 	struct wpan_phy *phy = sdata->local->phy;
 
 	rc = mac802154_slave_open(dev);
@@ -181,21 +184,22 @@ static int mac802154_wpan_open(struct net_device *dev)
 	mutex_lock(&phy->pib_lock);
 
 	if (local->hw.flags & IEEE802154_HW_PROMISCUOUS) {
-		rc = drv_set_promiscuous_mode(local, sdata->promiscuous_mode);
+		rc = drv_set_promiscuous_mode(local,
+					      wpan_dev->promiscuous_mode);
 		if (rc < 0)
 			goto out;
 	}
 
 	if (local->hw.flags & IEEE802154_HW_AFILT) {
-		rc = drv_set_pan_id(local, sdata->pan_id);
+		rc = drv_set_pan_id(local, wpan_dev->pan_id);
 		if (rc < 0)
 			goto out;
 
-		rc = drv_set_extended_addr(local, sdata->extended_addr);
+		rc = drv_set_extended_addr(local, wpan_dev->extended_addr);
 		if (rc < 0)
 			goto out;
 
-		rc = drv_set_short_addr(local, sdata->short_addr);
+		rc = drv_set_short_addr(local, wpan_dev->short_addr);
 		if (rc < 0)
 			goto out;
 	}
@@ -288,6 +292,7 @@ static int mac802154_header_create(struct sk_buff *skb,
 {
 	struct ieee802154_hdr hdr;
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
+	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
 	struct ieee802154_mac_cb *cb = mac_cb(skb);
 	int hlen;
 
@@ -306,17 +311,17 @@ static int mac802154_header_create(struct sk_buff *skb,
 	if (!saddr) {
 		spin_lock_bh(&sdata->mib_lock);
 
-		if (sdata->short_addr == cpu_to_le16(IEEE802154_ADDR_BROADCAST) ||
-		    sdata->short_addr == cpu_to_le16(IEEE802154_ADDR_UNDEF) ||
-		    sdata->pan_id == cpu_to_le16(IEEE802154_PANID_BROADCAST)) {
+		if (wpan_dev->short_addr == cpu_to_le16(IEEE802154_ADDR_BROADCAST) ||
+		    wpan_dev->short_addr == cpu_to_le16(IEEE802154_ADDR_UNDEF) ||
+		    wpan_dev->pan_id == cpu_to_le16(IEEE802154_PANID_BROADCAST)) {
 			hdr.source.mode = IEEE802154_ADDR_LONG;
-			hdr.source.extended_addr = sdata->extended_addr;
+			hdr.source.extended_addr = wpan_dev->extended_addr;
 		} else {
 			hdr.source.mode = IEEE802154_ADDR_SHORT;
-			hdr.source.short_addr = sdata->short_addr;
+			hdr.source.short_addr = wpan_dev->short_addr;
 		}
 
-		hdr.source.pan_id = sdata->pan_id;
+		hdr.source.pan_id = wpan_dev->pan_id;
 
 		spin_unlock_bh(&sdata->mib_lock);
 	} else {
@@ -396,11 +401,13 @@ static void ieee802154_if_setup(struct net_device *dev)
 static int
 ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata, int type)
 {
+	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
+
 	/* set some type-dependent values */
 	sdata->vif.type = type;
 
-	get_random_bytes(&sdata->bsn, 1);
-	get_random_bytes(&sdata->dsn, 1);
+	get_random_bytes(&wpan_dev->bsn, 1);
+	get_random_bytes(&wpan_dev->dsn, 1);
 
 	/* defaults per 802.15.4-2011 */
 	sdata->mac_params.min_be = 3;
@@ -409,9 +416,9 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata, int type)
 	/* for compatibility, actual default is 3 */
 	sdata->mac_params.frame_retries = -1;
 
-	ieee802154_be64_to_le64(&sdata->extended_addr, sdata->dev->dev_addr);
-	sdata->pan_id = cpu_to_le16(IEEE802154_PANID_BROADCAST);
-	sdata->short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
+	ieee802154_be64_to_le64(&wpan_dev->extended_addr, sdata->dev->dev_addr);
+	wpan_dev->pan_id = cpu_to_le16(IEEE802154_PANID_BROADCAST);
+	wpan_dev->short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
 
 	switch (type) {
 	case IEEE802154_DEV_WPAN:
@@ -419,7 +426,7 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata, int type)
 		sdata->dev->destructor = mac802154_wpan_free;
 		sdata->dev->netdev_ops = &mac802154_wpan_ops;
 		sdata->dev->ml_priv = &mac802154_mlme_wpan;
-		sdata->promiscuous_mode = false;
+		wpan_dev->promiscuous_mode = false;
 
 		spin_lock_init(&sdata->mib_lock);
 		mutex_init(&sdata->sec_mtx);
@@ -429,7 +436,7 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata, int type)
 	case IEEE802154_DEV_MONITOR:
 		sdata->dev->destructor = free_netdev;
 		sdata->dev->netdev_ops = &mac802154_monitor_ops;
-		sdata->promiscuous_mode = true;
+		wpan_dev->promiscuous_mode = true;
 		break;
 	default:
 		BUG();
diff --git a/net/mac802154/mib.c b/net/mac802154/mib.c
index 6fa7491..3596b29 100644
--- a/net/mac802154/mib.c
+++ b/net/mac802154/mib.c
@@ -33,7 +33,7 @@ void mac802154_dev_set_short_addr(struct net_device *dev, __le16 val)
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
 	spin_lock_bh(&sdata->mib_lock);
-	sdata->short_addr = val;
+	sdata->wpan_dev.short_addr = val;
 	spin_unlock_bh(&sdata->mib_lock);
 }
 
@@ -45,7 +45,7 @@ __le16 mac802154_dev_get_short_addr(const struct net_device *dev)
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
 	spin_lock_bh(&sdata->mib_lock);
-	ret = sdata->short_addr;
+	ret = sdata->wpan_dev.short_addr;
 	spin_unlock_bh(&sdata->mib_lock);
 
 	return ret;
@@ -59,7 +59,7 @@ __le16 mac802154_dev_get_pan_id(const struct net_device *dev)
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
 	spin_lock_bh(&sdata->mib_lock);
-	ret = sdata->pan_id;
+	ret = sdata->wpan_dev.pan_id;
 	spin_unlock_bh(&sdata->mib_lock);
 
 	return ret;
@@ -72,7 +72,7 @@ void mac802154_dev_set_pan_id(struct net_device *dev, __le16 val)
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
 	spin_lock_bh(&sdata->mib_lock);
-	sdata->pan_id = val;
+	sdata->wpan_dev.pan_id = val;
 	spin_unlock_bh(&sdata->mib_lock);
 }
 
@@ -82,7 +82,7 @@ u8 mac802154_dev_get_dsn(const struct net_device *dev)
 
 	BUG_ON(dev->type != ARPHRD_IEEE802154);
 
-	return sdata->dsn++;
+	return sdata->wpan_dev.dsn++;
 }
 
 void mac802154_dev_set_page_channel(struct net_device *dev, u8 page, u8 chan)
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 4b54cf3..b18e755 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -42,6 +42,7 @@ static int
 ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 		       struct sk_buff *skb, const struct ieee802154_hdr *hdr)
 {
+	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
 	__le16 span, sshort;
 	int rc;
 
@@ -49,8 +50,8 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 
 	spin_lock_bh(&sdata->mib_lock);
 
-	span = sdata->pan_id;
-	sshort = sdata->short_addr;
+	span = wpan_dev->pan_id;
+	sshort = wpan_dev->short_addr;
 
 	switch (mac_cb(skb)->dest.mode) {
 	case IEEE802154_ADDR_NONE:
@@ -65,7 +66,7 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 		if (mac_cb(skb)->dest.pan_id != span &&
 		    mac_cb(skb)->dest.pan_id != cpu_to_le16(IEEE802154_PANID_BROADCAST))
 			skb->pkt_type = PACKET_OTHERHOST;
-		else if (mac_cb(skb)->dest.extended_addr == sdata->extended_addr)
+		else if (mac_cb(skb)->dest.extended_addr == wpan_dev->extended_addr)
 			skb->pkt_type = PACKET_HOST;
 		else
 			skb->pkt_type = PACKET_OTHERHOST;
-- 
2.1.3

