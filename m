Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:55182 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755828AbaLWO27 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Dec 2014 09:28:59 -0500
Received: by mail-wg0-f49.google.com with SMTP id n12so9111710wgh.8
        for <linux-wpan@vger.kernel.org>; Tue, 23 Dec 2014 06:28:58 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/7] ieee802154: 6lowpan: skb_pull with error handling
Date: Tue, 23 Dec 2014 15:28:24 +0100
Message-Id: <1419344909-16007-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1419344909-16007-1-git-send-email-alex.aring@gmail.com>
References: <1419344909-16007-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch replaces a skb_pull with a lowpan_fetch_skb with has some
error handling functionaltiy if the skb data isn't enough to run a
skb_pull.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/rx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index 4be1d28..22a1db4 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -108,7 +108,9 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 	/* check that it's our buffer */
 	if (skb->data[0] == LOWPAN_DISPATCH_IPV6) {
 		/* Pull off the 1-byte of 6lowpan header. */
-		skb_pull(skb, 1);
+		if (lowpan_fetch_skb(skb, NULL, 1))
+			goto drop_skb;
+
 		return lowpan_give_skb_to_devices(skb, NULL);
 	} else {
 		switch (skb->data[0] & 0xe0) {
-- 
2.2.0

