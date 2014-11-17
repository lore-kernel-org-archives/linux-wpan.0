Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:56324 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbaKQHV1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 17 Nov 2014 02:21:27 -0500
Received: by mail-wg0-f44.google.com with SMTP id x12so24025062wgg.17
        for <linux-wpan@vger.kernel.org>; Sun, 16 Nov 2014 23:21:26 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 03/13] mac802154: remove const for non pointer in driver-ops
Date: Mon, 17 Nov 2014 08:20:45 +0100
Message-Id: <1416208855-8623-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1416208855-8623-1-git-send-email-alex.aring@gmail.com>
References: <1416208855-8623-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patches removes the const keyword in variables which are non
pointers. There is no sense to declare call by value parameters as const.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/mac802154/driver-ops.h | 46 +++++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/net/mac802154/driver-ops.h b/net/mac802154/driver-ops.h
index dfd29ff..f21e864 100644
--- a/net/mac802154/driver-ops.h
+++ b/net/mac802154/driver-ops.h
@@ -50,16 +50,15 @@ static inline void drv_stop(struct ieee802154_local *local)
 	local->started = false;
 }
 
-static inline int drv_set_channel(struct ieee802154_local *local,
-				  const u8 page, const u8 channel)
+static inline int
+drv_set_channel(struct ieee802154_local *local, u8 page, u8 channel)
 {
 	might_sleep();
 
 	return local->ops->set_channel(&local->hw, page, channel);
 }
 
-static inline int drv_set_tx_power(struct ieee802154_local *local,
-				   const s8 dbm)
+static inline int drv_set_tx_power(struct ieee802154_local *local, s8 dbm)
 {
 	might_sleep();
 
@@ -71,8 +70,7 @@ static inline int drv_set_tx_power(struct ieee802154_local *local,
 	return local->ops->set_txpower(&local->hw, dbm);
 }
 
-static inline int drv_set_cca_mode(struct ieee802154_local *local,
-				   const u8 cca_mode)
+static inline int drv_set_cca_mode(struct ieee802154_local *local, u8 cca_mode)
 {
 	might_sleep();
 
@@ -84,8 +82,7 @@ static inline int drv_set_cca_mode(struct ieee802154_local *local,
 	return local->ops->set_cca_mode(&local->hw, cca_mode);
 }
 
-static inline int drv_set_lbt_mode(struct ieee802154_local *local,
-				   const bool mode)
+static inline int drv_set_lbt_mode(struct ieee802154_local *local, bool mode)
 {
 	might_sleep();
 
@@ -97,8 +94,8 @@ static inline int drv_set_lbt_mode(struct ieee802154_local *local,
 	return local->ops->set_lbt(&local->hw, mode);
 }
 
-static inline int drv_set_cca_ed_level(struct ieee802154_local *local,
-				       const s32 ed_level)
+static inline int
+drv_set_cca_ed_level(struct ieee802154_local *local, s32 ed_level)
 {
 	might_sleep();
 
@@ -110,8 +107,7 @@ static inline int drv_set_cca_ed_level(struct ieee802154_local *local,
 	return local->ops->set_cca_ed_level(&local->hw, ed_level);
 }
 
-static inline int drv_set_pan_id(struct ieee802154_local *local,
-				 const __le16 pan_id)
+static inline int drv_set_pan_id(struct ieee802154_local *local, __le16 pan_id)
 {
 	struct ieee802154_hw_addr_filt filt;
 
@@ -128,8 +124,8 @@ static inline int drv_set_pan_id(struct ieee802154_local *local,
 					    IEEE802154_AFILT_PANID_CHANGED);
 }
 
-static inline int drv_set_extended_addr(struct ieee802154_local *local,
-					const __le64 extended_addr)
+static inline int
+drv_set_extended_addr(struct ieee802154_local *local, __le64 extended_addr)
 {
 	struct ieee802154_hw_addr_filt filt;
 
@@ -146,8 +142,8 @@ static inline int drv_set_extended_addr(struct ieee802154_local *local,
 					    IEEE802154_AFILT_IEEEADDR_CHANGED);
 }
 
-static inline int drv_set_short_addr(struct ieee802154_local *local,
-				     const __le16 short_addr)
+static inline int
+drv_set_short_addr(struct ieee802154_local *local, __le16 short_addr)
 {
 	struct ieee802154_hw_addr_filt filt;
 
@@ -164,8 +160,8 @@ static inline int drv_set_short_addr(struct ieee802154_local *local,
 					    IEEE802154_AFILT_SADDR_CHANGED);
 }
 
-static inline int drv_set_pan_coord(struct ieee802154_local *local,
-				    const bool is_coord)
+static inline int
+drv_set_pan_coord(struct ieee802154_local *local, bool is_coord)
 {
 	struct ieee802154_hw_addr_filt filt;
 
@@ -182,9 +178,9 @@ static inline int drv_set_pan_coord(struct ieee802154_local *local,
 					    IEEE802154_AFILT_PANC_CHANGED);
 }
 
-static inline int drv_set_csma_params(struct ieee802154_local *local,
-				      u8 min_be, u8 max_be,
-				      u8 max_csma_backoffs)
+static inline int
+drv_set_csma_params(struct ieee802154_local *local, u8 min_be, u8 max_be,
+		    u8 max_csma_backoffs)
 {
 	might_sleep();
 
@@ -197,8 +193,8 @@ static inline int drv_set_csma_params(struct ieee802154_local *local,
 					   max_csma_backoffs);
 }
 
-static inline int drv_set_max_frame_retries(struct ieee802154_local *local,
-					    s8 max_frame_retries)
+static inline int
+drv_set_max_frame_retries(struct ieee802154_local *local, s8 max_frame_retries)
 {
 	might_sleep();
 
@@ -210,8 +206,8 @@ static inline int drv_set_max_frame_retries(struct ieee802154_local *local,
 	return local->ops->set_frame_retries(&local->hw, max_frame_retries);
 }
 
-static inline int drv_set_promiscuous_mode(struct ieee802154_local *local,
-					   const bool on)
+static inline int
+drv_set_promiscuous_mode(struct ieee802154_local *local, bool on)
 {
 	might_sleep();
 
-- 
2.1.3

