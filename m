Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:46183 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652AbaJ0QOR (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Oct 2014 12:14:17 -0400
Received: by mail-wi0-f172.google.com with SMTP id d1so3312056wiv.17
        for <linux-wpan@vger.kernel.org>; Mon, 27 Oct 2014 09:14:16 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 08/16] mac802154: rx: move skb->protocol setting
Date: Mon, 27 Oct 2014 17:13:35 +0100
Message-Id: <1414426423-24856-9-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414426423-24856-1-git-send-email-alex.aring@gmail.com>
References: <1414426423-24856-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch moves the skb->protocol setting to the position when it's
needed. It's only needed when frame parsing was successful.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/rx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 246a60e..c4066b5 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -31,6 +31,8 @@
 
 static int mac802154_process_data(struct net_device *dev, struct sk_buff *skb)
 {
+	skb->protocol = htons(ETH_P_IEEE802154);
+
 	return netif_receive_skb(skb);
 }
 
@@ -224,6 +226,8 @@ mac802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
 	u16 crc = crc_ccitt(0, skb->data, skb->len);
 	u8 *data;
 
+	skb->protocol = htons(ETH_P_IEEE802154);
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
 		if (sdata->type != IEEE802154_DEV_MONITOR ||
@@ -248,7 +252,6 @@ void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
 
 	WARN_ON_ONCE(softirq_count() == 0);
 
-	skb->protocol = htons(ETH_P_IEEE802154);
 	skb_reset_mac_header(skb);
 
 	if (!(local->hw.flags & IEEE802154_HW_OMIT_CKSUM)) {
-- 
2.1.2

