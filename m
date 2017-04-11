Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33021 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753227AbdDKTVJ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Apr 2017 15:21:09 -0400
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH 2/6] Bluetooth: 6lowpan: Don't drop packets when run out of credits
Date: Tue, 11 Apr 2017 22:20:59 +0300
Message-Id: <20170411192103.3209-2-luiz.dentz@gmail.com>
In-Reply-To: <20170411192103.3209-1-luiz.dentz@gmail.com>
References: <20170411192103.3209-1-luiz.dentz@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: patrik.flykt@linux.intel.com, aar@pengutronix.de, jukka.rissanen@linux.intel.com, linux-wpan@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Since l2cap_chan_send will now queue the packets there is no point in
checking the credits anymore.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/6lowpan.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 5b91e85..22bd936 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -478,15 +478,8 @@ static int send_pkt(struct l2cap_chan *chan, struct sk_buff *skb,
 		return 0;
 	}
 
-	if (!err)
-		err = (!chan->tx_credits ? -EAGAIN : 0);
-
-	if (err < 0) {
-		if (err == -EAGAIN)
-			netdev->stats.tx_dropped++;
-		else
-			netdev->stats.tx_errors++;
-	}
+	if (err < 0)
+		netdev->stats.tx_errors++;
 
 	return err;
 }
-- 
2.9.3

