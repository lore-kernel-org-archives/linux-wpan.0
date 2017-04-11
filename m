Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35470 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753385AbdDKTVM (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Apr 2017 15:21:12 -0400
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 1/6] 6lowpan: Don't set IFF_NO_QUEUE
Date: Tue, 11 Apr 2017 22:20:58 +0300
Message-Id: <20170411192103.3209-1-luiz.dentz@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: patrik.flykt@linux.intel.com, aar@pengutronix.de, jukka.rissanen@linux.intel.com, linux-wpan@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

There is no point in setting IFF_NO_QUEUE should already have taken
care of setting it if tx_queue_len is not set, in fact this may
actually disable queue for interfaces that require it and do set
tx_queue_len.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/6lowpan/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
index 5f9909a..40d3d72 100644
--- a/net/6lowpan/core.c
+++ b/net/6lowpan/core.c
@@ -35,7 +35,6 @@ int lowpan_register_netdevice(struct net_device *dev,
 
 	dev->type = ARPHRD_6LOWPAN;
 	dev->mtu = IPV6_MIN_MTU;
-	dev->priv_flags |= IFF_NO_QUEUE;
 
 	lowpan_dev(dev)->lltype = lltype;
 
-- 
2.9.3

