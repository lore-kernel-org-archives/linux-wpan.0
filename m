Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34102 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932654AbbDIIZh (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 9 Apr 2015 04:25:37 -0400
Received: by pacyx8 with SMTP id yx8so142220468pac.1
        for <linux-wpan@vger.kernel.org>; Thu, 09 Apr 2015 01:25:37 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next v2] mac802154: fix transmission power datatype
Date: Thu,  9 Apr 2015 13:55:11 +0530
Message-Id: <1428567911-1857-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

Netlink attribute for the power is s8. But for the driver level
operations we are collection power level value into integer.
It has to be change to s8 from int.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 drivers/net/ieee802154/at86rf230.c |    2 +-
 include/net/mac802154.h            |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 5ad46f7..3802665 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1173,7 +1173,7 @@ at86rf230_set_hw_addr_filt(struct ieee802154_hw *hw,
 }
 
 static int
-at86rf230_set_txpower(struct ieee802154_hw *hw, int db)
+at86rf230_set_txpower(struct ieee802154_hw *hw, s8 db)
 {
 	struct at86rf230_local *lp = hw->priv;
 
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

