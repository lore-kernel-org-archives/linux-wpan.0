Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:54199 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbaKIHh1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 9 Nov 2014 02:37:27 -0500
Received: by mail-wg0-f47.google.com with SMTP id a1so6584213wgh.20
        for <linux-wpan@vger.kernel.org>; Sat, 08 Nov 2014 23:37:26 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 03/15] ieee802154: rename wpan_phy_alloc
Date: Sun,  9 Nov 2014 08:36:47 +0100
Message-Id: <1415518619-4370-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
References: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch renames the wpan_phy_alloc function to wpan_phy_new. This
naming convention is like wireless and "wiphy_new" function.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h | 2 +-
 net/ieee802154/core.c   | 4 ++--
 net/mac802154/main.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index ac8dd3b..72c4723 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -88,7 +88,7 @@ struct wpan_dev {
 #define to_phy(_dev)	container_of(_dev, struct wpan_phy, dev)
 
 struct wpan_phy *
-wpan_phy_alloc(const struct cfg802154_ops *ops, size_t priv_size);
+wpan_phy_new(const struct cfg802154_ops *ops, size_t priv_size);
 static inline void wpan_phy_set_dev(struct wpan_phy *phy, struct device *dev)
 {
 	phy->dev.parent = dev;
diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index d1cd0ed..a3aa23f 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -70,7 +70,7 @@ int wpan_phy_for_each(int (*fn)(struct wpan_phy *phy, void *data),
 EXPORT_SYMBOL(wpan_phy_for_each);
 
 struct wpan_phy *
-wpan_phy_alloc(const struct cfg802154_ops *ops, size_t priv_size)
+wpan_phy_new(const struct cfg802154_ops *ops, size_t priv_size)
 {
 	static atomic_t wpan_phy_counter = ATOMIC_INIT(0);
 	struct cfg802154_registered_device *rdev;
@@ -105,7 +105,7 @@ wpan_phy_alloc(const struct cfg802154_ops *ops, size_t priv_size)
 
 	return &rdev->wpan_phy;
 }
-EXPORT_SYMBOL(wpan_phy_alloc);
+EXPORT_SYMBOL(wpan_phy_new);
 
 int wpan_phy_register(struct wpan_phy *phy)
 {
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 7d0ff7f..234084d 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -86,7 +86,7 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
 
 	priv_size = ALIGN(sizeof(*local), NETDEV_ALIGN) + priv_data_len;
 
-	phy = wpan_phy_alloc(&mac802154_config_ops, priv_size);
+	phy = wpan_phy_new(&mac802154_config_ops, priv_size);
 	if (!phy) {
 		pr_err("failure to allocate master IEEE802.15.4 device\n");
 		return NULL;
-- 
2.1.3

