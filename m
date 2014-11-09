Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37533 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbaKIHh3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 9 Nov 2014 02:37:29 -0500
Received: by mail-wi0-f176.google.com with SMTP id h11so7854690wiw.9
        for <linux-wpan@vger.kernel.org>; Sat, 08 Nov 2014 23:37:28 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 05/15] ieee802154: add iftype to wpan_dev
Date: Sun,  9 Nov 2014 08:36:49 +0100
Message-Id: <1415518619-4370-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
References: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds an iftype argument to the wpan_dev. This is needed to
get the interface type from netdev ieee802154_ptr. The subif data struct
can only accessible in mac802154 branch.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/cfg802154.h | 1 +
 net/mac802154/iface.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 72c4723..7e1bc21 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -64,6 +64,7 @@ struct wpan_phy {
 
 struct wpan_dev {
 	struct wpan_phy *wpan_phy;
+	int iftype;
 
 	/* MAC PIB */
 	__le16 pan_id;
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index c0b96cf5..4630ceb 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -404,6 +404,7 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata, int type)
 
 	/* set some type-dependent values */
 	sdata->vif.type = type;
+	sdata->wpan_dev.iftype = type;
 
 	get_random_bytes(&wpan_dev->bsn, 1);
 	get_random_bytes(&wpan_dev->dsn, 1);
-- 
2.1.3

