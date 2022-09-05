Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E87CC6FA82
	for <linux-wpan@archiver.kernel.org>; Mon,  5 Sep 2022 01:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbiIEBIZ (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 4 Sep 2022 21:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiIEBIY (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 4 Sep 2022 21:08:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20E326AED
        for <linux-wpan@vger.kernel.org>; Sun,  4 Sep 2022 18:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662340103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MILa9FEOsOkyed4RZCKMrvbJr0d+ypzjRxxV4tj6QWQ=;
        b=eUrOWho+vP8RLD3EeHxccozG2f8stIALkbeRBH9h36eBw26FiQ5QalqlijRsRWHBnsh20/
        P4udLNSEnbKXr0s6GOvx6eyZN1DZSG/7ppE5+eEZuwj0YHZ32fQRlwLm73Q7HxAvZYxQUc
        oJcIQgxUiHJy1+hAU6RW9MZKUziT31U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-FUYzuOGrMb-KzlTNMPe-mA-1; Sun, 04 Sep 2022 21:08:18 -0400
X-MC-Unique: FUYzuOGrMb-KzlTNMPe-mA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73AD4801231;
        Mon,  5 Sep 2022 01:08:18 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 564C31121314;
        Mon,  5 Sep 2022 01:08:18 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     miquel.raynal@bootlin.com
Cc:     linux-wpan@vger.kernel.org, stefan@datenfreihafen.org
Subject: [RFC wpan-next 2/2] net: mac802154: set filter at drv_start()
Date:   Sun,  4 Sep 2022 21:08:10 -0400
Message-Id: <20220905010810.1010911-2-aahringo@redhat.com>
In-Reply-To: <20220905010810.1010911-1-aahringo@redhat.com>
References: <20220905010810.1010911-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

The current filtering level is set on the first interface up on a wpan
phy. If we support scan functionality we need to change the filtering
level on the fly on an operational phy and switching back again.

This patch will move the receive mode parameter e.g. address filter and
promiscuous mode to the drv_start() functionality to allow changing the
receive mode on an operational phy not on first ifup only. In future this
should be handled on driver layer because each hardware has it's own way
to enter a specific filtering level. However this should offer to switch
to mode IEEE802154_FILTERING_NONE and back to
IEEE802154_FILTERING_4_FRAME_FIELDS.

Only IEEE802154_FILTERING_4_FRAME_FIELDS and IEEE802154_FILTERING_NONE
are somewhat supported by current hardware. All other filtering levels
can be supported in future but will end in IEEE802154_FILTERING_NONE as
the receive part can kind of "emulate" those receive paths by doing
additional filtering routines.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---

RFC as code snippet as requested to somehow deal with the current
driver-ops and switching between filters with address filtering (AACK on)
and non-address filtering (AACK off) which is necessary for scanning in
this case it will be NONE because that's what we currently support and I
hope it can useful for scanning receive mode.

 drivers/net/ieee802154/mac802154_hwsim.c |  4 ++
 include/net/cfg802154.h                  |  6 +-
 net/mac802154/cfg.c                      |  3 +-
 net/mac802154/driver-ops.h               | 74 +++++++++++++++++++++++-
 net/mac802154/ieee802154_i.h             |  4 ++
 net/mac802154/iface.c                    | 46 +++++----------
 net/mac802154/rx.c                       |  7 ++-
 7 files changed, 108 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index 38c217bd7c82..1612cab98014 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -148,6 +148,10 @@ static int hwsim_hw_start(struct ieee802154_hw *hw)
 	struct hwsim_phy *phy = hw->priv;
 
 	phy->suspended = false;
+	/* TODO implement IEEE802154_FILTERING_4_FRAME_FIELDS in hwsim
+	 * receive handling for now let it run as it is before pkt_type
+	 * will do filtering.
+	 */
 	return 0;
 }
 
diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 07f310b9e053..b843bf3cdbf8 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -223,7 +223,9 @@ struct wpan_phy {
 	atomic_t hold_txs;
 	wait_queue_head_t sync_txq;
 
-	/* Current filtering level on reception */
+	/* Current filtering level on reception.
+	 * Only allowed to be changed if phy is not operational.
+	 */
 	unsigned long filtering;
 
 	char priv[] __aligned(NETDEV_ALIGN);
@@ -377,8 +379,6 @@ struct wpan_dev {
 
 	bool lbt;
 
-	bool promiscuous_mode;
-
 	/* fallback for acknowledgment bit setting */
 	bool ackreq;
 };
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 93df24f75572..363d465f816a 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -67,7 +67,8 @@ static int ieee802154_resume(struct wpan_phy *wpan_phy)
 		goto wake_up;
 
 	/* restart hardware */
-	ret = drv_start(local);
+	ret = drv_start(local, local->phy->filtering,
+			&local->addr_filt);
 	if (ret)
 		return ret;
 
diff --git a/net/mac802154/driver-ops.h b/net/mac802154/driver-ops.h
index c9d54088a567..1cace614ba11 100644
--- a/net/mac802154/driver-ops.h
+++ b/net/mac802154/driver-ops.h
@@ -129,12 +129,84 @@ drv_set_promiscuous_mode(struct ieee802154_local *local, bool on)
 	return ret;
 }
 
-static inline int drv_start(struct ieee802154_local *local)
+static inline int drv_start(struct ieee802154_local *local,
+			    enum ieee802154_filtering_level level,
+			    const struct ieee802154_hw_addr_filt *addr_filt)
 {
 	int ret;
 
 	might_sleep();
 
+	/* setup receive mode parameters e.g. address mode */
+	if (local->hw.flags & IEEE802154_HW_AFILT) {
+		ret = drv_set_pan_id(local, addr_filt->pan_id);
+		if (ret < 0)
+			return ret;
+
+		ret = drv_set_short_addr(local, addr_filt->short_addr);
+		if (ret < 0)
+			return ret;
+
+		ret = drv_set_extended_addr(local, addr_filt->ieee_addr);
+		if (ret < 0)
+			return ret;
+	}
+
+	switch (level) {
+	case IEEE802154_FILTERING_NONE:
+		fallthrough;
+	case IEEE802154_FILTERING_1_FCS:
+		fallthrough;
+	case IEEE802154_FILTERING_2_PROMISCUOUS:
+		/* TODO requires a different receive mode setup e.g.
+		 * at86rf233 hardware.
+		 */
+		fallthrough;
+	case IEEE802154_FILTERING_3_SCAN:
+		if (local->hw.flags & IEEE802154_HW_PROMISCUOUS) {
+			ret = drv_set_promiscuous_mode(local, true);
+			if (ret < 0)
+				return ret;
+		} else {
+			return -EOPNOTSUPP;
+		}
+
+		/* may requested other filtering but for now
+		 * all hardware can support
+		 * IEEE802154_FILTERING_NONE only which is a kind of
+		 * "compatible" mode we just need to filter more in
+		 * mac802154 receive path.
+		 *
+		 * TODO: move to driver and hardware may return more
+		 * higher level filter if supported. Hardware may
+		 * require also a different order how register are
+		 * set which could currently be buggy, so all receive
+		 * parameter need to be moved to the start() callback
+		 * and let the driver go into the mode before it will
+		 * turn on receive handling.
+		 */
+		local->phy->filtering = IEEE802154_FILTERING_NONE;
+		break;
+	case IEEE802154_FILTERING_4_FRAME_FIELDS:
+		/* not error out here for now as if hw doesn't support
+		 * IEEE802154_HW_PROMISCUOUS it's in
+		 * IEEE802154_FILTERING_4_FRAME_FIELDS
+		 * we have only a problem if some user switches and do not
+		 * support IEEE802154_HW_PROMISCUOUS.
+		 */
+		if (local->hw.flags & IEEE802154_HW_PROMISCUOUS) {
+			ret = drv_set_promiscuous_mode(local, false);
+			if (ret < 0)
+				return ret;
+		}
+
+		local->phy->filtering = IEEE802154_FILTERING_4_FRAME_FIELDS;
+		break;
+	default:
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
 	trace_802154_drv_start(local);
 	local->started = true;
 	smp_mb();
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 010365a6364e..6c6da0d624e0 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -26,6 +26,8 @@ struct ieee802154_local {
 	struct ieee802154_hw hw;
 	const struct ieee802154_ops *ops;
 
+	/* hardware address filter */
+	struct ieee802154_hw_addr_filt addr_filt;
 	/* ieee802154 phy */
 	struct wpan_phy *phy;
 
@@ -82,6 +84,8 @@ struct ieee802154_sub_if_data {
 	struct ieee802154_local *local;
 	struct net_device *dev;
 
+	enum ieee802154_filtering_level required_filtering;
+
 	unsigned long state;
 	char name[IFNAMSIZ];
 
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 4bab2807acbe..bf95e710becc 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -147,25 +147,12 @@ static int ieee802154_setup_hw(struct ieee802154_sub_if_data *sdata)
 	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
 	int ret;
 
-	if (local->hw.flags & IEEE802154_HW_PROMISCUOUS) {
-		ret = drv_set_promiscuous_mode(local,
-					       wpan_dev->promiscuous_mode);
-		if (ret < 0)
-			return ret;
-	}
+	local->phy->filtering = sdata->required_filtering;
 
 	if (local->hw.flags & IEEE802154_HW_AFILT) {
-		ret = drv_set_pan_id(local, wpan_dev->pan_id);
-		if (ret < 0)
-			return ret;
-
-		ret = drv_set_extended_addr(local, wpan_dev->extended_addr);
-		if (ret < 0)
-			return ret;
-
-		ret = drv_set_short_addr(local, wpan_dev->short_addr);
-		if (ret < 0)
-			return ret;
+		local->addr_filt.pan_id = wpan_dev->pan_id;
+		local->addr_filt.ieee_addr = wpan_dev->extended_addr;
+		local->addr_filt.short_addr = wpan_dev->short_addr;
 	}
 
 	if (local->hw.flags & IEEE802154_HW_LBT) {
@@ -206,7 +193,8 @@ static int mac802154_slave_open(struct net_device *dev)
 		if (res)
 			goto err;
 
-		res = drv_start(local);
+		res = drv_start(local, local->phy->filtering,
+				&local->addr_filt);
 		if (res)
 			goto err;
 	}
@@ -223,15 +211,16 @@ static int mac802154_slave_open(struct net_device *dev)
 
 static int
 ieee802154_check_mac_settings(struct ieee802154_local *local,
-			      struct wpan_dev *wpan_dev,
-			      struct wpan_dev *nwpan_dev)
+			      struct ieee802154_sub_if_data *sdata,
+			      struct ieee802154_sub_if_data *nsdata)
 {
+	struct wpan_dev *nwpan_dev = &nsdata->wpan_dev;
+	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
+
 	ASSERT_RTNL();
 
-	if (local->hw.flags & IEEE802154_HW_PROMISCUOUS) {
-		if (wpan_dev->promiscuous_mode != nwpan_dev->promiscuous_mode)
-			return -EBUSY;
-	}
+	if (sdata->required_filtering != nsdata->required_filtering)
+		return -EBUSY;
 
 	if (local->hw.flags & IEEE802154_HW_AFILT) {
 		if (wpan_dev->pan_id != nwpan_dev->pan_id ||
@@ -285,8 +274,7 @@ ieee802154_check_concurrent_iface(struct ieee802154_sub_if_data *sdata,
 			/* check all phy mac sublayer settings are the same.
 			 * We have only one phy, different values makes trouble.
 			 */
-			ret = ieee802154_check_mac_settings(local, wpan_dev,
-							    &nsdata->wpan_dev);
+			ret = ieee802154_check_mac_settings(local, sdata, nsdata);
 			if (ret < 0)
 				return ret;
 		}
@@ -586,8 +574,7 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata,
 		sdata->dev->priv_destructor = mac802154_wpan_free;
 		sdata->dev->netdev_ops = &mac802154_wpan_ops;
 		sdata->dev->ml_priv = &mac802154_mlme_wpan;
-		wpan_dev->promiscuous_mode = false;
-		wpan_dev->wpan_phy->filtering = IEEE802154_FILTERING_4_FRAME_FIELDS;
+		sdata->required_filtering = IEEE802154_FILTERING_4_FRAME_FIELDS;
 		wpan_dev->header_ops = &ieee802154_header_ops;
 
 		mutex_init(&sdata->sec_mtx);
@@ -601,8 +588,7 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata,
 	case NL802154_IFTYPE_MONITOR:
 		sdata->dev->needs_free_netdev = true;
 		sdata->dev->netdev_ops = &mac802154_monitor_ops;
-		wpan_dev->promiscuous_mode = true;
-		wpan_dev->wpan_phy->filtering = IEEE802154_FILTERING_2_PROMISCUOUS;
+		sdata->required_filtering = IEEE802154_FILTERING_NONE;
 		break;
 	default:
 		BUG();
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index b8ce84618a55..7fe02a9222df 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -271,7 +271,12 @@ void ieee802154_rx(struct ieee802154_local *local, struct sk_buff *skb)
 	/* Check if transceiver doesn't validate the checksum.
 	 * If not we validate the checksum here.
 	 */
-	if (local->hw.flags & IEEE802154_HW_RX_DROP_BAD_CKSUM) {
+	/* TODO do whatever you want here if necessary to filter by
+	 * check on IEEE802154_FILTERING_NONE. And upcomming receive
+	 * path in which state the phy is e.g. scanning.
+	 */
+	if (local->hw.flags & IEEE802154_HW_RX_DROP_BAD_CKSUM ||
+	    local->phy->filtering == IEEE802154_FILTERING_NONE) {
 		crc = crc_ccitt(0, skb->data, skb->len);
 		if (crc) {
 			rcu_read_unlock();
-- 
2.31.1

