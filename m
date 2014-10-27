Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:59410 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbaJ0Lnk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Oct 2014 07:43:40 -0400
Received: by mail-la0-f45.google.com with SMTP id gm9so4156570lab.4
        for <linux-wpan@vger.kernel.org>; Mon, 27 Oct 2014 04:43:39 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 04/16] mac802154: rx: warn if ieee80211_rx call from irq
Date: Mon, 27 Oct 2014 12:42:57 +0100
Message-Id: <1414410189-20092-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414410189-20092-1-git-send-email-alex.aring@gmail.com>
References: <1414410189-20092-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a warning if the ieee80211_rx function is called from an
irq context which should never happen.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/rx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 2851a3f..c4df321 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -61,6 +61,8 @@ fail:
 
 void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
 {
+	WARN_ON_ONCE(softirq_count() == 0);
+
 	mac802154_subif_rx(hw, skb);
 }
 EXPORT_SYMBOL(ieee802154_rx);
-- 
2.1.2

