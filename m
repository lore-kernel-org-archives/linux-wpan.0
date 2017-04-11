Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35489 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753353AbdDKTVJ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Apr 2017 15:21:09 -0400
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 3/6] Bluetooth: 6lowpan: Use netif APIs to flow control
Date: Tue, 11 Apr 2017 22:21:00 +0300
Message-Id: <20170411192103.3209-3-luiz.dentz@gmail.com>
In-Reply-To: <20170411192103.3209-1-luiz.dentz@gmail.com>
References: <20170411192103.3209-1-luiz.dentz@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: patrik.flykt@linux.intel.com, aar@pengutronix.de, jukka.rissanen@linux.intel.com, linux-wpan@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Rely on netif_wake_queue and netif_stop_queue to flow control when
transmit resources are unavailable.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/6lowpan.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 22bd936..dc7fda3 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -867,12 +867,28 @@ static struct sk_buff *chan_alloc_skb_cb(struct l2cap_chan *chan,
 
 static void chan_suspend_cb(struct l2cap_chan *chan)
 {
+	struct lowpan_btle_dev *dev;
+
 	BT_DBG("chan %p suspend", chan);
+
+	dev = lookup_dev(chan->conn);
+	if (!dev || !dev->netdev)
+		return;
+
+	netif_stop_queue(dev->netdev);
 }
 
 static void chan_resume_cb(struct l2cap_chan *chan)
 {
+	struct lowpan_btle_dev *dev;
+
 	BT_DBG("chan %p resume", chan);
+
+	dev = lookup_dev(chan->conn);
+	if (!dev || !dev->netdev)
+		return;
+
+	netif_wake_queue(dev->netdev);
 }
 
 static long chan_get_sndtimeo_cb(struct l2cap_chan *chan)
-- 
2.9.3

