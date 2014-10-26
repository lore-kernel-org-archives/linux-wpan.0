Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:43894 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbaJZIQy (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 26 Oct 2014 04:16:54 -0400
Received: by mail-lb0-f169.google.com with SMTP id 10so4296164lbg.14
        for <linux-wpan@vger.kernel.org>; Sun, 26 Oct 2014 01:16:52 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 11/15] mac802154: tx: cleanup crc calculation
Date: Sun, 26 Oct 2014 09:15:48 +0100
Message-Id: <1414311352-908-12-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414311352-908-1-git-send-email-alex.aring@gmail.com>
References: <1414311352-908-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/tx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index d39c7d9..70fd226 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -84,11 +84,9 @@ mac802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 	mac802154_monitors_rx(local, skb);
 
 	if (!(local->hw.flags & IEEE802154_HW_OMIT_CKSUM)) {
-		u16 crc = crc_ccitt(0, skb->data, skb->len);
-		u8 *data = skb_put(skb, 2);
+		__le16 crc = cpu_to_le16(crc_ccitt(0, skb->data, skb->len));
 
-		data[0] = crc & 0xff;
-		data[1] = crc >> 8;
+		memcpy(skb_put(skb, 2), &crc, 2);
 	}
 
 	if (skb_cow_head(skb, local->hw.extra_tx_headroom))
-- 
2.1.2

