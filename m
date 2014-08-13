Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:45845 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbaHMNqy (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 13 Aug 2014 09:46:54 -0400
Received: by mail-la0-f41.google.com with SMTP id s18so9214781lam.14
        for <linux-wpan@vger.kernel.org>; Wed, 13 Aug 2014 06:46:53 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Wed, 13 Aug 2014 15:46:24 +0200
Message-Id: <1407937595-16415-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407937595-16415-1-git-send-email-alex.aring@gmail.com>
References: <1407937595-16415-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 01/12] mac802154: rx: warn if ieee80211_rx call from irq
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch adds a warning if the ieee80211_rx function is called from an
irq context which should never happen.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/rx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index fe16754..7d62170 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -65,6 +65,8 @@ fail:
 
 void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
 {
+	WARN_ON_ONCE(softirq_count() == 0);
+
 	mac802154_subif_rx(hw, skb);
 }
 EXPORT_SYMBOL(ieee802154_rx);
-- 
2.0.3

