Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:35408 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbbEQTpx (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 17 May 2015 15:45:53 -0400
Received: by wgfl8 with SMTP id l8so13363701wgf.2
        for <linux-wpan@vger.kernel.org>; Sun, 17 May 2015 12:45:52 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 18/34] mac802154: fakelb: Fix potential NULL pointer dereference.
Date: Sun, 17 May 2015 21:44:54 +0200
Message-Id: <1431891910-32231-19-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
References: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, Martin Townsend <mtownsend1973@gmail.com>, Martin Townsend <martin.townsend@xsilon.com>, Alexander Aring <alex.aring@gmail.com>

From: Martin Townsend <mtownsend1973@gmail.com>

fakelb_hw_deliver creates a copy of the skb's header which can
potentially return NULL so we now check for this before actually
delivering to the 802.15.4 MAC layer.

Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/fakelb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index 91bbf03..230f7da 100644
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
2.3.7

