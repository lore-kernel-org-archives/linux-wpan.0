Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:36178 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbbEHSYr (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 May 2015 14:24:47 -0400
Received: by wizk4 with SMTP id k4so39432342wiz.1
        for <linux-wpan@vger.kernel.org>; Fri, 08 May 2015 11:24:46 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv3 bluetooth-next 03/17] ieee802154: change transmit power to s32
Date: Fri,  8 May 2015 20:24:14 +0200
Message-Id: <1431109468-4891-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431109468-4891-1-git-send-email-alex.aring@gmail.com>
References: <1431109468-4891-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch change the transmit power from s8 to s32. This prepares to store a
mbm value instead dbm inside the transmit power variable. The old
interface keep the a s8 dbm value, which should be backward compatibility
when assign s8 to s32.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 2 +-
 include/net/cfg802154.h            | 2 +-
 include/net/mac802154.h            | 2 +-
 net/ieee802154/nl802154.c          | 6 +++---
 net/mac802154/driver-ops.h         | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 67d00fb..02b6bb7 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1194,7 +1194,7 @@ at86rf230_set_hw_addr_filt(struct ieee802154_hw *hw,
 }
 
 static int
-at86rf230_set_txpower(struct ieee802154_hw *hw, s8 db)
+at86rf230_set_txpower(struct ieee802154_hw *hw, s32 db)
 {
 	struct at86rf230_local *lp = hw->priv;
 
diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 6ea16c8..47804cd 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -85,7 +85,7 @@ struct wpan_phy {
 	u8 current_channel;
 	u8 current_page;
 	u32 channels_supported[IEEE802154_MAX_PAGE + 1];
-	s8 transmit_power;
+	s32 transmit_power;
 	struct wpan_phy_cca cca;
 
 	__le64 perm_extended_addr;
diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 7df28a4..400e4e8 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -213,7 +213,7 @@ struct ieee802154_ops {
 	int		(*set_hw_addr_filt)(struct ieee802154_hw *hw,
 					    struct ieee802154_hw_addr_filt *filt,
 					    unsigned long changed);
-	int		(*set_txpower)(struct ieee802154_hw *hw, s8 dbm);
+	int		(*set_txpower)(struct ieee802154_hw *hw, s32 dbm);
 	int		(*set_lbt)(struct ieee802154_hw *hw, bool on);
 	int		(*set_cca_mode)(struct ieee802154_hw *hw,
 					const struct wpan_phy_cca *cca);
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index d750d97..f3185c7 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -207,7 +207,7 @@ static const struct nla_policy nl802154_policy[NL802154_ATTR_MAX+1] = {
 	[NL802154_ATTR_PAGE] = { .type = NLA_U8, },
 	[NL802154_ATTR_CHANNEL] = { .type = NLA_U8, },
 
-	[NL802154_ATTR_TX_POWER] = { .type = NLA_S8, },
+	[NL802154_ATTR_TX_POWER] = { .type = NLA_S32, },
 
 	[NL802154_ATTR_CCA_MODE] = { .type = NLA_U32, },
 	[NL802154_ATTR_CCA_OPT] = { .type = NLA_U32, },
@@ -301,8 +301,8 @@ static int nl802154_send_wpan_phy(struct cfg802154_registered_device *rdev,
 			goto nla_put_failure;
 	}
 
-	if (nla_put_s8(msg, NL802154_ATTR_TX_POWER,
-		       rdev->wpan_phy.transmit_power))
+	if (nla_put_s32(msg, NL802154_ATTR_TX_POWER,
+			rdev->wpan_phy.transmit_power))
 		goto nla_put_failure;
 
 finish:
diff --git a/net/mac802154/driver-ops.h b/net/mac802154/driver-ops.h
index a053335..57c1bdb 100644
--- a/net/mac802154/driver-ops.h
+++ b/net/mac802154/driver-ops.h
@@ -58,7 +58,7 @@ drv_set_channel(struct ieee802154_local *local, u8 page, u8 channel)
 	return local->ops->set_channel(&local->hw, page, channel);
 }
 
-static inline int drv_set_tx_power(struct ieee802154_local *local, s8 dbm)
+static inline int drv_set_tx_power(struct ieee802154_local *local, s32 dbm)
 {
 	might_sleep();
 
-- 
2.3.7

