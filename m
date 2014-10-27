Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:50033 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635AbaJ0QOJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Oct 2014 12:14:09 -0400
Received: by mail-wi0-f175.google.com with SMTP id h11so4852021wiw.8
        for <linux-wpan@vger.kernel.org>; Mon, 27 Oct 2014 09:14:08 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 01/16] mac802154: tx: use put_unaligned_le16 for copy crc
Date: Mon, 27 Oct 2014 17:13:28 +0100
Message-Id: <1414426423-24856-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414426423-24856-1-git-send-email-alex.aring@gmail.com>
References: <1414426423-24856-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch replaces the memcpy with a put_unaligned_le16. The placement
of crc inside of PSDU can also be unaligned. With memcpy this can fail
on some architectures.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reported-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/mac802154/tx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index fe2e17e..31e51e4 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -20,6 +20,7 @@
 #include <linux/netdevice.h>
 #include <linux/if_arp.h>
 #include <linux/crc-ccitt.h>
+#include <asm/unaligned.h>
 
 #include <net/rtnetlink.h>
 #include <net/ieee802154_netdev.h>
@@ -84,9 +85,9 @@ ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 	mac802154_monitors_rx(local, skb);
 
 	if (!(local->hw.flags & IEEE802154_HW_OMIT_CKSUM)) {
-		__le16 crc = cpu_to_le16(crc_ccitt(0, skb->data, skb->len));
+		u16 crc = crc_ccitt(0, skb->data, skb->len);
 
-		memcpy(skb_put(skb, 2), &crc, 2);
+		put_unaligned_le16(crc, skb_put(skb, 2));
 	}
 
 	if (skb_cow_head(skb, local->hw.extra_tx_headroom))
-- 
2.1.2

