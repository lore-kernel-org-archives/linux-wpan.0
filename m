Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-eopbgr20046.outbound.protection.outlook.com ([40.107.2.46]:25328
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729665AbeGQP7D (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 17 Jul 2018 11:59:03 -0400
Date: Tue, 17 Jul 2018 17:25:47 +0200
From: Rafael Vuijk <r.vuijk@sownet.nl>
Subject: [PATCH 1/2 v2] ieee802154: assembly of 6LoWPAN fragments improvement
Message-ID: <20180717152546.GA22664@Rafael-Mac.intra.sownet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

6LoWPAN reassembly length check matching first known packet length.

Signed-off-by: Rafael Vuijk <r.vuijk@sownet.nl>
--- ./net/ieee802154/6lowpan/reassembly.c	2018-02-20 11:10:06.000000000 +0100
+++ ./net/ieee802154/6lowpan/reassembly.c	2018-02-21 09:13:29.000000000 +0100
@@ -140,23 +140,14 @@ static int lowpan_frag_queue(struct lowp
 	offset = lowpan_802154_cb(skb)->d_offset << 3;
 	end = lowpan_802154_cb(skb)->d_size;
 
+	if (fq->q.len == 0)
+		fq->q.len = end;
+	if (fq->q.len != end)
+		goto err;
+
 	/* Is this the final fragment? */
 	if (offset + skb->len == end) {
-		/* If we already have some bits beyond end
-		 * or have different end, the segment is corrupted.
-		 */
-		if (end < fq->q.len ||
-		    ((fq->q.flags & INET_FRAG_LAST_IN) && end != fq->q.len))
-			goto err;
 		fq->q.flags |= INET_FRAG_LAST_IN;
-		fq->q.len = end;
-	} else {
-		if (end > fq->q.len) {
-			/* Some bits beyond end -> corruption. */
-			if (fq->q.flags & INET_FRAG_LAST_IN)
-				goto err;
-			fq->q.len = end;
-		}
 	}
 
 	/* Find out which fragments are in front and at the back of us

