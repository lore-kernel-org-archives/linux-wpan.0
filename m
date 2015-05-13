Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36447 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbbEMLt7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 13 May 2015 07:49:59 -0400
Received: by wizk4 with SMTP id k4so194907563wiz.1
        for <linux-wpan@vger.kernel.org>; Wed, 13 May 2015 04:49:58 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] mac802154: tx: allow xmit complete from hard irq
Date: Wed, 13 May 2015 13:49:45 +0200
Message-Id: <1431517785-29105-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Replace consume_skb with dev_consume_skb_any in ieee802154_xmit_complete
which can be called in hard irq and other contexts.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/util.c b/net/mac802154/util.c
index 150bf80..315601e 100644
--- a/net/mac802154/util.c
+++ b/net/mac802154/util.c
@@ -86,10 +86,10 @@ void ieee802154_xmit_complete(struct ieee802154_hw *hw, struct sk_buff *skb,
 				      ktime_set(0, hw->phy->sifs_period * NSEC_PER_USEC),
 				      HRTIMER_MODE_REL);
 
-		consume_skb(skb);
+		dev_consume_skb_any(skb);
 	} else {
 		ieee802154_wake_queue(hw);
-		consume_skb(skb);
+		dev_consume_skb_any(skb);
 	}
 }
 EXPORT_SYMBOL(ieee802154_xmit_complete);
-- 
2.3.7

