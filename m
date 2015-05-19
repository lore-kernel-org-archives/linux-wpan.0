Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:50614 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbbEST4i (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 May 2015 15:56:38 -0400
Date: Tue, 19 May 2015 22:49:56 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCH 1/8] ieee802154 socket: Return EMSGSIZE from raw_sendmsg() if
 packet too big.
Message-ID: <20150519194956.GM11014@wantstofly.org>
References: <cover.1432064518.git.buytenh@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1432064518.git.buytenh@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

The proper return code for trying to send a packet that exceeds the
outgoing interface's MTU is EMSGSIZE, not EINVAL, so patch ieee802154's
raw_sendmsg() to do the right thing.  (Its dgram_sendmsg() was already
returning EMSGSIZE for this case.)

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
---
 net/ieee802154/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index e4e112b..564a0e0 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -286,7 +286,7 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 
 	if (size > mtu) {
 		pr_debug("size = %Zu, mtu = %u\n", size, mtu);
-		err = -EINVAL;
+		err = -EMSGSIZE;
 		goto out_dev;
 	}
 
-- 
2.1.0

