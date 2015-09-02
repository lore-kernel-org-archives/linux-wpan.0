Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36924 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060AbbIBSGY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 2 Sep 2015 14:06:24 -0400
Received: by wicfx3 with SMTP id fx3so27515847wic.0
        for <linux-wpan@vger.kernel.org>; Wed, 02 Sep 2015 11:06:23 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] ieee802154: 6lowpan: fix drop return value
Date: Wed,  2 Sep 2015 20:05:42 +0200
Message-Id: <1441217142-21315-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch changes the return value of lowpan packet receive handler to
the correct NET_RX_DROP instead RX_DROP.

This issue was detected by sparse and reported from Marcel:
net/ieee802154/6lowpan/rx.c:329:32:    expected int
net/ieee802154/6lowpan/rx.c:329:32:    got restricted lowpan_rx_result ...

Reported-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index 856052b..3c31980 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -326,7 +326,7 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *wdev,
 	    lowpan_is_iphc(*skb_network_header(skb))) {
 		skb = skb_unshare(skb, GFP_ATOMIC);
 		if (!skb)
-			return RX_DROP;
+			return NET_RX_DROP;
 	}
 
 	return lowpan_invoke_rx_handlers(skb);
-- 
2.5.1

