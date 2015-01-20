Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:53541 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbbATU6N (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 20 Jan 2015 15:58:13 -0500
Received: by mail-wi0-f169.google.com with SMTP id bs8so27731532wib.0
        for <linux-wpan@vger.kernel.org>; Tue, 20 Jan 2015 12:58:12 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 1/4] ieee802154: set wpan netdev devtype
Date: Tue, 20 Jan 2015 21:57:39 +0100
Message-Id: <1421787462-24042-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1421787462-24042-1-git-send-email-alex.aring@gmail.com>
References: <1421787462-24042-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch adds the setting for the netdev devtype. Like wireless which
sets this value to "wlan", this patch will set this value to "wpan".

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index 18bc7e7..b99971f 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -199,6 +199,10 @@ void cfg802154_dev_free(struct cfg802154_registered_device *rdev)
 	kfree(rdev);
 }
 
+static const struct device_type wpan_phy_type = {
+	.name	= "wpan",
+};
+
 static void
 cfg802154_update_iface_num(struct cfg802154_registered_device *rdev,
 			   int iftype, int num)
@@ -223,7 +227,9 @@ static int cfg802154_netdev_notifier_call(struct notifier_block *nb,
 	/* TODO WARN_ON unspec type */
 
 	switch (state) {
-		/* TODO NETDEV_DEVTYPE */
+	case NETDEV_POST_INIT:
+		SET_NETDEV_DEVTYPE(dev, &wpan_phy_type);
+		break;
 	case NETDEV_REGISTER:
 		wpan_dev->identifier = ++rdev->wpan_dev_id;
 		list_add_rcu(&wpan_dev->list, &rdev->wpan_dev_list);
-- 
2.2.2

