Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:54970 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbaHKLac (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 11 Aug 2014 07:30:32 -0400
From: Alexander Aring <alex.aring@gmail.com>
Date: Mon, 11 Aug 2014 13:25:07 +0200
Message-Id: <1407756310-26592-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1407756310-26592-1-git-send-email-alex.aring@gmail.com>
References: <1407756310-26592-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH 1/4] mac802154: cleanup in rx path
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Varka Bhadram <varkab@cdac.in>, Alexander Aring <alex.aring@gmail.com>

From: Varka Bhadram <varkab@cdac.in>

This patch replace the sizeof(struct rx_work) with sizeof(*work)
and directly passing the skb in mac802154_subif_rx()

Signed-off-by: Varka Bhadram <varkab@cdac.in>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/rx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 7f820a1..a14cf9e 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -86,9 +86,8 @@ fail:
 static void mac802154_rx_worker(struct work_struct *work)
 {
 	struct rx_work *rw = container_of(work, struct rx_work, work);
-	struct sk_buff *skb = rw->skb;
 
-	mac802154_subif_rx(rw->dev, skb, rw->lqi);
+	mac802154_subif_rx(rw->dev, rw->skb, rw->lqi);
 	kfree(rw);
 }
 
@@ -101,7 +100,7 @@ ieee802154_rx_irqsafe(struct ieee802154_dev *dev, struct sk_buff *skb, u8 lqi)
 	if (!skb)
 		return;
 
-	work = kzalloc(sizeof(struct rx_work), GFP_ATOMIC);
+	work = kzalloc(sizeof(*work), GFP_ATOMIC);
 	if (!work)
 		return;
 
-- 
2.0.3

