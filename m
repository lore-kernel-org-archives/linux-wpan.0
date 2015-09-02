Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35894 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460AbbIBMWR (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 2 Sep 2015 08:22:17 -0400
Received: by wibz8 with SMTP id z8so63885464wib.1
        for <linux-wpan@vger.kernel.org>; Wed, 02 Sep 2015 05:22:16 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 13/16] ieee802154: 6lowpan: add check for reserved dispatch
Date: Wed,  2 Sep 2015 14:21:28 +0200
Message-Id: <1441196491-25013-14-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1441196491-25013-1-git-send-email-alex.aring@gmail.com>
References: <1441196491-25013-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds checks for reserved dispatch value. When we have a
reserved dispatch value we should drop the skb immediately.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/rx.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index a9216f1..45ce121 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -260,6 +260,19 @@ static inline bool lowpan_is_nalp(u8 dispatch)
 	return (dispatch & LOWPAN_DISPATCH_FIRST) == LOWPAN_DISPATCH_NALP;
 }
 
+/* Lookup for reserved dispatch values at:
+ * https://www.iana.org/assignments/_6lowpan-parameters/_6lowpan-parameters.xhtml#_6lowpan-parameters-1
+ *
+ * Last Updated: 2015-01-22
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
@@ -271,7 +284,8 @@ static inline bool lowpan_rx_h_check(struct sk_buff *skb)
 	if (unlikely(!skb->len))
 		return false;
 
-	if (lowpan_is_nalp(*skb_network_header(skb)))
+	if (lowpan_is_nalp(*skb_network_header(skb)) ||
+	    lowpan_is_reserved(*skb_network_header(skb)))
 		return false;
 
 	return true;
-- 
2.5.1

