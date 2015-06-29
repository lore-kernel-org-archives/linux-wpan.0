Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:36213 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678AbbF2Jbp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Jun 2015 05:31:45 -0400
Received: by pdcu2 with SMTP id u2so113872358pdc.3
        for <linux-wpan@vger.kernel.org>; Mon, 29 Jun 2015 02:31:44 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [RFC bluetooth-next] mac802154: do not export ieee802154_rx()
Date: Mon, 29 Jun 2015 15:01:07 +0530
Message-Id: <1435570267-12971-1-git-send-email-varkabhadram@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com

Right now there are no other users for ieee802154_rx()
in kernel. So lets remove EXPORT_SYMBOL() for this.

Signed-off-by: Varka Bhadram <varkabhadram@gmail.com>
---
 net/mac802154/rx.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 5a258c1..7791c9b 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -290,7 +290,6 @@ void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
 drop:
 	kfree_skb(skb);
 }
-EXPORT_SYMBOL(ieee802154_rx);
 
 void
 ieee802154_rx_irqsafe(struct ieee802154_hw *hw, struct sk_buff *skb, u8 lqi)
-- 
1.7.9.5

