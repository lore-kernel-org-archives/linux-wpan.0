Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37168 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268AbbJVKLf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 22 Oct 2015 06:11:35 -0400
Received: by wicfv8 with SMTP id fv8so112670952wic.0
        for <linux-wpan@vger.kernel.org>; Thu, 22 Oct 2015 03:11:34 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] ieee802154: 6lowpan: fix memory leak
Date: Thu, 22 Oct 2015 12:11:27 +0200
Message-Id: <1445508687-404-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, Alexander Aring <alex.aring@gmail.com>

Looking at current situation of memory management in 6lowpan receive
function I detected some invalid handling. After calling
lowpan_invoke_rx_handlers we will do a kfree_skb and then NET_RX_DROP on
error handling. We don't do this before, also on
skb_share_check/skb_unshare which might manipulate the reference
counters.

After running some 'grep -r "dev_add_pack" net/' to look how others
packet-layer receive callbacks works I detected that every subsystem do
a kfree_skb, then NET_RX_DROP without calling skb functions which
might manipulate the skb reference counters. This is the reason why we
should do the same here like all others subsystems. I didn't find any
documentation how the packet-layer receive callbacks handle NET_RX_DROP
return values either.

This patch will add a kfree_skb, then NET_RX_DROP handling for the
"trivial checks", in case of skb_share_check/skb_unshare the kfree_skb
call will be done inside these functions.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
References how other filesystem handle the callback:

[0] http://lxr.free-electrons.com/source/net/ipx/af_ipx.c#L1638
[1] http://lxr.free-electrons.com/source/net/can/af_can.c#L709
[2] http://lxr.free-electrons.com/source/net/phonet/af_phonet.c#L371

 net/ieee802154/6lowpan/rx.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index 403f171..ef185dd 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -284,16 +284,16 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
 	if (wdev->type != ARPHRD_IEEE802154 ||
 	    skb->pkt_type == PACKET_OTHERHOST ||
 	    !lowpan_rx_h_check(skb))
-		return NET_RX_DROP;
+		goto drop;
 
 	ldev = wdev->ieee802154_ptr->lowpan_dev;
 	if (!ldev || !netif_running(ldev))
-		return NET_RX_DROP;
+		goto drop;
 
 	/* Replacing skb->dev and followed rx handlers will manipulate skb. */
 	skb = skb_share_check(skb, GFP_ATOMIC);
 	if (!skb)
-		return NET_RX_DROP;
+		goto out;
 	skb->dev = ldev;
 
 	/* When receive frag1 it's likely that we manipulate the buffer.
@@ -304,10 +304,15 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
 	    lowpan_is_iphc(*skb_network_header(skb))) {
 		skb = skb_unshare(skb, GFP_ATOMIC);
 		if (!skb)
-			return NET_RX_DROP;
+			goto out;
 	}
 
 	return lowpan_invoke_rx_handlers(skb);
+
+drop:
+	kfree_skb(skb);
+out:
+	return NET_RX_DROP;
 }
 
 static struct packet_type lowpan_packet_type = {
-- 
2.6.1

