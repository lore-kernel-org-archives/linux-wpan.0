Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38359 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932263AbbHKTog (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Aug 2015 15:44:36 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/4] Bluetooth: 6lowpan: change netdev_priv to lowpan_dev
Date: Tue, 11 Aug 2015 21:44:07 +0200
Message-Id: <1439322250-32039-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1439322250-32039-1-git-send-email-alex.aring@gmail.com>
References: <1439322250-32039-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, lukasz.duda@nordicsemi.no, jukka.rissanen@linux.intel.com, Alexander Aring <alex.aring@gmail.com>

The usually way to get the btle lowpan private data is to use the
introduced lowpan_dev inline function. This patch will cleanup by using
lowpan_dev consequently.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/bluetooth/6lowpan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 0ffe2e2..24ed5b0 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -859,7 +859,7 @@ static int setup_netdev(struct l2cap_chan *chan, struct lowpan_dev **dev)
 	SET_NETDEV_DEV(netdev, &chan->conn->hcon->hdev->dev);
 	SET_NETDEV_DEVTYPE(netdev, &bt_type);
 
-	*dev = netdev_priv(netdev);
+	*dev = lowpan_dev(netdev);
 	(*dev)->netdev = netdev;
 	(*dev)->hdev = chan->conn->hcon->hdev;
 	INIT_LIST_HEAD(&(*dev)->peers);
-- 
2.5.0

