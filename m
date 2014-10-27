Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:62770 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbaJ0QON (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Oct 2014 12:14:13 -0400
Received: by mail-wi0-f176.google.com with SMTP id n3so6840941wiv.3
        for <linux-wpan@vger.kernel.org>; Mon, 27 Oct 2014 09:14:12 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 04/16] mac802154: rx: document ieee802154_rx() context requirement
Date: Mon, 27 Oct 2014 17:13:31 +0100
Message-Id: <1414426423-24856-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414426423-24856-1-git-send-email-alex.aring@gmail.com>
References: <1414426423-24856-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch is similar like d20ef63d32461332958661df73e21c0ca42601b0
("mac80211: document ieee80211_rx() context requirement"). The
netif_receive_skb call requires with softirqs disabled. This patch
adds a warning if softirqs are pending while calling ieee802154_rx.

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

