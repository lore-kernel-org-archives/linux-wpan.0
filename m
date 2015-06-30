Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail.nordicsemi.no ([194.19.86.146]:31219 "EHLO
	ironport01.nordicsemi.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbbF3Ke5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 30 Jun 2015 06:34:57 -0400
From: Lukasz Duda <lukasz.duda@nordicsemi.no>
Subject: [PATCH] 6lowpan: Fix extraction of flow label field
Date: Tue, 30 Jun 2015 03:24:52 -0700
Message-ID: <1435659892-22503-1-git-send-email-lukasz.duda@nordicsemi.no>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: alex.aring@gmail.com
Cc: jukka.rissanen@linux.intel.com, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>

The lowpan_fetch_skb function is used to fetch the first byte,
which also increments the data pointer in skb structure,
making subsequent array lookup of byte 0 actually being byte 1.

To decompress the first byte of the Flow Label when the TF flag is
set to 0x01, the second half of the first byte is needed.

The patch fixes the extraction of the Flow Label field.

Signed-off-by: Lukasz Duda <lukasz.duda@nordicsemi.no>
Signed-off-by: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
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
2.1.4

