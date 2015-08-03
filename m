Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:32903 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727AbbHCGXo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 3 Aug 2015 02:23:44 -0400
Received: by wicmv11 with SMTP id mv11so121721247wic.0
        for <linux-wpan@vger.kernel.org>; Sun, 02 Aug 2015 23:23:42 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC 02/16] ieee802154: 6lowpan: remove set to zero
Date: Mon,  3 Aug 2015 08:23:41 +0200
Message-Id: <1438583035-6287-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Internal mechanism by calling netdev_alloc which use kzalloc already
sets these variables to zero. This patch cleanup the setup of net_device.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 46efaca..ca331bc 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -88,9 +88,7 @@ static void lowpan_setup(struct net_device *ldev)
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

