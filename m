Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:61655 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666AbaJ0QOV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Oct 2014 12:14:21 -0400
Received: by mail-wg0-f47.google.com with SMTP id a1so2335019wgh.6
        for <linux-wpan@vger.kernel.org>; Mon, 27 Oct 2014 09:14:20 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 11/16] mac802154: rx: move skb_reset_mac_header
Date: Mon, 27 Oct 2014 17:13:38 +0100
Message-Id: <1414426423-24856-12-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414426423-24856-1-git-send-email-alex.aring@gmail.com>
References: <1414426423-24856-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch moves the skb_reset_mac_header call before frame parsing
while wpan rx and before monitor deliver functionality.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/rx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index f7f09b4..c299980 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -138,6 +138,8 @@ static int mac802154_parse_frame_start(struct sk_buff *skb,
 	int hlen;
 	struct ieee802154_mac_cb *cb = mac_cb_init(skb);
 
+	skb_reset_mac_header(skb);
+
 	hlen = ieee802154_hdr_pull(skb, hdr);
 	if (hlen < 0)
 		return -EINVAL;
@@ -227,6 +229,7 @@ mac802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
 	u16 crc = crc_ccitt(0, skb->data, skb->len);
 	u8 *data;
 
+	skb_reset_mac_header(skb);
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
 	skb->pkt_type = PACKET_OTHERHOST;
 	skb->protocol = htons(ETH_P_IEEE802154);
@@ -255,8 +258,6 @@ void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
 
 	WARN_ON_ONCE(softirq_count() == 0);
 
-	skb_reset_mac_header(skb);
-
 	if (!(local->hw.flags & IEEE802154_HW_OMIT_CKSUM)) {
 		u16 crc;
 
-- 
2.1.2

