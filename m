Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37545 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbbG2MYn (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Jul 2015 08:24:43 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 1/2] bluetooth: 6lowpan: change netdev_priv to lowpan_dev
Date: Wed, 29 Jul 2015 14:24:33 +0200
Message-Id: <1438172674-31028-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1438172674-31028-1-git-send-email-alex.aring@gmail.com>
References: <1438172674-31028-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, lukasz.duda@nordicsemi.no, Alexander Aring <alex.aring@gmail.com>

The usually way to get the btle lowpan private data is to use the
introduced lowpan_dev inline function. This patch will cleanup by using
lowpan_dev consequently.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/bluetooth/6lowpan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 2fb7b30..93c6ba0 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -871,7 +871,7 @@ static int setup_netdev(struct l2cap_chan *chan, struct lowpan_dev **dev)
 	       &chan->src, chan->src_type);
 	set_bit(__LINK_STATE_PRESENT, &netdev->state);
 
-	*dev = netdev_priv(netdev);
+	*dev = lowpan_dev(netdev);
 	(*dev)->netdev = netdev;
 	(*dev)->hdev = chan->conn->hcon->hdev;
 	INIT_LIST_HEAD(&(*dev)->peers);
-- 
2.5.0

