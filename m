Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:50682 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754935AbaKLChs (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Nov 2014 21:37:48 -0500
Received: by mail-wg0-f41.google.com with SMTP id k14so13042718wgh.14
        for <linux-wpan@vger.kernel.org>; Tue, 11 Nov 2014 18:37:47 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 04/18] mac802154: add wpan_phy priv id
Date: Wed, 12 Nov 2014 03:36:51 +0100
Message-Id: <1415759825-8309-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
References: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds an unique id for an wpan_phy. This behaviour is mostly
grabbed from wireless stack. This is needed for upcomming patches which
identify the wpan netdev while NETDEV_CHANGENAME in netdev notify function.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h      | 8 ++++++++
 net/mac802154/ieee802154_i.h | 3 +++
 net/mac802154/main.c         | 2 ++
 net/mac802154/util.c         | 3 +++
 4 files changed, 16 insertions(+)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index e5570e0..3695152 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -42,6 +42,14 @@ struct cfg802154_ops {
 struct wpan_phy {
 	struct mutex pib_lock;
 
+	/* If multiple wpan_phys are registered and you're handed e.g.
+	 * a regular netdev with assigned ieee802154_ptr, you won't
+	 * know whether it points to a wpan_phy your driver has registered
+	 * or not. Assign this to something global to your driver to
+	 * help determine whether you own this wpan_phy or not.
+	 */
+	const void *privid;
+
 	/*
 	 * This is a PIB according to 802.15.4-2011.
 	 * We do not provide timing-related variables, as they
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index abb1970..4be5e23 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -96,6 +96,9 @@ struct ieee802154_sub_if_data {
 
 #define MAC802154_CHAN_NONE		0xff /* No channel is assigned */
 
+/* utility functions/constants */
+extern const void *const mac802154_wpan_phy_privid; /*  for wpan_phy privid */
+
 static inline struct ieee802154_local *
 hw_to_local(struct ieee802154_hw *hw)
 {
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 709dcc5..24e8ca6 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -92,6 +92,8 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
 		return NULL;
 	}
 
+	phy->privid = mac802154_wpan_phy_privid;
+
 	local = wpan_phy_priv(phy);
 	local->phy = phy;
 	local->hw.phy = local->phy;
diff --git a/net/mac802154/util.c b/net/mac802154/util.c
index 117e4ef..9a04e4a 100644
--- a/net/mac802154/util.c
+++ b/net/mac802154/util.c
@@ -15,6 +15,9 @@
 
 #include "ieee802154_i.h"
 
+/* privid for wpan_phys to determine whether they belong to us or not */
+const void *const mac802154_wpan_phy_privid = &mac802154_wpan_phy_privid;
+
 void ieee802154_wake_queue(struct ieee802154_hw *hw)
 {
 	struct ieee802154_local *local = hw_to_local(hw);
-- 
2.1.3

