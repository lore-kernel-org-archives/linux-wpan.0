Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47409 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751989AbcHGOdE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Aug 2016 10:33:04 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFCv2 bluetooth-next 10/19] bluetooth: export functions and variables
Date: Sun,  7 Aug 2016 16:30:47 +0200
Message-Id: <20160807143056.3116-11-aar@pengutronix.de>
In-Reply-To: <20160807143056.3116-1-aar@pengutronix.de>
References: <20160807143056.3116-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, Alexander Aring <aar@pengutronix.de>

This function exports some functions which are needed by the 6LoWPAN BTLE
module.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/bluetooth/hci_core.c   | 2 ++
 net/bluetooth/l2cap_core.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 999c83b..4624165 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -955,6 +955,7 @@ struct hci_dev *hci_dev_get(int index)
 	read_unlock(&hci_dev_list_lock);
 	return hdev;
 }
+EXPORT_SYMBOL(hci_dev_get);
 
 /* ---- Inquiry support ---- */
 
@@ -2941,6 +2942,7 @@ void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 		*bdaddr_type = ADDR_LE_DEV_PUBLIC;
 	}
 }
+EXPORT_SYMBOL(hci_copy_identity_address);
 
 /* Alloc HCI device */
 struct hci_dev *hci_alloc_dev(void)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index cce5d21..128d5a4 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -501,6 +501,7 @@ void l2cap_chan_hold(struct l2cap_chan *c)
 
 	kref_get(&c->kref);
 }
+EXPORT_SYMBOL(l2cap_chan_hold);
 
 void l2cap_chan_put(struct l2cap_chan *c)
 {
-- 
2.9.2

