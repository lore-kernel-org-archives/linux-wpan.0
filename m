Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:14560
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729805AbeGQP7i (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 17 Jul 2018 11:59:38 -0400
Date: Tue, 17 Jul 2018 17:26:20 +0200
From: Rafael Vuijk <r.vuijk@sownet.nl>
Subject: [PATCH 2/2 v2] ieee802154: assembly of 6LoWPAN fragments improvement
Message-ID: <20180717152620.GB22664@Rafael-Mac.intra.sownet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

6LoWPAN reassembly fragment overlap checks.

Signed-off-by: Rafael Vuijk <r.vuijk@sownet.nl>
--- ./net/ieee802154/6lowpan/reassembly.c	2018-02-20 11:10:06.000000000 +0100
+++ ./net/ieee802154/6lowpan/reassembly.c	2018-02-21 09:13:29.000000000 +0100
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

