Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36687 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932439AbbFWKeW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Jun 2015 06:34:22 -0400
Received: by paceq1 with SMTP id eq1so4412082pac.3
        for <linux-wpan@vger.kernel.org>; Tue, 23 Jun 2015 03:34:22 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next] mac802154: remove unused macro
Date: Tue, 23 Jun 2015 16:03:44 +0530
Message-Id: <1435055625-14921-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

This patch removes the unused macro which was removed
with the rework of linux-wpan kernel.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 net/mac802154/ieee802154_i.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 6d4f3cc..ed87463 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -94,8 +94,6 @@ struct ieee802154_sub_if_data {
 	struct mac802154_llsec sec;
 };
 
-#define MAC802154_CHAN_NONE		0xff /* No channel is assigned */
-
 /* utility functions/constants */
 extern const void *const mac802154_wpan_phy_privid; /*  for wpan_phy privid */
 
-- 
1.7.9.5

