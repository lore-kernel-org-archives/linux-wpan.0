Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36918 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbbIRJa7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 18 Sep 2015 05:30:59 -0400
Received: by wicfx3 with SMTP id fx3so23173855wic.0
        for <linux-wpan@vger.kernel.org>; Fri, 18 Sep 2015 02:30:58 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 5/5] mac802154: tx: add warning if MTU exceeds
Date: Fri, 18 Sep 2015 11:30:44 +0200
Message-Id: <1442568644-2158-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1442568644-2158-1-git-send-email-alex.aring@gmail.com>
References: <1442568644-2158-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Sending over AF_PACKET RAW sockets we can sending frames which exceeds
MTU size. To handling it correct we need to change things in AF_PACKET
which knows on RAW sockets an additional FCS is set by hardware or
mac802154 transmit functionality.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/tx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 66d7ecb..5ee596e 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -71,6 +71,17 @@ ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 	struct net_device *dev = skb->dev;
 	int ret;
 
+	/* This check is for AF_PACKET RAW socket only, which doesn't
+	 * know about the FCS which is set here or by hardware. otherwise
+	 * it should not occur in any case!
+	 *
+	 * TODO: This should be handled in AF_PACKET and return -EMSGSIZE.
+	 */
+	if (skb->len > IEEE802154_MTU - IEEE802154_FCS_LEN) {
+		netdev_warn(dev, "Frame len above MTU limit. Dropped.\n");
+		goto err_tx;
+	}
+
 	if (!(local->hw.flags & IEEE802154_HW_TX_OMIT_CKSUM)) {
 		u16 crc = crc_ccitt(0, skb->data, skb->len);
 
-- 
2.5.2

