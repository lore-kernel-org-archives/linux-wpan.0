Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:36264 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbeGBUcS (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Jul 2018 16:32:18 -0400
Received: by mail-it0-f65.google.com with SMTP id h19-v6so123335itf.1
        for <linux-wpan@vger.kernel.org>; Mon, 02 Jul 2018 13:32:17 -0700 (PDT)
From: Alexander Aring <aring@mojatatu.com>
Subject: [PATCH wpan 2/2] net: mac802154: tx: expand tailroom if necessary
Date: Mon,  2 Jul 2018 16:32:03 -0400
Message-Id: <20180702203203.21316-2-aring@mojatatu.com>
In-Reply-To: <20180702203203.21316-1-aring@mojatatu.com>
References: <20180702203203.21316-1-aring@mojatatu.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, kernel@mojatatu.com, Alexander Aring <aring@mojatatu.com>

This patch is necessary if case of AF_PACKET or other socket interface
which I am aware of it and didn't allocated the necessary room.

Reported-by: David Palma <david.palma@ntnu.no>
Reported-by: Rabi Narayan Sahoo <rabinarayans0828@gmail.com>
Signed-off-by: Alexander Aring <aring@mojatatu.com>
---
 net/mac802154/tx.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 7e253455f9dd..bcd1a5e6ebf4 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -63,8 +63,21 @@ ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 	int ret;
 
 	if (!(local->hw.flags & IEEE802154_HW_TX_OMIT_CKSUM)) {
-		u16 crc = crc_ccitt(0, skb->data, skb->len);
+		struct sk_buff *nskb;
+		u16 crc;
+
+		if (unlikely(skb_tailroom(skb) < IEEE802154_FCS_LEN)) {
+			nskb = skb_copy_expand(skb, 0, IEEE802154_FCS_LEN,
+					       GFP_ATOMIC);
+			if (likely(nskb)) {
+				consume_skb(skb);
+				skb = nskb;
+			} else {
+				goto err_tx;
+			}
+		}
 
+		crc = crc_ccitt(0, skb->data, skb->len);
 		put_unaligned_le16(crc, skb_put(skb, 2));
 	}
 
-- 
2.11.0

