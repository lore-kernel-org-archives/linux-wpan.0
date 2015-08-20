Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34773 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246AbbHTQvk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 20 Aug 2015 12:51:40 -0400
Received: by wicne3 with SMTP id ne3so21338204wic.1
        for <linux-wpan@vger.kernel.org>; Thu, 20 Aug 2015 09:51:39 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFCv2 bluetooth-next 13/16] ieee802154: 6lowpan: add check for reserved dispatch
Date: Thu, 20 Aug 2015 18:47:42 +0200
Message-Id: <1440089265-23366-14-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1440089265-23366-1-git-send-email-alex.aring@gmail.com>
References: <1440089265-23366-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds checks for reserved dispatch value. When we have a
reserved dispatch value we should drop the skb immediately.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/rx.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index d309d91..f98ebf5 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -260,6 +260,17 @@ static inline bool lowpan_is_nalp(u8 dispatch)
 	return (dispatch & LOWPAN_DISPATCH_FIRST) == LOWPAN_DISPATCH_NALP;
 }
 
+/* Lookup for reserved dispatch values at:
+ * https://www.iana.org/assignments/_6lowpan-parameters/_6lowpan-parameters.xhtml#_6lowpan-parameters-1
+ */
+static inline bool lowpan_is_reserved(u8 dispatch)
+{
+	return ((dispatch >= 0x44 && dispatch <= 0x4F) ||
+		(dispatch >= 0x51 && dispatch <= 0x5F) ||
+		(dispatch >= 0xc8 && dispatch <= 0xdf) ||
+		(dispatch >= 0xe8 && dispatch <= 0xff));
+}
+
 /* lowpan_rx_h_check checks on generic 6LoWPAN requirements
  * in MAC and 6LoWPAN header.
  *
@@ -271,7 +282,8 @@ static inline bool lowpan_rx_h_check(struct sk_buff *skb)
 	if (unlikely(!skb->len))
 		return false;
 
-	if (lowpan_is_nalp(*skb_network_header(skb)))
+	if (lowpan_is_nalp(*skb_network_header(skb)) ||
+	    lowpan_is_reserved(*skb_network_header(skb)))
 		return false;
 
 	return true;
-- 
2.5.0

