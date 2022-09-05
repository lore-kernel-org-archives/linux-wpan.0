Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799B6C6FA82
	for <linux-wpan@archiver.kernel.org>; Mon,  5 Sep 2022 01:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbiIEBIW (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 4 Sep 2022 21:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiIEBIV (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 4 Sep 2022 21:08:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45AF26AED
        for <linux-wpan@vger.kernel.org>; Sun,  4 Sep 2022 18:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662340099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UEFs57j30JNraSkAkg8iMd5ZzUICPPh33OPBX7JjAew=;
        b=Ytk9u2My7cEQoIeDjfvHCDmv8ykiJMd0TJwXP3BsiZmHs1ow6QFFGa+Xs4WJk34ivZKpDs
        RLrjjtiohDxd3yPCiHnJ6W63HSxAmH03fL1ip31zuk1NIjIangyxBPk/bAWr5cq01CTb2s
        MgpNBFJi30YAP+ZMjG4WkWnAAmkDpsA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-3Plau1jqPXuBP8m1krRf4Q-1; Sun, 04 Sep 2022 21:08:18 -0400
X-MC-Unique: 3Plau1jqPXuBP8m1krRf4Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DB8E1C05EA1;
        Mon,  5 Sep 2022 01:08:18 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2EA841121314;
        Mon,  5 Sep 2022 01:08:18 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     miquel.raynal@bootlin.com
Cc:     linux-wpan@vger.kernel.org, stefan@datenfreihafen.org
Subject: [RFC wpan-next 1/2] net: mac802154: move receive parameters above start
Date:   Sun,  4 Sep 2022 21:08:09 -0400
Message-Id: <20220905010810.1010911-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

This patch moves all receive parameters above the drv_start()
functionality to make it accessibile in the drv_start() function.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 net/mac802154/driver-ops.h | 190 ++++++++++++++++++-------------------
 1 file changed, 95 insertions(+), 95 deletions(-)

diff --git a/net/mac802154/driver-ops.h b/net/mac802154/driver-ops.h
index d23f0db98015..c9d54088a567 100644
--- a/net/mac802154/driver-ops.h
+++ b/net/mac802154/driver-ops.h
@@ -24,203 +24,221 @@ drv_xmit_sync(struct ieee802154_local *local, struct sk_buff *skb)
 	return local->ops->xmit_sync(&local->hw, skb);
 }
 
-static inline int drv_start(struct ieee802154_local *local)
+static inline int drv_set_pan_id(struct ieee802154_local *local, __le16 pan_id)
 {
+	struct ieee802154_hw_addr_filt filt;
 	int ret;
 
 	might_sleep();
 
-	trace_802154_drv_start(local);
-	local->started = true;
-	smp_mb();
-	ret = local->ops->start(&local->hw);
+	if (!local->ops->set_hw_addr_filt) {
+		WARN_ON(1);
+		return -EOPNOTSUPP;
+	}
+
+	filt.pan_id = pan_id;
+
+	trace_802154_drv_set_pan_id(local, pan_id);
+	ret = local->ops->set_hw_addr_filt(&local->hw, &filt,
+					    IEEE802154_AFILT_PANID_CHANGED);
 	trace_802154_drv_return_int(local, ret);
 	return ret;
 }
 
-static inline void drv_stop(struct ieee802154_local *local)
+static inline int
+drv_set_extended_addr(struct ieee802154_local *local, __le64 extended_addr)
 {
-	might_sleep();
+	struct ieee802154_hw_addr_filt filt;
+	int ret;
 
-	trace_802154_drv_stop(local);
-	local->ops->stop(&local->hw);
-	trace_802154_drv_return_void(local);
+	might_sleep();
 
-	/* sync away all work on the tasklet before clearing started */
-	tasklet_disable(&local->tasklet);
-	tasklet_enable(&local->tasklet);
+	if (!local->ops->set_hw_addr_filt) {
+		WARN_ON(1);
+		return -EOPNOTSUPP;
+	}
 
-	barrier();
+	filt.ieee_addr = extended_addr;
 
-	local->started = false;
+	trace_802154_drv_set_extended_addr(local, extended_addr);
+	ret = local->ops->set_hw_addr_filt(&local->hw, &filt,
+					    IEEE802154_AFILT_IEEEADDR_CHANGED);
+	trace_802154_drv_return_int(local, ret);
+	return ret;
 }
 
 static inline int
-drv_set_channel(struct ieee802154_local *local, u8 page, u8 channel)
+drv_set_short_addr(struct ieee802154_local *local, __le16 short_addr)
 {
+	struct ieee802154_hw_addr_filt filt;
 	int ret;
 
 	might_sleep();
 
-	trace_802154_drv_set_channel(local, page, channel);
-	ret = local->ops->set_channel(&local->hw, page, channel);
+	if (!local->ops->set_hw_addr_filt) {
+		WARN_ON(1);
+		return -EOPNOTSUPP;
+	}
+
+	filt.short_addr = short_addr;
+
+	trace_802154_drv_set_short_addr(local, short_addr);
+	ret = local->ops->set_hw_addr_filt(&local->hw, &filt,
+					    IEEE802154_AFILT_SADDR_CHANGED);
 	trace_802154_drv_return_int(local, ret);
 	return ret;
 }
 
-static inline int drv_set_tx_power(struct ieee802154_local *local, s32 mbm)
+static inline int
+drv_set_pan_coord(struct ieee802154_local *local, bool is_coord)
 {
+	struct ieee802154_hw_addr_filt filt;
 	int ret;
 
 	might_sleep();
 
-	if (!local->ops->set_txpower) {
+	if (!local->ops->set_hw_addr_filt) {
 		WARN_ON(1);
 		return -EOPNOTSUPP;
 	}
 
-	trace_802154_drv_set_tx_power(local, mbm);
-	ret = local->ops->set_txpower(&local->hw, mbm);
+	filt.pan_coord = is_coord;
+
+	trace_802154_drv_set_pan_coord(local, is_coord);
+	ret = local->ops->set_hw_addr_filt(&local->hw, &filt,
+					    IEEE802154_AFILT_PANC_CHANGED);
 	trace_802154_drv_return_int(local, ret);
 	return ret;
 }
 
-static inline int drv_set_cca_mode(struct ieee802154_local *local,
-				   const struct wpan_phy_cca *cca)
+static inline int
+drv_set_promiscuous_mode(struct ieee802154_local *local, bool on)
 {
 	int ret;
 
 	might_sleep();
 
-	if (!local->ops->set_cca_mode) {
+	if (!local->ops->set_promiscuous_mode) {
 		WARN_ON(1);
 		return -EOPNOTSUPP;
 	}
 
-	trace_802154_drv_set_cca_mode(local, cca);
-	ret = local->ops->set_cca_mode(&local->hw, cca);
+	trace_802154_drv_set_promiscuous_mode(local, on);
+	ret = local->ops->set_promiscuous_mode(&local->hw, on);
 	trace_802154_drv_return_int(local, ret);
 	return ret;
 }
 
-static inline int drv_set_lbt_mode(struct ieee802154_local *local, bool mode)
+static inline int drv_start(struct ieee802154_local *local)
 {
 	int ret;
 
 	might_sleep();
 
-	if (!local->ops->set_lbt) {
-		WARN_ON(1);
-		return -EOPNOTSUPP;
-	}
-
-	trace_802154_drv_set_lbt_mode(local, mode);
-	ret = local->ops->set_lbt(&local->hw, mode);
+	trace_802154_drv_start(local);
+	local->started = true;
+	smp_mb();
+	ret = local->ops->start(&local->hw);
 	trace_802154_drv_return_int(local, ret);
 	return ret;
 }
 
+static inline void drv_stop(struct ieee802154_local *local)
+{
+	might_sleep();
+
+	trace_802154_drv_stop(local);
+	local->ops->stop(&local->hw);
+	trace_802154_drv_return_void(local);
+
+	/* sync away all work on the tasklet before clearing started */
+	tasklet_disable(&local->tasklet);
+	tasklet_enable(&local->tasklet);
+
+	barrier();
+
+	local->started = false;
+}
+
 static inline int
-drv_set_cca_ed_level(struct ieee802154_local *local, s32 mbm)
+drv_set_channel(struct ieee802154_local *local, u8 page, u8 channel)
 {
 	int ret;
 
 	might_sleep();
 
-	if (!local->ops->set_cca_ed_level) {
-		WARN_ON(1);
-		return -EOPNOTSUPP;
-	}
-
-	trace_802154_drv_set_cca_ed_level(local, mbm);
-	ret = local->ops->set_cca_ed_level(&local->hw, mbm);
+	trace_802154_drv_set_channel(local, page, channel);
+	ret = local->ops->set_channel(&local->hw, page, channel);
 	trace_802154_drv_return_int(local, ret);
 	return ret;
 }
 
-static inline int drv_set_pan_id(struct ieee802154_local *local, __le16 pan_id)
+static inline int drv_set_tx_power(struct ieee802154_local *local, s32 mbm)
 {
-	struct ieee802154_hw_addr_filt filt;
 	int ret;
 
 	might_sleep();
 
-	if (!local->ops->set_hw_addr_filt) {
+	if (!local->ops->set_txpower) {
 		WARN_ON(1);
 		return -EOPNOTSUPP;
 	}
 
-	filt.pan_id = pan_id;
-
-	trace_802154_drv_set_pan_id(local, pan_id);
-	ret = local->ops->set_hw_addr_filt(&local->hw, &filt,
-					    IEEE802154_AFILT_PANID_CHANGED);
+	trace_802154_drv_set_tx_power(local, mbm);
+	ret = local->ops->set_txpower(&local->hw, mbm);
 	trace_802154_drv_return_int(local, ret);
 	return ret;
 }
 
-static inline int
-drv_set_extended_addr(struct ieee802154_local *local, __le64 extended_addr)
+static inline int drv_set_cca_mode(struct ieee802154_local *local,
+				   const struct wpan_phy_cca *cca)
 {
-	struct ieee802154_hw_addr_filt filt;
 	int ret;
 
 	might_sleep();
 
-	if (!local->ops->set_hw_addr_filt) {
+	if (!local->ops->set_cca_mode) {
 		WARN_ON(1);
 		return -EOPNOTSUPP;
 	}
 
-	filt.ieee_addr = extended_addr;
-
-	trace_802154_drv_set_extended_addr(local, extended_addr);
-	ret = local->ops->set_hw_addr_filt(&local->hw, &filt,
-					    IEEE802154_AFILT_IEEEADDR_CHANGED);
+	trace_802154_drv_set_cca_mode(local, cca);
+	ret = local->ops->set_cca_mode(&local->hw, cca);
 	trace_802154_drv_return_int(local, ret);
 	return ret;
 }
 
-static inline int
-drv_set_short_addr(struct ieee802154_local *local, __le16 short_addr)
+static inline int drv_set_lbt_mode(struct ieee802154_local *local, bool mode)
 {
-	struct ieee802154_hw_addr_filt filt;
 	int ret;
 
 	might_sleep();
 
-	if (!local->ops->set_hw_addr_filt) {
+	if (!local->ops->set_lbt) {
 		WARN_ON(1);
 		return -EOPNOTSUPP;
 	}
 
-	filt.short_addr = short_addr;
-
-	trace_802154_drv_set_short_addr(local, short_addr);
-	ret = local->ops->set_hw_addr_filt(&local->hw, &filt,
-					    IEEE802154_AFILT_SADDR_CHANGED);
+	trace_802154_drv_set_lbt_mode(local, mode);
+	ret = local->ops->set_lbt(&local->hw, mode);
 	trace_802154_drv_return_int(local, ret);
 	return ret;
 }
 
 static inline int
-drv_set_pan_coord(struct ieee802154_local *local, bool is_coord)
+drv_set_cca_ed_level(struct ieee802154_local *local, s32 mbm)
 {
-	struct ieee802154_hw_addr_filt filt;
 	int ret;
 
 	might_sleep();
 
-	if (!local->ops->set_hw_addr_filt) {
+	if (!local->ops->set_cca_ed_level) {
 		WARN_ON(1);
 		return -EOPNOTSUPP;
 	}
 
-	filt.pan_coord = is_coord;
-
-	trace_802154_drv_set_pan_coord(local, is_coord);
-	ret = local->ops->set_hw_addr_filt(&local->hw, &filt,
-					    IEEE802154_AFILT_PANC_CHANGED);
+	trace_802154_drv_set_cca_ed_level(local, mbm);
+	ret = local->ops->set_cca_ed_level(&local->hw, mbm);
 	trace_802154_drv_return_int(local, ret);
 	return ret;
 }
@@ -264,22 +282,4 @@ drv_set_max_frame_retries(struct ieee802154_local *local, s8 max_frame_retries)
 	return ret;
 }
 
-static inline int
-drv_set_promiscuous_mode(struct ieee802154_local *local, bool on)
-{
-	int ret;
-
-	might_sleep();
-
-	if (!local->ops->set_promiscuous_mode) {
-		WARN_ON(1);
-		return -EOPNOTSUPP;
-	}
-
-	trace_802154_drv_set_promiscuous_mode(local, on);
-	ret = local->ops->set_promiscuous_mode(&local->hw, on);
-	trace_802154_drv_return_int(local, ret);
-	return ret;
-}
-
 #endif /* __MAC802154_DRIVER_OPS */
-- 
2.31.1

