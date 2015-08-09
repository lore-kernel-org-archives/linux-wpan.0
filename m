Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33875 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933088AbbHIRMY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 9 Aug 2015 13:12:24 -0400
Received: by wicne3 with SMTP id ne3so110408565wic.1
        for <linux-wpan@vger.kernel.org>; Sun, 09 Aug 2015 10:12:22 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/4] mac802154: cfg: remove test and set checks
Date: Sun,  9 Aug 2015 21:12:12 +0200
Message-Id: <1439147535-14793-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1439147535-14793-1-git-send-email-alex.aring@gmail.com>
References: <1439147535-14793-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes several checks if a value is really changed. This
makes only sense if we have another layer call e.g. calling the
driver_ops which is done by callbacks like "set_channel".

For MAC settings which need to be set by phy registers (if the phy
supports that handling) this is set by doing an interface up currently
and are not direct driver_ops calls, so we remove the checks from these
configuration callbacks.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Suggested-by: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/cfg.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index f7ba51e..cecfcda 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -209,10 +209,6 @@ ieee802154_set_backoff_exponent(struct wpan_phy *wpan_phy,
 {
 	ASSERT_RTNL();
 
-	if (wpan_dev->min_be == min_be &&
-	    wpan_dev->max_be == max_be)
-		return 0;
-
 	wpan_dev->min_be = min_be;
 	wpan_dev->max_be = max_be;
 	return 0;
@@ -224,9 +220,6 @@ ieee802154_set_short_addr(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 {
 	ASSERT_RTNL();
 
-	if (wpan_dev->short_addr == short_addr)
-		return 0;
-
 	wpan_dev->short_addr = short_addr;
 	return 0;
 }
@@ -238,9 +231,6 @@ ieee802154_set_max_csma_backoffs(struct wpan_phy *wpan_phy,
 {
 	ASSERT_RTNL();
 
-	if (wpan_dev->csma_retries == max_csma_backoffs)
-		return 0;
-
 	wpan_dev->csma_retries = max_csma_backoffs;
 	return 0;
 }
@@ -252,9 +242,6 @@ ieee802154_set_max_frame_retries(struct wpan_phy *wpan_phy,
 {
 	ASSERT_RTNL();
 
-	if (wpan_dev->frame_retries == max_frame_retries)
-		return 0;
-
 	wpan_dev->frame_retries = max_frame_retries;
 	return 0;
 }
@@ -265,9 +252,6 @@ ieee802154_set_lbt_mode(struct wpan_phy *wpan_phy, struct wpan_dev *wpan_dev,
 {
 	ASSERT_RTNL();
 
-	if (wpan_dev->lbt == mode)
-		return 0;
-
 	wpan_dev->lbt = mode;
 	return 0;
 }
-- 
2.5.0

