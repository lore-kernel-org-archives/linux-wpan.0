Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38426 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbaKQHV2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 17 Nov 2014 02:21:28 -0500
Received: by mail-wi0-f173.google.com with SMTP id r20so1617698wiv.0
        for <linux-wpan@vger.kernel.org>; Sun, 16 Nov 2014 23:21:27 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 04/13] mac802154: remove const for non pointer in cfg ops
Date: Mon, 17 Nov 2014 08:20:46 +0100
Message-Id: <1416208855-8623-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1416208855-8623-1-git-send-email-alex.aring@gmail.com>
References: <1416208855-8623-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patches removes the const keyword in variables which are non
pointers. There is no sense to declare call by value parameters as
const.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/mac802154/cfg.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 5d669d8..2b3610c 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -43,8 +43,7 @@ static void ieee802154_del_iface_deprecated(struct wpan_phy *wpan_phy,
 }
 
 static int
-ieee802154_set_channel(struct wpan_phy *wpan_phy, const u8 page,
-		       const u8 channel)
+ieee802154_set_channel(struct wpan_phy *wpan_phy, u8 page, u8 channel)
 {
 	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
 	int ret;
@@ -64,8 +63,9 @@ ieee802154_set_channel(struct wpan_phy *wpan_phy, const u8 page,
 	return ret;
 }
 
-static int ieee802154_set_pan_id(struct wpan_phy *wpan_phy,
-				 struct wpan_dev *wpan_dev, const u16 pan_id)
+static int
+ieee802154_set_pan_id(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
+		      u16 pan_id)
 {
 	ASSERT_RTNL();
 
@@ -86,7 +86,7 @@ static int ieee802154_set_pan_id(struct wpan_phy *wpan_phy,
 static int
 ieee802154_set_backoff_exponent(struct wpan_phy *wpan_phy,
 				struct wpan_dev *wpan_dev,
-				const u8 min_be, const u8 max_be)
+				u8 min_be, u8 max_be)
 {
 	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
 
@@ -102,7 +102,7 @@ ieee802154_set_backoff_exponent(struct wpan_phy *wpan_phy,
 
 static int
 ieee802154_set_short_addr(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
-			  const u16 short_addr)
+			  u16 short_addr)
 {
 	ASSERT_RTNL();
 
@@ -125,9 +125,10 @@ ieee802154_set_short_addr(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 	return 0;
 }
 
-static int ieee802154_set_max_csma_backoffs(struct wpan_phy *wpan_phy,
-					    struct wpan_dev *wpan_dev,
-					    const u8 max_csma_backoffs)
+static int
+ieee802154_set_max_csma_backoffs(struct wpan_phy *wpan_phy,
+				 struct wpan_dev *wpan_dev,
+				 u8 max_csma_backoffs)
 {
 	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
 
@@ -140,9 +141,10 @@ static int ieee802154_set_max_csma_backoffs(struct wpan_phy *wpan_phy,
 	return 0;
 }
 
-static int ieee802154_set_max_frame_retries(struct wpan_phy *wpan_phy,
-					    struct wpan_dev *wpan_dev,
-					    const s8 max_frame_retries)
+static int
+ieee802154_set_max_frame_retries(struct wpan_phy *wpan_phy,
+				 struct wpan_dev *wpan_dev,
+				 s8 max_frame_retries)
 {
 	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
 
@@ -155,9 +157,9 @@ static int ieee802154_set_max_frame_retries(struct wpan_phy *wpan_phy,
 	return 0;
 }
 
-static int ieee802154_set_lbt_mode(struct wpan_phy *wpan_phy,
-				   struct wpan_dev *wpan_dev,
-				   const bool mode)
+static int
+ieee802154_set_lbt_mode(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
+			bool mode)
 {
 	struct ieee802154_local *local = wpan_phy_priv(wpan_phy);
 
-- 
2.1.3

