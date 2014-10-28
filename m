Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:46807 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbaJ1RWA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Oct 2014 13:22:00 -0400
Received: by mail-la0-f42.google.com with SMTP id gq15so1083377lab.1
        for <linux-wpan@vger.kernel.org>; Tue, 28 Oct 2014 10:21:58 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 04/17] mac802154: ops: declare channel and page as u8
Date: Tue, 28 Oct 2014 18:21:19 +0100
Message-Id: <1414516892-4107-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Alan Ott <alan@signal11.us>

The range of channel and page fits into an unsigned byte range. This
patch changes the set_channel parameter definitions for channel and
page to u8.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Cc: Alan Ott <alan@signal11.us>
---
 drivers/net/ieee802154/at86rf230.c | 8 ++++----
 drivers/net/ieee802154/cc2520.c    | 2 +-
 drivers/net/ieee802154/fakelb.c    | 2 +-
 drivers/net/ieee802154/mrf24j40.c  | 3 +--
 include/net/mac802154.h            | 5 ++---
 5 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 662efd3..5068c1b 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -54,7 +54,7 @@ struct at86rf2xx_chip_data {
 	u16 t_tx_timeout;
 	int rssi_base_val;
 
-	int (*set_channel)(struct at86rf230_local *, int, int);
+	int (*set_channel)(struct at86rf230_local *, u8, u8);
 	int (*get_desense_steps)(struct at86rf230_local *, s32);
 };
 
@@ -1012,13 +1012,13 @@ at86rf230_stop(struct ieee802154_hw *hw)
 }
 
 static int
-at86rf23x_set_channel(struct at86rf230_local *lp, int page, int channel)
+at86rf23x_set_channel(struct at86rf230_local *lp, u8 page, u8 channel)
 {
 	return at86rf230_write_subreg(lp, SR_CHANNEL, channel);
 }
 
 static int
-at86rf212_set_channel(struct at86rf230_local *lp, int page, int channel)
+at86rf212_set_channel(struct at86rf230_local *lp, u8 page, u8 channel)
 {
 	int rc;
 
@@ -1043,7 +1043,7 @@ at86rf212_set_channel(struct at86rf230_local *lp, int page, int channel)
 }
 
 static int
-at86rf230_channel(struct ieee802154_hw *hw, int page, int channel)
+at86rf230_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 {
 	struct at86rf230_local *lp = hw->priv;
 	int rc;
diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index b479c9d..78ea2ca 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -569,7 +569,7 @@ cc2520_ed(struct ieee802154_hw *hw, u8 *level)
 }
 
 static int
-cc2520_set_channel(struct ieee802154_hw *hw, int page, int channel)
+cc2520_set_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 {
 	struct cc2520_private *priv = hw->priv;
 	int ret;
diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index 2a97cbb..4092e70 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -55,7 +55,7 @@ fakelb_hw_ed(struct ieee802154_hw *hw, u8 *level)
 }
 
 static int
-fakelb_hw_channel(struct ieee802154_hw *hw, int page, int channel)
+fakelb_hw_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 {
 	pr_debug("set channel to %d\n", channel);
 
diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index f19cf58..52b3d31 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -423,8 +423,7 @@ static void mrf24j40_stop(struct ieee802154_hw *hw)
 	write_short_reg(devrec, REG_INTCON, val);
 }
 
-static int mrf24j40_set_channel(struct ieee802154_hw *hw,
-				int page, int channel)
+static int mrf24j40_set_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 {
 	struct mrf24j40 *devrec = hw->priv;
 	u8 val;
diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 0ea44cd..85a4efc 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -178,9 +178,8 @@ struct ieee802154_ops {
 	int		(*xmit_async)(struct ieee802154_hw *hw,
 				      struct sk_buff *skb);
 	int		(*ed)(struct ieee802154_hw *hw, u8 *level);
-	int		(*set_channel)(struct ieee802154_hw *hw,
-				       int page,
-				       int channel);
+	int		(*set_channel)(struct ieee802154_hw *hw, u8 page,
+				       u8 channel);
 	int		(*set_hw_addr_filt)(struct ieee802154_hw *hw,
 					    struct ieee802154_hw_addr_filt *filt,
 					    unsigned long changed);
-- 
2.1.2

