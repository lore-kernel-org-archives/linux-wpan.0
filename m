Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53263 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755237AbcAYH7A (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 25 Jan 2016 02:59:00 -0500
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCHv2 bluetooth-next 2/2] ieee802154: 6lowpan: fix return of netdev notifier
Date: Mon, 25 Jan 2016 08:58:55 +0100
Message-Id: <1453708735-29931-3-git-send-email-aar@pengutronix.de>
In-Reply-To: <1453708735-29931-1-git-send-email-aar@pengutronix.de>
References: <1453708735-29931-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de, mcr@sandelman.ca, lukasz.duda@nordicsemi.no, Alexander Aring <aar@pengutronix.de>

This patch fixed the return value of netdev notifier. If the command is
a don't care a NOTIFY_DONE should be returned. If the command matched a
NOTIFY_OK should be returned.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/ieee802154/6lowpan/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 737c87a..0023c90 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -207,7 +207,7 @@ static int lowpan_device_event(struct notifier_block *unused,
 	struct net_device *wdev = netdev_notifier_info_to_dev(ptr);
 
 	if (wdev->type != ARPHRD_IEEE802154)
-		goto out;
+		return NOTIFY_DONE;
 
 	switch (event) {
 	case NETDEV_UNREGISTER:
@@ -219,11 +219,10 @@ static int lowpan_device_event(struct notifier_block *unused,
 			lowpan_dellink(wdev->ieee802154_ptr->lowpan_dev, NULL);
 		break;
 	default:
-		break;
+		return NOTIFY_DONE;
 	}
 
-out:
-	return NOTIFY_DONE;
+	return NOTIFY_OK;
 }
 
 static struct notifier_block lowpan_dev_notifier = {
-- 
2.7.0

