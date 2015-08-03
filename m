Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33307 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbbHCGYI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 3 Aug 2015 02:24:08 -0400
Received: by wicmv11 with SMTP id mv11so121731212wic.0
        for <linux-wpan@vger.kernel.org>; Sun, 02 Aug 2015 23:24:07 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC 14/16] ieee802154: 6lowpan: add check for reserved dispatch
Date: Mon,  3 Aug 2015 08:23:53 +0200
Message-Id: <1438583035-6287-15-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds checks for reserved dispatch value by check on all known
dispatch values.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/rx.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index 146aa14..48869ac 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -248,6 +248,15 @@ static inline bool lowpan_is_nalp(u8 dispatch)
 	return (dispatch & LOWPAN_DISPATCH_FIRST) == LOWPAN_DISPATCH_NALP;
 }
 
+static inline bool lowpan_is_reserved(u8 dispatch)
+{
+	return !(lowpan_is_nalp(dispatch) || lowpan_is_iphc(dispatch) ||
+		 lowpan_is_ipv6(dispatch) || lowpan_is_hc1(dispatch) ||
+		 lowpan_is_bc0(dispatch) || lowpan_is_mesh(dispatch) ||
+		 lowpan_is_esc(dispatch) || lowpan_is_frag1(dispatch) ||
+		 lowpan_is_fragn(dispatch));
+}
+
 /* lowpan_rx_h_check checks on generic 6LoWPAN requirements
  * in MAC and 6LoWPAN header.
  *
@@ -259,7 +268,8 @@ static bool lowpan_rx_h_check(struct sk_buff *skb)
 	if (unlikely(!skb->len))
 		return false;
 
-	if (lowpan_is_nalp(*skb_network_header(skb)))
+	if (lowpan_is_nalp(*skb_network_header(skb)) ||
+	    lowpan_is_reserved(*skb_network_header(skb)))
 		return false;
 
 	return true;
-- 
2.5.0

