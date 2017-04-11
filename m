Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35924 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753227AbdDKTVL (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Apr 2017 15:21:11 -0400
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 4/6] Bluetooth: L2CAP: Add l2cap_le_flowctl_send
Date: Tue, 11 Apr 2017 22:21:01 +0300
Message-Id: <20170411192103.3209-4-luiz.dentz@gmail.com>
In-Reply-To: <20170411192103.3209-1-luiz.dentz@gmail.com>
References: <20170411192103.3209-1-luiz.dentz@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: patrik.flykt@linux.intel.com, aar@pengutronix.de, jukka.rissanen@linux.intel.com, linux-wpan@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Consolidate code sending data to LE CoC channels and adds proper
accounting of packets sent, the remaining credits and how many packets
are queued.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 3a202b0..f88ac995 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2425,6 +2425,22 @@ static int l2cap_segment_le_sdu(struct l2cap_chan *chan,
 	return 0;
 }
 
+static void l2cap_le_flowctl_send(struct l2cap_chan *chan)
+{
+	int sent = 0;
+
+	BT_DBG("chan %p", chan);
+
+	while (chan->tx_credits && !skb_queue_empty(&chan->tx_q)) {
+		l2cap_do_send(chan, skb_dequeue(&chan->tx_q));
+		chan->tx_credits--;
+		sent++;
+	}
+
+	BT_DBG("Sent %d credits %u queued %u", sent, chan->tx_credits,
+	       skb_queue_len(&chan->tx_q));
+}
+
 int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 {
 	struct sk_buff *skb;
@@ -2472,10 +2488,7 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 
 		skb_queue_splice_tail_init(&seg_queue, &chan->tx_q);
 
-		while (chan->tx_credits && !skb_queue_empty(&chan->tx_q)) {
-			l2cap_do_send(chan, skb_dequeue(&chan->tx_q));
-			chan->tx_credits--;
-		}
+		l2cap_le_flowctl_send(chan);
 
 		if (!chan->tx_credits)
 			chan->ops->suspend(chan);
@@ -5567,10 +5580,8 @@ static inline int l2cap_le_credits(struct l2cap_conn *conn,
 
 	chan->tx_credits += credits;
 
-	while (chan->tx_credits && !skb_queue_empty(&chan->tx_q)) {
-		l2cap_do_send(chan, skb_dequeue(&chan->tx_q));
-		chan->tx_credits--;
-	}
+	/* Resume sending */
+	l2cap_le_flowctl_send(chan);
 
 	if (chan->tx_credits)
 		chan->ops->resume(chan);
-- 
2.9.3

