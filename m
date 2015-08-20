Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35796 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246AbbHTQvi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 20 Aug 2015 12:51:38 -0400
Received: by wicne3 with SMTP id ne3so151196229wic.0
        for <linux-wpan@vger.kernel.org>; Thu, 20 Aug 2015 09:51:37 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFCv2 bluetooth-next 12/16] ieee802154: 6lowpan: add handler for all dispatch values
Date: Thu, 20 Aug 2015 18:47:41 +0200
Message-Id: <1440089265-23366-13-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1440089265-23366-1-git-send-email-alex.aring@gmail.com>
References: <1440089265-23366-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds dummy handlers for all known IEEE 802.15.4 dispatch
values which prints a warning that we don't support these dispatches
right now. Also we add a warning to the RX_CONTINUE case inside of
lowpan_rx_handlers_result which should now never happend.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/rx.c | 90 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index c13763e..d309d91 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -19,6 +19,11 @@
 #define LOWPAN_DISPATCH_FRAG_MASK	0xf8
 
 #define LOWPAN_DISPATCH_NALP		0x00
+#define LOWPAN_DISPATCH_ESC		0x7f
+#define LOWPAN_DISPATCH_HC1		0x42
+#define LOWPAN_DISPATCH_DFF		0x43
+#define LOWPAN_DISPATCH_BC0		0x50
+#define LOWPAN_DISPATCH_MESH		0x80
 
 static int lowpan_give_skb_to_device(struct sk_buff *skb)
 {
@@ -144,6 +149,86 @@ lowpan_rx_result lowpan_rx_h_ipv6(struct sk_buff *skb)
 	return RX_QUEUED;
 }
 
+static inline bool lowpan_is_esc(u8 dispatch)
+{
+	return dispatch == LOWPAN_DISPATCH_ESC;
+}
+
+static lowpan_rx_result lowpan_rx_h_esc(struct sk_buff *skb)
+{
+	if (!lowpan_is_esc(*skb_network_header(skb)))
+		return RX_CONTINUE;
+
+	net_warn_ratelimited("%s: %s\n", skb->dev->name,
+			     "6LoWPAN ESC not supported\n");
+
+	return RX_DROP_UNUSABLE;
+}
+
+static inline bool lowpan_is_hc1(u8 dispatch)
+{
+	return dispatch == LOWPAN_DISPATCH_HC1;
+}
+
+static lowpan_rx_result lowpan_rx_h_hc1(struct sk_buff *skb)
+{
+	if (!lowpan_is_hc1(*skb_network_header(skb)))
+		return RX_CONTINUE;
+
+	net_warn_ratelimited("%s: %s\n", skb->dev->name,
+			     "6LoWPAN HC1 not supported\n");
+
+	return RX_DROP_UNUSABLE;
+}
+
+static inline bool lowpan_is_dff(u8 dispatch)
+{
+	return dispatch == LOWPAN_DISPATCH_DFF;
+}
+
+static lowpan_rx_result lowpan_rx_h_dff(struct sk_buff *skb)
+{
+	if (!lowpan_is_dff(*skb_network_header(skb)))
+		return RX_CONTINUE;
+
+	net_warn_ratelimited("%s: %s\n", skb->dev->name,
+			     "6LoWPAN DFF not supported\n");
+
+	return RX_DROP_UNUSABLE;
+}
+
+static inline bool lowpan_is_bc0(u8 dispatch)
+{
+	return dispatch == LOWPAN_DISPATCH_BC0;
+}
+
+static lowpan_rx_result lowpan_rx_h_bc0(struct sk_buff *skb)
+{
+	if (!lowpan_is_bc0(*skb_network_header(skb)))
+		return RX_CONTINUE;
+
+	net_warn_ratelimited("%s: %s\n", skb->dev->name,
+			     "6LoWPAN BC0 not supported\n");
+
+	return RX_DROP_UNUSABLE;
+}
+
+static inline bool lowpan_is_mesh(u8 dispatch)
+{
+	return (dispatch & LOWPAN_DISPATCH_FIRST) == LOWPAN_DISPATCH_MESH;
+}
+
+static lowpan_rx_result lowpan_rx_h_mesh(struct sk_buff *skb)
+{
+	if (!lowpan_is_mesh(*skb_network_header(skb)))
+		return RX_CONTINUE;
+
+	net_warn_ratelimited("%s: %s\n", skb->dev->name,
+			     "6LoWPAN MESH not supported\n");
+
+	return RX_DROP_UNUSABLE;
+}
+
 static int lowpan_invoke_rx_handlers(struct sk_buff *skb)
 {
 	lowpan_rx_result res;
@@ -159,6 +244,11 @@ static int lowpan_invoke_rx_handlers(struct sk_buff *skb)
 	CALL_RXH(lowpan_rx_h_iphc);
 	CALL_RXH(lowpan_rx_h_frag);
 	CALL_RXH(lowpan_rx_h_ipv6);
+	CALL_RXH(lowpan_rx_h_esc);
+	CALL_RXH(lowpan_rx_h_hc1);
+	CALL_RXH(lowpan_rx_h_dff);
+	CALL_RXH(lowpan_rx_h_bc0);
+	CALL_RXH(lowpan_rx_h_mesh);
 
 rxh_next:
 	return lowpan_rx_handlers_result(skb, res);
-- 
2.5.0

