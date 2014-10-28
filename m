Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:57836 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbaJ1RWM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Oct 2014 13:22:12 -0400
Received: by mail-lb0-f169.google.com with SMTP id l4so1038353lbv.28
        for <linux-wpan@vger.kernel.org>; Tue, 28 Oct 2014 10:22:11 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 15/17] mac802154: move mac_params functions into mac_cmd
Date: Tue, 28 Oct 2014 18:21:30 +0100
Message-Id: <1414516892-4107-16-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
References: <1414516892-4107-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

These functions can be static in mac_cmd file.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h |  5 -----
 net/mac802154/mac_cmd.c      | 22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 46c9fe7..7cebc98 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -140,11 +140,6 @@ void mac802154_dev_set_pan_id(struct net_device *dev, __le16 val);
 void mac802154_dev_set_page_channel(struct net_device *dev, u8 page, u8 chan);
 u8 mac802154_dev_get_dsn(const struct net_device *dev);
 
-int mac802154_set_mac_params(struct net_device *dev,
-			     const struct ieee802154_mac_params *params);
-void mac802154_get_mac_params(struct net_device *dev,
-			      struct ieee802154_mac_params *params);
-
 int mac802154_get_params(struct net_device *dev,
 			 struct ieee802154_llsec_params *params);
 int mac802154_set_params(struct net_device *dev,
diff --git a/net/mac802154/mac_cmd.c b/net/mac802154/mac_cmd.c
index ed767f5..fc261ab 100644
--- a/net/mac802154/mac_cmd.c
+++ b/net/mac802154/mac_cmd.c
@@ -82,6 +82,28 @@ static struct wpan_phy *mac802154_get_phy(const struct net_device *dev)
 	return to_phy(get_device(&sdata->local->phy->dev));
 }
 
+static int mac802154_set_mac_params(struct net_device *dev,
+				    const struct ieee802154_mac_params *params)
+{
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
+
+	mutex_lock(&sdata->local->iflist_mtx);
+	sdata->mac_params = *params;
+	mutex_unlock(&sdata->local->iflist_mtx);
+
+	return 0;
+}
+
+static void mac802154_get_mac_params(struct net_device *dev,
+				     struct ieee802154_mac_params *params)
+{
+	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
+
+	mutex_lock(&sdata->local->iflist_mtx);
+	*params = sdata->mac_params;
+	mutex_unlock(&sdata->local->iflist_mtx);
+}
+
 static struct ieee802154_llsec_ops mac802154_llsec_ops = {
 	.get_params = mac802154_get_params,
 	.set_params = mac802154_set_params,
-- 
2.1.2

