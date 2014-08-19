Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:64289 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbaHSREA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Aug 2014 13:04:00 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth 4/5] ieee802154: 6lowpan: ensure of sending 1280 packets
Date: Tue, 19 Aug 2014 19:03:31 +0200
Message-Id: <1408467812-30483-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1408467812-30483-1-git-send-email-alex.aring@gmail.com>
References: <1408467812-30483-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch changes the 1281 MTU to 1280. Others stack have only a 1280
byte array for uncompressed 6LoWPAN packets, this avoid that these
stacks have an overflow. Sending 1281 uncompressed 6LoWPAN packets isn't
also rfc complaint.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan_rtnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index 71fa7d4..6591d27 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -437,7 +437,7 @@ static void lowpan_setup(struct net_device *dev)
 	/* Frame Control + Sequence Number + Address fields + Security Header */
 	dev->hard_header_len	= 2 + 1 + 20 + 14;
 	dev->needed_tailroom	= 2; /* FCS */
-	dev->mtu		= 1281;
+	dev->mtu		= IPV6_MIN_MTU;
 	dev->tx_queue_len	= 0;
 	dev->flags		= IFF_BROADCAST | IFF_MULTICAST;
 	dev->watchdog_timeo	= 0;
-- 
2.0.4

