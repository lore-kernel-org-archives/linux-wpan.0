Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38015 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbbEHI4n (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 May 2015 04:56:43 -0400
From: Martin Townsend <mtownsend1973@gmail.com>
Subject: [PATCH bluetooth-next] mac802154: fakelb: Fix potential NULL pointer deference.
Date: Fri,  8 May 2015 09:56:34 +0100
Message-Id: <1431075394-20821-1-git-send-email-martin.townsend@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: alex.aring@gmail.com
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, Martin Townsend <martin.townsend@xsilon.com>

fakelb_hw_deliver creates a copy of the skb's header which can
potentially return NULL so we now check for this before actually
delivering to the 802.15.4 MAC layer.

Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
---
 drivers/net/ieee802154/fakelb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index dc2bfb6..baa8d36 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -69,7 +69,8 @@ fakelb_hw_deliver(struct fakelb_dev_priv *priv, struct sk_buff *skb)
 	spin_lock(&priv->lock);
 	if (priv->working) {
 		newskb = pskb_copy(skb, GFP_ATOMIC);
-		ieee802154_rx_irqsafe(priv->hw, newskb, 0xcc);
+		if (newskb)
+			ieee802154_rx_irqsafe(priv->hw, newskb, 0xcc);
 	}
 	spin_unlock(&priv->lock);
 }
-- 
1.9.1

