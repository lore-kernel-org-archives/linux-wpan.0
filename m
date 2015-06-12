Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:33801 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbbFLDo1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 11 Jun 2015 23:44:27 -0400
Received: by pdbki1 with SMTP id ki1so15644602pdb.1
        for <linux-wpan@vger.kernel.org>; Thu, 11 Jun 2015 20:44:26 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next] mac802154: cleanup llsec param flags
Date: Fri, 12 Jun 2015 09:13:49 +0530
Message-Id: <1434080629-8641-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

This patch changes the setting of llsec param flag with the BIT macro.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 include/net/ieee802154_netdev.h |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/net/ieee802154_netdev.h b/include/net/ieee802154_netdev.h
index 0a87975..2c10a9f 100644
--- a/include/net/ieee802154_netdev.h
+++ b/include/net/ieee802154_netdev.h
@@ -346,15 +346,15 @@ struct ieee802154_mac_params {
 struct wpan_phy;
 
 enum {
-	IEEE802154_LLSEC_PARAM_ENABLED = 1 << 0,
-	IEEE802154_LLSEC_PARAM_FRAME_COUNTER = 1 << 1,
-	IEEE802154_LLSEC_PARAM_OUT_LEVEL = 1 << 2,
-	IEEE802154_LLSEC_PARAM_OUT_KEY = 1 << 3,
-	IEEE802154_LLSEC_PARAM_KEY_SOURCE = 1 << 4,
-	IEEE802154_LLSEC_PARAM_PAN_ID = 1 << 5,
-	IEEE802154_LLSEC_PARAM_HWADDR = 1 << 6,
-	IEEE802154_LLSEC_PARAM_COORD_HWADDR = 1 << 7,
-	IEEE802154_LLSEC_PARAM_COORD_SHORTADDR = 1 << 8,
+	IEEE802154_LLSEC_PARAM_ENABLED		= BIT(0),
+	IEEE802154_LLSEC_PARAM_FRAME_COUNTER	= BIT(1),
+	IEEE802154_LLSEC_PARAM_OUT_LEVEL	= BIT(2),
+	IEEE802154_LLSEC_PARAM_OUT_KEY		= BIT(3),
+	IEEE802154_LLSEC_PARAM_KEY_SOURCE	= BIT(4),
+	IEEE802154_LLSEC_PARAM_PAN_ID		= BIT(5),
+	IEEE802154_LLSEC_PARAM_HWADDR		= BIT(6),
+	IEEE802154_LLSEC_PARAM_COORD_HWADDR	= BIT(7),
+	IEEE802154_LLSEC_PARAM_COORD_SHORTADDR	= BIT(8),
 };
 
 struct ieee802154_llsec_ops {
-- 
1.7.9.5

