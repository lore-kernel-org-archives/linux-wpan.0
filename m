Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36714 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013AbbIBMWH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 2 Sep 2015 08:22:07 -0400
Received: by wibz8 with SMTP id z8so63880418wib.1
        for <linux-wpan@vger.kernel.org>; Wed, 02 Sep 2015 05:22:06 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 04/16] ieee802154: 6lowpan: remove set to zero
Date: Wed,  2 Sep 2015 14:21:19 +0200
Message-Id: <1441196491-25013-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1441196491-25013-1-git-send-email-alex.aring@gmail.com>
References: <1441196491-25013-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Internal mechanism by calling netdev_alloc which use kzalloc already
sets these variables to zero. This patch cleanup the setup of net_device.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 3b75210..9f0cfa5 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -110,7 +110,6 @@ static void lowpan_setup(struct net_device *ldev)
 	ldev->mtu		= IPV6_MIN_MTU;
 	ldev->priv_flags	|= IFF_NO_QUEUE;
 	ldev->flags		= IFF_BROADCAST | IFF_MULTICAST;
-	ldev->watchdog_timeo	= 0;
 
 	ldev->netdev_ops	= &lowpan_netdev_ops;
 	ldev->header_ops	= &lowpan_header_ops;
-- 
2.5.1

