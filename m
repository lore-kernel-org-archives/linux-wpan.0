Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:43432 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756798AbaJ2UgG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 16:36:06 -0400
Received: by mail-wg0-f49.google.com with SMTP id x13so2757774wgg.22
        for <linux-wpan@vger.kernel.org>; Wed, 29 Oct 2014 13:36:05 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 14/17] mac802154: rx: monitor receive cleanup
Date: Wed, 29 Oct 2014 21:34:41 +0100
Message-Id: <1414614884-20243-15-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
References: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch replace the !netif_running(sdata->dev) instead we doing a
!ieee802154_sdata_running(sdata). Also move this in two separate if
branches to compare with mac80211 code.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/rx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 6ba2769..971a855 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -233,8 +233,10 @@ ieee802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
 	skb->protocol = htons(ETH_P_IEEE802154);
 
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
-		if (sdata->type != IEEE802154_DEV_MONITOR ||
-		    !netif_running(sdata->dev))
+		if (sdata->type != IEEE802154_DEV_MONITOR)
+			continue;
+
+		if (!ieee802154_sdata_running(sdata))
 			continue;
 
 		skb2 = skb_clone(skb, GFP_ATOMIC);
-- 
2.1.2

