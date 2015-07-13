Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail.nordicsemi.no ([194.19.86.146]:38076 "EHLO
	ironport02.nordicsemi.no" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751656AbbGMLui (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 13 Jul 2015 07:50:38 -0400
From: Lukasz Duda <lukasz.duda@nordicsemi.no>
Subject: [RFC v2 4/4] Bluetooth: 6lowpan: Enable stateful compression in bluetooth_6lowpan
Date: Mon, 13 Jul 2015 13:50:33 +0200
Message-ID: <1436788233-13960-5-git-send-email-lukasz.duda@nordicsemi.no>
In-Reply-To: <1436788233-13960-1-git-send-email-lukasz.duda@nordicsemi.no>
References: <1436788233-13960-1-git-send-email-lukasz.duda@nordicsemi.no>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: alex.aring@gmail.com
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>

Allocating context table for stateful compression when interface is set
up. Removing context table when interface is being unregistered.

Signed-off-by: Lukasz Duda <lukasz.duda@nordicsemi.no>
Signed-off-by: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
---
 net/bluetooth/6lowpan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 2fb7b30..60c7e80 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -871,6 +871,9 @@ static int setup_netdev(struct l2cap_chan *chan, struct lowpan_dev **dev)
 	       &chan->src, chan->src_type);
 	set_bit(__LINK_STATE_PRESENT, &netdev->state);
 
+	/* Allocate context table for stateful compression. */
+	lowpan_context_table_alloc(netdev);
+
 	*dev = netdev_priv(netdev);
 	(*dev)->netdev = netdev;
 	(*dev)->hdev = chan->conn->hcon->hdev;
@@ -1415,6 +1418,7 @@ static int device_event(struct notifier_block *unused,
 			if (entry->netdev == netdev) {
 				BT_DBG("Unregistered netdev %s %p",
 				       netdev->name, netdev);
+				lowpan_context_table_free(netdev);
 				list_del(&entry->list);
 				break;
 			}
-- 
2.1.4

