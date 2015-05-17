Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:35429 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbbEQTpz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 17 May 2015 15:45:55 -0400
Received: by wgfl8 with SMTP id l8so13364224wgf.2
        for <linux-wpan@vger.kernel.org>; Sun, 17 May 2015 12:45:54 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 20/34] mac802154: tx: allow xmit complete from hard irq
Date: Sun, 17 May 2015 21:44:56 +0200
Message-Id: <1431891910-32231-21-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
References: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, Alexander Aring <alex.aring@gmail.com>

Replace consume_skb with dev_consume_skb_any in ieee802154_xmit_complete
which can be called in hard irq and other contexts.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/util.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mac802154/util.c b/net/mac802154/util.c
index 150bf80..583435f 100644
--- a/net/mac802154/util.c
+++ b/net/mac802154/util.c
@@ -85,11 +85,10 @@ void ieee802154_xmit_complete(struct ieee802154_hw *hw, struct sk_buff *skb,
 			hrtimer_start(&local->ifs_timer,
 				      ktime_set(0, hw->phy->sifs_period * NSEC_PER_USEC),
 				      HRTIMER_MODE_REL);
-
-		consume_skb(skb);
 	} else {
 		ieee802154_wake_queue(hw);
-		consume_skb(skb);
 	}
+
+	dev_consume_skb_any(skb);
 }
 EXPORT_SYMBOL(ieee802154_xmit_complete);
-- 
2.3.7

