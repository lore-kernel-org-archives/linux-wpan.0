Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34075 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbbHJRSA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 10 Aug 2015 13:18:00 -0400
Received: by wicne3 with SMTP id ne3so144599829wic.1
        for <linux-wpan@vger.kernel.org>; Mon, 10 Aug 2015 10:17:59 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/8] 6lowpan: Fix extraction of flow label field
Date: Mon, 10 Aug 2015 21:15:52 +0200
Message-Id: <1439234159-11630-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1439234159-11630-1-git-send-email-alex.aring@gmail.com>
References: <1439234159-11630-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Lukasz Duda <lukasz.duda@nordicsemi.no>, Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>, Alexander Aring <alex.aring@gmail.com>

From: Lukasz Duda <lukasz.duda@nordicsemi.no>

The lowpan_fetch_skb function is used to fetch the first byte,
which also increments the data pointer in skb structure,
making subsequent array lookup of byte 0 actually being byte 1.

To decompress the first byte of the Flow Label when the TF flag is
set to 0x01, the second half of the first byte is needed.

The patch fixes the extraction of the Flow Label field.

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Signed-off-by: Lukasz Duda <lukasz.duda@nordicsemi.no>
Signed-off-by: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/6lowpan/iphc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 9055d7b..74e56d7 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -284,7 +284,7 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
 		if (lowpan_fetch_skb(skb, &tmp, sizeof(tmp)))
 			return -EINVAL;
 
-		hdr.flow_lbl[0] = (skb->data[0] & 0x0F) | ((tmp >> 2) & 0x30);
+		hdr.flow_lbl[0] = (tmp & 0x0F) | ((tmp >> 2) & 0x30);
 		memcpy(&hdr.flow_lbl[1], &skb->data[0], 2);
 		skb_pull(skb, 2);
 		break;
-- 
2.5.0

