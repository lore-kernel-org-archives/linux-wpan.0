Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33712 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbbDIHP1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 9 Apr 2015 03:15:27 -0400
Received: by paboj16 with SMTP id oj16so140994180pab.0
        for <linux-wpan@vger.kernel.org>; Thu, 09 Apr 2015 00:15:27 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next] mac802154: fix transmission power datatype
Date: Thu,  9 Apr 2015 12:44:56 +0530
Message-Id: <1428563696-1087-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

Available 802.15.4 devices support multiple power levels,
which includes positive and negative values.This patch fix
set_txpower() operation arugument type to signed from int

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 include/net/mac802154.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index fb4e8a3d..1213419 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -213,7 +213,7 @@ struct ieee802154_ops {
 	int		(*set_hw_addr_filt)(struct ieee802154_hw *hw,
 					    struct ieee802154_hw_addr_filt *filt,
 					    unsigned long changed);
-	int		(*set_txpower)(struct ieee802154_hw *hw, int db);
+	int		(*set_txpower)(struct ieee802154_hw *hw, s8 dbm);
 	int		(*set_lbt)(struct ieee802154_hw *hw, bool on);
 	int		(*set_cca_mode)(struct ieee802154_hw *hw,
 					const struct wpan_phy_cca *cca);
-- 
1.7.9.5

