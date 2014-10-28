Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:62467 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbaJ1RV7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Oct 2014 13:21:59 -0400
Received: by mail-la0-f47.google.com with SMTP id pv20so1044789lab.6
        for <linux-wpan@vger.kernel.org>; Tue, 28 Oct 2014 10:21:57 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 03/17] mac802154: declare struct ieee802154_ops as const
Date: Tue, 28 Oct 2014 18:21:18 +0100
Message-Id: <1414516892-4107-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Alan Ott <alan@signal11.us>

The ieee802154_ops structure should be never changed during runtime.
This patch declare this structure as const to avoid a runtime change.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Cc: Alan Ott <alan@signal11.us>
---
 drivers/net/ieee802154/at86rf230.c | 2 +-
 drivers/net/ieee802154/cc2520.c    | 2 +-
 drivers/net/ieee802154/fakelb.c    | 2 +-
 drivers/net/ieee802154/mrf24j40.c  | 2 +-
 include/net/mac802154.h            | 2 +-
 net/mac802154/ieee802154_i.h       | 2 +-
 net/mac802154/main.c               | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index a155838..662efd3 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1214,7 +1214,7 @@ at86rf230_set_frame_retries(struct ieee802154_hw *hw, s8 retries)
 	return rc;
 }
 
-static struct ieee802154_ops at86rf230_ops = {
+static const struct ieee802154_ops at86rf230_ops = {
 	.owner = THIS_MODULE,
 	.xmit_async = at86rf230_xmit,
 	.ed = at86rf230_ed,
diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index a31b5b6..b479c9d 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -631,7 +631,7 @@ cc2520_filter(struct ieee802154_hw *hw,
 	return 0;
 }
 
-static struct ieee802154_ops cc2520_ops = {
+static const struct ieee802154_ops cc2520_ops = {
 	.owner = THIS_MODULE,
 	.start = cc2520_start,
 	.stop = cc2520_stop,
diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index db0703f..2a97cbb 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -129,7 +129,7 @@ fakelb_hw_stop(struct ieee802154_hw *hw) {
 	spin_unlock(&priv->lock);
 }
 
-static struct ieee802154_ops fakelb_ops = {
+static const struct ieee802154_ops fakelb_ops = {
 	.owner = THIS_MODULE,
 	.xmit_sync = fakelb_hw_xmit,
 	.ed = fakelb_hw_ed,
diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 7abb237..f19cf58 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -579,7 +579,7 @@ out:
 	return ret;
 }
 
-static struct ieee802154_ops mrf24j40_ops = {
+static const struct ieee802154_ops mrf24j40_ops = {
 	.owner = THIS_MODULE,
 	.xmit_sync = mrf24j40_tx,
 	.ed = mrf24j40_ed,
diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 4c4642e..0ea44cd 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -197,7 +197,7 @@ struct ieee802154_ops {
 
 /* Basic interface to register ieee802154 hwice */
 struct ieee802154_hw *
-ieee802154_alloc_hw(size_t priv_data_len, struct ieee802154_ops *ops);
+ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops);
 void ieee802154_free_hw(struct ieee802154_hw *hw);
 int ieee802154_register_hw(struct ieee802154_hw *hw);
 void ieee802154_unregister_hw(struct ieee802154_hw *hw);
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 4408c46..a379b97 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -28,7 +28,7 @@
 /* mac802154 device private data */
 struct ieee802154_local {
 	struct ieee802154_hw hw;
-	struct ieee802154_ops *ops;
+	const struct ieee802154_ops *ops;
 
 	/* ieee802154 phy */
 	struct wpan_phy *phy;
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 2c6d772..632707b 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -187,7 +187,7 @@ static void ieee802154_tasklet_handler(unsigned long data)
 }
 
 struct ieee802154_hw *
-ieee802154_alloc_hw(size_t priv_data_len, struct ieee802154_ops *ops)
+ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
 {
 	struct wpan_phy *phy;
 	struct ieee802154_local *local;
-- 
2.1.2

