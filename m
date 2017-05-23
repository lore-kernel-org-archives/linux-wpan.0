Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34293 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbdEWFWX (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 23 May 2017 01:22:23 -0400
From: Lin Zhang <xiaolou4617@gmail.com>
Subject: [PATCH net v2 1/2] net: ieee802154: remove explicit set skb->sk
Date: Tue, 23 May 2017 13:21:05 +0800
Message-Id: <1495516865-17019-1-git-send-email-xiaolou4617@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: aar@pengutronix.de, stefan@osg.samsung.com, davem@davemloft.net
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Lin Zhang <xiaolou4617@gmail.com>

Explicit set skb->sk is needless, sock_alloc_send_skb is already set it.

Signed-off-by: Lin Zhang <xiaolou4617@gmail.com>
Acked-by: Stefan Schmidt <stefan@osg.samsung.com>
---
changelog:

v1 -> v2:
        * split v1 into two patches, per Stefan Schmidt.

Thanks to Stefan Schmidt for reviewing !
---
 net/ieee802154/socket.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index eedba76..b01a1f0 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -301,7 +301,6 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		goto out_skb;
 
 	skb->dev = dev;
-	skb->sk  = sk;
 	skb->protocol = htons(ETH_P_IEEE802154);
 
 	dev_put(dev);
@@ -690,7 +689,6 @@ static int dgram_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		goto out_skb;
 
 	skb->dev = dev;
-	skb->sk  = sk;
 	skb->protocol = htons(ETH_P_IEEE802154);
 
 	dev_put(dev);
-- 
1.8.3.1

