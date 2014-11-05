Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:33693 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbaKETwR (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 5 Nov 2014 14:52:17 -0500
Received: by mail-wg0-f49.google.com with SMTP id x13so1746351wgg.8
        for <linux-wpan@vger.kernel.org>; Wed, 05 Nov 2014 11:52:16 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 09/18] mac802154: add ieee802154_vif struct
Date: Wed,  5 Nov 2014 20:51:20 +0100
Message-Id: <1415217089-24919-10-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
References: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Varka Bhadram <varkabhadram@gmail.com>

This patch adds an ieee802154_vif similar like the ieee80211_vif which
holds the interface type and maybe further more attributes like the
ieee80211_vif structure.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c |  1 +
 drivers/net/ieee802154/cc2520.c    |  1 +
 include/net/mac802154.h            |  8 ++++++++
 net/mac802154/ieee802154_i.h       |  3 ++-
 net/mac802154/iface.c              | 11 ++++++-----
 net/mac802154/rx.c                 |  4 ++--
 6 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index f68ebba..bf47785 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1533,6 +1533,7 @@ static int at86rf230_probe(struct spi_device *spi)
 	lp->hw = hw;
 	lp->spi = spi;
 	hw->parent = &spi->dev;
+	hw->vif_data_size = sizeof(*lp);
 
 	lp->regmap = devm_regmap_init_spi(spi, &at86rf230_regmap_spi_config);
 	if (IS_ERR(lp->regmap)) {
diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 340671b..ccbb082 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -651,6 +651,7 @@ static int cc2520_register(struct cc2520_private *priv)
 	priv->hw->priv = priv;
 	priv->hw->parent = &priv->spi->dev;
 	priv->hw->extra_tx_headroom = 0;
+	priv->hw->vif_data_size = sizeof(*priv);
 
 	/* We do support only 2.4 Ghz */
 	priv->hw->phy->channels_supported[0] = 0x7FFF800;
diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 8b0c26b..10711a6 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -52,6 +52,13 @@ struct ieee802154_hw_addr_filt {
 	u8	pan_coord;
 };
 
+struct ieee802154_vif {
+	int type;
+
+	/* must be last */
+	u8 drv_priv[0] __aligned(sizeof(void *));
+};
+
 struct ieee802154_hw {
 	/* filled by the driver */
 	int	extra_tx_headroom;
@@ -62,6 +69,7 @@ struct ieee802154_hw {
 	struct	ieee802154_hw_addr_filt hw_filt;
 	void	*priv;
 	struct	wpan_phy *phy;
+	size_t vif_data_size;
 };
 
 /* Checksum is in hardware and is omitted from a packet
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 748dc5a..931f851 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -79,7 +79,6 @@ struct ieee802154_sub_if_data {
 	struct ieee802154_local *local;
 	struct net_device *dev;
 
-	int type;
 	unsigned long state;
 	char name[IFNAMSIZ];
 
@@ -103,6 +102,8 @@ struct ieee802154_sub_if_data {
 	struct mutex sec_mtx;
 
 	struct mac802154_llsec sec;
+	/* must be last, dynamically sized area in this! */
+	struct ieee802154_vif vif;
 };
 
 #define MAC802154_CHAN_NONE		0xff /* No channel is assigned */
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 2e2638e..764ce49 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -136,10 +136,11 @@ static int mac802154_slave_open(struct net_device *dev)
 
 	ASSERT_RTNL();
 
-	if (sdata->type == IEEE802154_DEV_WPAN) {
+	if (sdata->vif.type == IEEE802154_DEV_WPAN) {
 		mutex_lock(&sdata->local->iflist_mtx);
 		list_for_each_entry(subif, &sdata->local->interfaces, list) {
-			if (subif != sdata && subif->type == sdata->type &&
+			if (subif != sdata &&
+			    subif->vif.type == sdata->vif.type &&
 			    ieee802154_sdata_running(subif)) {
 				mutex_unlock(&sdata->local->iflist_mtx);
 				return -EBUSY;
@@ -397,7 +398,7 @@ static int
 ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata, int type)
 {
 	/* set some type-dependent values */
-	sdata->type = type;
+	sdata->vif.type = type;
 
 	get_random_bytes(&sdata->bsn, 1);
 	get_random_bytes(&sdata->dsn, 1);
@@ -447,8 +448,8 @@ ieee802154_if_add(struct ieee802154_local *local, const char *name,
 
 	ASSERT_RTNL();
 
-	ndev = alloc_netdev(sizeof(*sdata), name, NET_NAME_UNKNOWN,
-			    ieee802154_if_setup);
+	ndev = alloc_netdev(sizeof(*sdata) + local->hw.vif_data_size, name,
+			    NET_NAME_UNKNOWN, ieee802154_if_setup);
 	if (!ndev)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 95961cc..4b54cf3 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -208,7 +208,7 @@ __ieee802154_rx_handle_packet(struct ieee802154_local *local,
 	}
 
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
-		if (sdata->type != IEEE802154_DEV_WPAN ||
+		if (sdata->vif.type != IEEE802154_DEV_WPAN ||
 		    !netif_running(sdata->dev))
 			continue;
 
@@ -233,7 +233,7 @@ ieee802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
 	skb->protocol = htons(ETH_P_IEEE802154);
 
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
-		if (sdata->type != IEEE802154_DEV_MONITOR)
+		if (sdata->vif.type != IEEE802154_DEV_MONITOR)
 			continue;
 
 		if (!ieee802154_sdata_running(sdata))
-- 
2.1.3

