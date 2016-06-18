Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:35977 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750947AbcFRIpy (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Sat, 18 Jun 2016 04:45:54 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH RESEND bluetooth-next 3/3] ieee802154: allow netns create of lowpan interface
Date: Sat, 18 Jun 2016 10:45:35 +0200
Message-Id: <20160618084535.4699-3-aar@pengutronix.de>
In-Reply-To: <20160618084535.4699-1-aar@pengutronix.de>
References: <20160618084535.4699-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <aar@pengutronix.de>, Nicolas Dichtel <nicolas.dichtel@6wind.com>

This patch reverts commit f9d1ce8f81eb ("ieee802154: fix netns settings").
The lowpan interface need to be created inside the net namespace where
the wpan interface is available. The wpan namespace can be changed only
by nl802154 before. Without this patch it's not possible to create a
lowpan interface for a wpan interface which isn't inside init_net
namespace.

Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/ieee802154/6lowpan/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 8c004a0..ee74df6 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -130,8 +130,7 @@ static int lowpan_newlink(struct net *src_net, struct net_device *ldev,
 
 	pr_debug("adding new link\n");
 
-	if (!tb[IFLA_LINK] ||
-	    !net_eq(dev_net(ldev), &init_net))
+	if (!tb[IFLA_LINK])
 		return -EINVAL;
 	/* find and hold wpan device */
 	wdev = dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK]));
-- 
2.8.3

