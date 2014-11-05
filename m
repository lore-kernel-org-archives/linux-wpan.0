Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:43417 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbaKETwQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 5 Nov 2014 14:52:16 -0500
Received: by mail-wi0-f169.google.com with SMTP id n3so12408683wiv.4
        for <linux-wpan@vger.kernel.org>; Wed, 05 Nov 2014 11:52:15 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 08/18] mac802154: add default interface registration
Date: Wed,  5 Nov 2014 20:51:19 +0100
Message-Id: <1415217089-24919-9-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
References: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a default interface registration for a wpan interface
type. Currently the 802.15.4 subsystem need to call userspace tools to
add an interface. This patch is like mac80211 handling for registration
a station interface type by default.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index a371eb5..7d0ff7f 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -126,6 +126,7 @@ EXPORT_SYMBOL(ieee802154_free_hw);
 int ieee802154_register_hw(struct ieee802154_hw *hw)
 {
 	struct ieee802154_local *local = hw_to_local(hw);
+	struct net_device *dev;
 	int rc = -ENOSYS;
 
 	local->workqueue =
@@ -141,6 +142,17 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
 	if (rc < 0)
 		goto out_wq;
 
+	rtnl_lock();
+
+	dev = ieee802154_if_add(local, "wpan%d", NULL, IEEE802154_DEV_WPAN);
+	if (IS_ERR(dev)) {
+		rtnl_unlock();
+		rc = PTR_ERR(dev);
+		goto out_wq;
+	}
+
+	rtnl_unlock();
+
 	return 0;
 
 out_wq:
-- 
2.1.3

