Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37429 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932162AbbHJRSH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 10 Aug 2015 13:18:07 -0400
Received: by wibhh20 with SMTP id hh20so160201443wib.0
        for <linux-wpan@vger.kernel.org>; Mon, 10 Aug 2015 10:18:06 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 8/8] ieee802154: 6lowpan: fix error frag handling
Date: Mon, 10 Aug 2015 21:15:59 +0200
Message-Id: <1439234159-11630-9-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1439234159-11630-1-git-send-email-alex.aring@gmail.com>
References: <1439234159-11630-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch fixes the error handling for lowpan_xmit_fragment by replace
"-PTR_ERR" to "PTR_ERR". PTR_ERR returns already a negative errno code.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index 1bf4a30..f6263fc 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -112,7 +112,7 @@ lowpan_xmit_fragment(struct sk_buff *skb, const struct ieee802154_hdr *wpan_hdr,
 
 	frag = lowpan_alloc_frag(skb, frag_hdrlen + len, wpan_hdr);
 	if (IS_ERR(frag))
-		return -PTR_ERR(frag);
+		return PTR_ERR(frag);
 
 	memcpy(skb_put(frag, frag_hdrlen), frag_hdr, frag_hdrlen);
 	memcpy(skb_put(frag, len), skb_network_header(skb) + offset, len);
-- 
2.5.0

