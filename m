Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34697 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782AbbFFPbG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 6 Jun 2015 11:31:06 -0400
Received: by wibut5 with SMTP id ut5so46649122wib.1
        for <linux-wpan@vger.kernel.org>; Sat, 06 Jun 2015 08:31:05 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/8] mac802154: remove unneeded vif struct
Date: Sat,  6 Jun 2015 17:30:46 +0200
Message-Id: <1433604653-9585-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1433604653-9585-1-git-send-email-alex.aring@gmail.com>
References: <1433604653-9585-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Varka Bhadram <varkab@cdac.in>

This patch removes the virtual interface structure from sub if data
struct, because it isn't used anywhere. This structure could be useful
for give per interface information at softmac driver layer. Nevertheless
there exist no use case currently and it contains the interface type
information currently. This information is also stored inside wpan dev
which is now used to check on the wpan dev interface type.

Cc: Varka Bhadram <varkab@cdac.in>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 1 -
 drivers/net/ieee802154/cc2520.c    | 1 -
 include/net/mac802154.h            | 8 --------
 net/mac802154/ieee802154_i.h       | 2 --
 net/mac802154/iface.c              | 9 ++++-----
 net/mac802154/rx.c                 | 4 ++--
 6 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 2f25a5e..6e20e9c 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1602,7 +1602,6 @@ static int at86rf230_probe(struct spi_device *spi)
 	lp->spi = spi;
 	lp->slp_tr = slp_tr;
 	hw->parent = &spi->dev;
-	hw->vif_data_size = sizeof(*lp);
 	ieee802154_random_extended_addr(&hw->phy->perm_extended_addr);
 
 	lp->regmap = devm_regmap_init_spi(spi, &at86rf230_regmap_spi_config);
diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 8141353..a8bafd6 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -742,7 +742,6 @@ static int cc2520_register(struct cc2520_private *priv)
 	priv->hw->priv = priv;
 	priv->hw->parent = &priv->spi->dev;
 	priv->hw->extra_tx_headroom = 0;
-	priv->hw->vif_data_size = sizeof(*priv);
 	ieee802154_random_extended_addr(&priv->hw->phy->perm_extended_addr);
 
 	/* We do support only 2.4 Ghz */
diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 9605c7f..80a9e60 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -56,13 +56,6 @@ struct ieee802154_hw_addr_filt {
 	u8	pan_coord;
 };
 
-struct ieee802154_vif {
-	int type;
-
-	/* must be last */
-	u8 drv_priv[0] __aligned(sizeof(void *));
-};
-
 struct ieee802154_hw {
 	/* filled by the driver */
 	int	extra_tx_headroom;
@@ -73,7 +66,6 @@ struct ieee802154_hw {
 	struct	ieee802154_hw_addr_filt hw_filt;
 	void	*priv;
 	struct	wpan_phy *phy;
-	size_t vif_data_size;
 };
 
 /* Checksum is in hardware and is omitted from a packet
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index eec668f..34755d5 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -92,8 +92,6 @@ struct ieee802154_sub_if_data {
 	struct mutex sec_mtx;
 
 	struct mac802154_llsec sec;
-	/* must be last, dynamically sized area in this! */
-	struct ieee802154_vif vif;
 };
 
 #define MAC802154_CHAN_NONE		0xff /* No channel is assigned */
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 6ac0239..3a67d35 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -219,8 +219,8 @@ ieee802154_check_concurrent_iface(struct ieee802154_sub_if_data *sdata,
 			 * exist really an use case if we need to support
 			 * multiple node types at the same time.
 			 */
-			if (sdata->vif.type == NL802154_IFTYPE_NODE &&
-			    nsdata->vif.type == NL802154_IFTYPE_NODE)
+			if (wpan_dev->iftype == NL802154_IFTYPE_NODE &&
+			    nsdata->wpan_dev.iftype == NL802154_IFTYPE_NODE)
 				return -EBUSY;
 
 			/* check all phy mac sublayer settings are the same.
@@ -243,7 +243,7 @@ static int mac802154_wpan_open(struct net_device *dev)
 	struct ieee802154_local *local = sdata->local;
 	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
 
-	rc = ieee802154_check_concurrent_iface(sdata, sdata->vif.type);
+	rc = ieee802154_check_concurrent_iface(sdata, wpan_dev->iftype);
 	if (rc < 0)
 		return rc;
 
@@ -467,7 +467,6 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata,
 	u8 tmp;
 
 	/* set some type-dependent values */
-	sdata->vif.type = type;
 	sdata->wpan_dev.iftype = type;
 
 	get_random_bytes(&tmp, sizeof(tmp));
@@ -523,7 +522,7 @@ ieee802154_if_add(struct ieee802154_local *local, const char *name,
 
 	ASSERT_RTNL();
 
-	ndev = alloc_netdev(sizeof(*sdata) + local->hw.vif_data_size, name,
+	ndev = alloc_netdev(sizeof(*sdata), name,
 			    name_assign_type, ieee802154_if_setup);
 	if (!ndev)
 		return ERR_PTR(-ENOMEM);
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index e0f1006..1bdf980 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -202,7 +202,7 @@ __ieee802154_rx_handle_packet(struct ieee802154_local *local,
 	}
 
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
-		if (sdata->vif.type != NL802154_IFTYPE_NODE ||
+		if (sdata->wpan_dev.iftype != NL802154_IFTYPE_NODE ||
 		    !netif_running(sdata->dev))
 			continue;
 
@@ -227,7 +227,7 @@ ieee802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
 	skb->protocol = htons(ETH_P_IEEE802154);
 
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
-		if (sdata->vif.type != NL802154_IFTYPE_MONITOR)
+		if (sdata->wpan_dev.iftype != NL802154_IFTYPE_MONITOR)
 			continue;
 
 		if (!ieee802154_sdata_running(sdata))
-- 
2.4.1

