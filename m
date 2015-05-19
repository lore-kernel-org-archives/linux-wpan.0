Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:50612 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbbEST4h (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 May 2015 15:56:37 -0400
Date: Tue, 19 May 2015 22:50:15 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCH 6/8] ieee802154 socket: No need to check for
 ARPHRD_IEEE802154 in raw_bind().
Message-ID: <20150519195015.GR11014@wantstofly.org>
References: <cover.1432064518.git.buytenh@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1432064518.git.buytenh@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

ieee802154_get_dev() only returns devices that have dev->type ==
ARPHRD_IEEE802154, therefore, there is no need to check this again
in raw_bind().

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
---
 net/ieee802154/socket.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 564a0e0..d5a9298 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -228,15 +228,9 @@ static int raw_bind(struct sock *sk, struct sockaddr *_uaddr, int len)
 		goto out;
 	}
 
-	if (dev->type != ARPHRD_IEEE802154) {
-		err = -ENODEV;
-		goto out_put;
-	}
-
 	sk->sk_bound_dev_if = dev->ifindex;
 	sk_dst_reset(sk);
 
-out_put:
 	dev_put(dev);
 out:
 	release_sock(sk);
-- 
2.1.0

