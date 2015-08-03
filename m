Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38087 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbbHCGYE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 3 Aug 2015 02:24:04 -0400
Received: by wibxm9 with SMTP id xm9so99676864wib.1
        for <linux-wpan@vger.kernel.org>; Sun, 02 Aug 2015 23:24:03 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC 11/16] ieee802154: 6lowpan: fix fragmentation dispatch mask
Date: Mon,  3 Aug 2015 08:23:50 +0200
Message-Id: <1438583035-6287-12-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch fix the dispatch fragmentation masking. With "0xe" we also
get some reserved dispatch values.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/rx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index b0066b7..595830f 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -122,7 +122,8 @@ static lowpan_rx_result lowpan_rx_h_frag(struct sk_buff *skb)
 	      lowpan_is_fragn(*skb_network_header(skb))))
 		return RX_CONTINUE;
 
-	ret = lowpan_frag_rcv(skb, *skb_network_header(skb) & 0xe0);
+	ret = lowpan_frag_rcv(skb, *skb_network_header(skb) &
+			      LOWPAN_DISPATCH_FRAG_MASK);
 	if (ret == 1)
 		return RX_CONTINUE;
 
-- 
2.5.0

