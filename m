Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36518 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224AbbHTQv2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 20 Aug 2015 12:51:28 -0400
Received: by wicja10 with SMTP id ja10so150526303wic.1
        for <linux-wpan@vger.kernel.org>; Thu, 20 Aug 2015 09:51:27 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFCv2 bluetooth-next 04/16] ieee802154: 6lowpan: remove set to zero
Date: Thu, 20 Aug 2015 18:47:33 +0200
Message-Id: <1440089265-23366-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1440089265-23366-1-git-send-email-alex.aring@gmail.com>
References: <1440089265-23366-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Internal mechanism by calling netdev_alloc which use kzalloc already
sets these variables to zero. This patch cleanup the setup of net_device.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 6607bb4..215d673 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -108,9 +108,7 @@ static void lowpan_setup(struct net_device *ldev)
 	ldev->hard_header_len	= 2 + 1 + 20 + 14;
 	ldev->needed_tailroom	= 2; /* FCS */
 	ldev->mtu		= IPV6_MIN_MTU;
-	ldev->tx_queue_len	= 0;
 	ldev->flags		= IFF_BROADCAST | IFF_MULTICAST;
-	ldev->watchdog_timeo	= 0;
 
 	ldev->netdev_ops	= &lowpan_netdev_ops;
 	ldev->header_ops	= &lowpan_header_ops;
-- 
2.5.0

