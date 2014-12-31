Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:51202 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbaLaSjl (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 31 Dec 2014 13:39:41 -0500
Received: by mail-wi0-f177.google.com with SMTP id l15so25918159wiw.10
        for <linux-wpan@vger.kernel.org>; Wed, 31 Dec 2014 10:39:40 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 4/6] ieee802154: socket: fix checkpatch issue
Date: Wed, 31 Dec 2014 19:39:11 +0100
Message-Id: <1420051153-8673-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1420051153-8673-1-git-send-email-alex.aring@gmail.com>
References: <1420051153-8673-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch solves the following checkpatch issue:

CHECK: Comparison to NULL could be written "skb"
+		if (skb != NULL) {

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/af_ieee802154.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/af_ieee802154.c b/net/ieee802154/af_ieee802154.c
index 64beb0b..2878d8c 100644
--- a/net/ieee802154/af_ieee802154.c
+++ b/net/ieee802154/af_ieee802154.c
@@ -560,7 +560,7 @@ static int dgram_ioctl(struct sock *sk, int cmd, unsigned long arg)
 		amount = 0;
 		spin_lock_bh(&sk->sk_receive_queue.lock);
 		skb = skb_peek(&sk->sk_receive_queue);
-		if (skb != NULL) {
+		if (skb) {
 			/* We will only return the amount
 			 * of this packet since that is all
 			 * that will be read.
-- 
2.2.0

