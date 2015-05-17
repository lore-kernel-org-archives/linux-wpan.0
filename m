Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:33804 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbbEQTqB (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 17 May 2015 15:46:01 -0400
Received: by wguv19 with SMTP id v19so104444246wgu.1
        for <linux-wpan@vger.kernel.org>; Sun, 17 May 2015 12:46:00 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 25/34] fakelb: don't deliver when one phy
Date: Sun, 17 May 2015 21:45:01 +0200
Message-Id: <1431891910-32231-26-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
References: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, Alexander Aring <alex.aring@gmail.com>

A real phy don't transmit the transmitted frame back to the phy. This
behaviour will confuse the 6LoWPAN and the upper IPv6 neighbour
discovery cache. We need now at least two virtual phy's to creating a
virtual wpan network.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/fakelb.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index 5c4fbb8..d5fb776 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -80,20 +80,16 @@ fakelb_hw_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 {
 	struct fakelb_phy *current_phy = hw->priv;
 	struct fakelb_priv *fake = current_phy->fake;
+	struct fakelb_phy *phy;
 
 	read_lock_bh(&fake->lock);
-	if (current_phy->list.next == current_phy->list.prev) {
-		/* we are the only one device */
-		fakelb_hw_deliver(current_phy, skb);
-	} else {
-		struct fakelb_phy *phy;
-
-		list_for_each_entry(phy, &current_phy->fake->list, list) {
-			if (current_phy != phy &&
-			    (phy->hw->phy->current_channel ==
-			     current_phy->hw->phy->current_channel))
-				fakelb_hw_deliver(phy, skb);
-		}
+	list_for_each_entry(phy, &current_phy->fake->list, list) {
+		if (current_phy == phy)
+			continue;
+
+		if (phy->hw->phy->current_channel ==
+		    current_phy->hw->phy->current_channel)
+			fakelb_hw_deliver(phy, skb);
 	}
 	read_unlock_bh(&fake->lock);
 
-- 
2.3.7

