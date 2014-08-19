Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:40082 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715AbaHSJDS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Aug 2014 05:03:18 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth 4/5] ieee802154: 6lowpan: ensure of sending 1280 packets
Date: Tue, 19 Aug 2014 11:03:02 +0200
Message-Id: <1408438983-13892-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1408438983-13892-1-git-send-email-alex.aring@gmail.com>
References: <1408438983-13892-1-git-send-email-alex.aring@gmail.com>
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
2.0.3

