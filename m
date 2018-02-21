Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-db5eur01on0077.outbound.protection.outlook.com ([104.47.2.77]:35072
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753391AbeBULfy (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 21 Feb 2018 06:35:54 -0500
Date: Wed, 21 Feb 2018 12:35:40 +0100
From: Rafael Vuijk <r.vuijk@sownet.nl>
Subject: [PATCH] ieee802154: assembly of 6LoWPAN fragments improvement
Message-ID: <20180221113540.GA54319@Rafael-Mac.intra.sownet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hi,

We have tested the 6LoWPAN modules in the Linux kernel and came to some issue regarding fragmentation. We have seen aborted SCP transfers ("message authentication code incorrect") and tested TCP transfers as well and saw corruption on fragment-sized intervals. The current fragment assembling functions do not check enough for corrupted L2 packets that might slip through L2 CRC check. (in our case IEEE802.15.4 which has only 16-bit CRC).
As a result, overlapping fragments due to offset corruption are not detected and assembled incorrectly. Part of packets may have old data. At TCP-level, there is only a simple TCP-checksum which is not enough in this case as the corruption occurs frequently (once every few minutes).

After quickly analysing the code we saw some potential issues and created a patch that adds additional overlap checks and simplifies some conditional statements. After running tests again, TCP corruption was not seen again. The test was performed with SCP and keeps transferring large files now without error.

Rafael Vuijk

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
@@ -179,6 +170,13 @@ static int lowpan_frag_queue(struct lowp
 	}
 
 found:
+	/* Current fragment overlaps with previous fragment? */
+	if (prev && (lowpan_802154_cb(prev)->d_offset << 3) + prev->len > offset)
+		goto err;
+	/* Current fragment overlaps with next fragment? */
+	if (next && offset + skb->len > lowpan_802154_cb(next)->d_offset << 3)
+		goto err;
+
 	/* Insert this fragment in the chain of fragments. */
 	skb->next = next;
 	if (!next)

--

