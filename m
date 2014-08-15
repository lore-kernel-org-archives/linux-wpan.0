Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:59088 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815AbaHOKaD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 15 Aug 2014 06:30:03 -0400
Received: by mail-wi0-f176.google.com with SMTP id bs8so649403wib.9
        for <linux-wpan@vger.kernel.org>; Fri, 15 Aug 2014 03:30:01 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Fri, 15 Aug 2014 12:29:42 +0200
Message-Id: <1408098592-13412-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1408098592-13412-1-git-send-email-alex.aring@gmail.com>
References: <1408098592-13412-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 02/12] mac802154: make struct ieee802154_ops const
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

The ieee802154_ops should never be changed during runtime.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 2 +-
 drivers/net/ieee802154/cc2520.c    | 2 +-
 drivers/net/ieee802154/mrf24j40.c  | 2 +-
 include/net/mac802154.h            | 2 +-
 net/mac802154/ieee802154_i.h       | 2 +-
 net/mac802154/main.c               | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index c2fc833..9a77b16 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1235,7 +1235,7 @@ at86rf230_set_frame_retries(struct ieee802154_hw *hw, s8 retries)
 	return rc;
 }
 
-static struct ieee802154_ops at86rf230_ops = {
+static const struct ieee802154_ops at86rf230_ops = {
 	.owner = THIS_MODULE,
 	.xmit = at86rf230_xmit,
 	.ed = at86rf230_ed,
diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index defd954..86bed88 100644
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
diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 5189dad..a391b85 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -577,7 +577,7 @@ out:
 	return ret;
 }
 
-static struct ieee802154_ops mrf24j40_ops = {
+static const struct ieee802154_ops mrf24j40_ops = {
 	.owner = THIS_MODULE,
 	.xmit = mrf24j40_tx,
 	.ed = mrf24j40_ed,
diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 4666b98..311e595 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -186,7 +186,7 @@ struct ieee802154_ops {
 
 /* Basic interface to register ieee802154 hwice */
 struct ieee802154_hw *
-ieee802154_alloc_hw(size_t priv_data_len, struct ieee802154_ops *ops);
+ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops);
 void ieee802154_free_hw(struct ieee802154_hw *hw);
 int ieee802154_register_hw(struct ieee802154_hw *hw);
 void ieee802154_unregister_hw(struct ieee802154_hw *hw);
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index d6b961a..cb81f67 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -77,7 +77,7 @@ struct ieee802154_sub_if_data {
 /* mac802154 device private data */
 struct ieee802154_local {
 	struct ieee802154_hw hw;
-	struct ieee802154_ops *ops;
+	const struct ieee802154_ops *ops;
 
 	/* ieee802154 phy */
 	struct wpan_phy *phy;
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 3740c76..0f4810f 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -182,7 +182,7 @@ static void ieee802154_tasklet_handler(unsigned long data)
 }
 
 struct ieee802154_hw *
-ieee802154_alloc_hw(size_t priv_data_len, struct ieee802154_ops *ops)
+ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
 {
 	struct wpan_phy *phy;
 	struct ieee802154_local *local;
-- 
2.0.3

