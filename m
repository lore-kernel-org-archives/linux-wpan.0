Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:32888 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752579AbdDCOtG (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 3 Apr 2017 10:49:06 -0400
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 3/3] Bluetooth: L2CAP: Don't return -EAGAIN if out of credits
Date: Mon,  3 Apr 2017 17:48:57 +0300
Message-Id: <20170403144857.4661-3-luiz.dentz@gmail.com>
In-Reply-To: <20170403144857.4661-1-luiz.dentz@gmail.com>
References: <20170403144857.4661-1-luiz.dentz@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: aar@pengutronix.de, jukka.rissanen@linux.intel.com, linux-wpan@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Just keep queueing them into TX queue since the caller might just have
to do the same and there is no impact in adding another packet to the
TX queue even if there aren't any credits to transmit them.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fc7f321..3a202b0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2458,9 +2458,6 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 		if (len > chan->omtu)
 			return -EMSGSIZE;
 
-		if (!chan->tx_credits)
-			return -EAGAIN;
-
 		__skb_queue_head_init(&seg_queue);
 
 		err = l2cap_segment_le_sdu(chan, &seg_queue, msg, len);
-- 
2.9.3

