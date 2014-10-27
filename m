Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:40267 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbaJ0Lnp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Oct 2014 07:43:45 -0400
Received: by mail-la0-f46.google.com with SMTP id gi9so5660812lab.19
        for <linux-wpan@vger.kernel.org>; Mon, 27 Oct 2014 04:43:44 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 09/16] mac802154: rx: add CHECKSUM_UNNECESSARY
Date: Mon, 27 Oct 2014 12:43:02 +0100
Message-Id: <1414410189-20092-10-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414410189-20092-1-git-send-email-alex.aring@gmail.com>
References: <1414410189-20092-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds CHECKSUM_UNNECESSARY to skb->ip_summed before delivery.
There exist no transceiver with IP checksum functionality.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/rx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index c4066b5..14eecac 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -31,6 +31,7 @@
 
 static int mac802154_process_data(struct net_device *dev, struct sk_buff *skb)
 {
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
 	skb->protocol = htons(ETH_P_IEEE802154);
 
 	return netif_receive_skb(skb);
@@ -226,6 +227,7 @@ mac802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
 	u16 crc = crc_ccitt(0, skb->data, skb->len);
 	u8 *data;
 
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
 	skb->protocol = htons(ETH_P_IEEE802154);
 
 	rcu_read_lock();
-- 
2.1.2

