Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:45751 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbaJ1RWE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Oct 2014 13:22:04 -0400
Received: by mail-la0-f50.google.com with SMTP id s18so1055407lam.23
        for <linux-wpan@vger.kernel.org>; Tue, 28 Oct 2014 10:22:02 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 07/17] mac802154: remove might_sleep from driver layer
Date: Tue, 28 Oct 2014 18:21:22 +0100
Message-Id: <1414516892-4107-8-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes all might_sleep calls from driver layer. This
handling is already done by mac802154 layer.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 3 ---
 drivers/net/ieee802154/cc2520.c    | 1 -
 drivers/net/ieee802154/fakelb.c    | 4 ----
 3 files changed, 8 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 5068c1b..b83ad0b 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -993,7 +993,6 @@ at86rf230_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 static int
 at86rf230_ed(struct ieee802154_hw *hw, u8 *level)
 {
-	might_sleep();
 	BUG_ON(!level);
 	*level = 0xbe;
 	return 0;
@@ -1048,8 +1047,6 @@ at86rf230_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 	struct at86rf230_local *lp = hw->priv;
 	int rc;
 
-	might_sleep();
-
 	if (page < 0 || page > 31 ||
 	    !(lp->hw->phy->channels_supported[page] & BIT(channel))) {
 		WARN_ON(1);
diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 78ea2ca..c56d10c 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -574,7 +574,6 @@ cc2520_set_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 	struct cc2520_private *priv = hw->priv;
 	int ret;
 
-	might_sleep();
 	dev_dbg(&priv->spi->dev, "trying to set channel\n");
 
 	BUG_ON(page != 0);
diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index 4092e70..6e62286 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -47,7 +47,6 @@ struct fakelb_priv {
 static int
 fakelb_hw_ed(struct ieee802154_hw *hw, u8 *level)
 {
-	might_sleep();
 	BUG_ON(!level);
 	*level = 0xbe;
 
@@ -59,7 +58,6 @@ fakelb_hw_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 {
 	pr_debug("set channel to %d\n", channel);
 
-	might_sleep();
 	hw->phy->current_page = page;
 	hw->phy->current_channel = channel;
 
@@ -85,8 +83,6 @@ fakelb_hw_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 	struct fakelb_dev_priv *priv = hw->priv;
 	struct fakelb_priv *fake = priv->fake;
 
-	might_sleep();
-
 	read_lock_bh(&fake->lock);
 	if (priv->list.next == priv->list.prev) {
 		/* we are the only one device */
-- 
2.1.2

