Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:58135 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755913AbaLWO3D (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Dec 2014 09:29:03 -0500
Received: by mail-wi0-f182.google.com with SMTP id h11so10966587wiw.15
        for <linux-wpan@vger.kernel.org>; Tue, 23 Dec 2014 06:29:02 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 3/7] ieee802154: 6lowpan: use skb_network_header
Date: Tue, 23 Dec 2014 15:28:25 +0100
Message-Id: <1419344909-16007-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1419344909-16007-1-git-send-email-alex.aring@gmail.com>
References: <1419344909-16007-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch is just a little cleanup to use *skb_network_header(skb)
instead of skb->data[0].

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index 22a1db4..a7b9d39 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -106,14 +106,14 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
 		goto drop_skb;
 
 	/* check that it's our buffer */
-	if (skb->data[0] == LOWPAN_DISPATCH_IPV6) {
+	if (*skb_network_header(skb) == LOWPAN_DISPATCH_IPV6) {
 		/* Pull off the 1-byte of 6lowpan header. */
 		if (lowpan_fetch_skb(skb, NULL, 1))
 			goto drop_skb;
 
 		return lowpan_give_skb_to_devices(skb, NULL);
 	} else {
-		switch (skb->data[0] & 0xe0) {
+		switch (*skb_network_header(skb) & 0xe0) {
 		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
 			ret = iphc_decompress(skb, &hdr);
 			if (ret < 0)
-- 
2.2.0

