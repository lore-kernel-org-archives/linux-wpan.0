Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:56932 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752529AbcGKTvT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 11 Jul 2016 15:51:19 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC bluetooth-next 11/20] bluetooth: export functions and variables
Date: Mon, 11 Jul 2016 21:50:35 +0200
Message-Id: <20160711195044.25343-12-aar@pengutronix.de>
In-Reply-To: <20160711195044.25343-1-aar@pengutronix.de>
References: <20160711195044.25343-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, luiz.dentz@gmail.com, kaspar@schleiser.de, jukka.rissanen@linux.intel.com, linux-bluetooth@vger.kernel.org, Patrik.Flykt@linux.intel.com, Alexander Aring <aar@pengutronix.de>

This function exports some functions which are needed by the 6LoWPAN BTLE
module.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/bluetooth/hci_core.c   | 4 ++++
 net/bluetooth/l2cap_core.c | 1 +
 2 files changed, 5 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a75e9e7..4935b94 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -48,7 +48,9 @@ static void hci_tx_work(struct work_struct *work);
 
 /* HCI device list */
 LIST_HEAD(hci_dev_list);
+EXPORT_SYMBOL(hci_dev_list);
 DEFINE_RWLOCK(hci_dev_list_lock);
+EXPORT_SYMBOL(hci_dev_list_lock);
 
 /* HCI callback list */
 LIST_HEAD(hci_cb_list);
@@ -955,6 +957,7 @@ struct hci_dev *hci_dev_get(int index)
 	read_unlock(&hci_dev_list_lock);
 	return hdev;
 }
+EXPORT_SYMBOL(hci_dev_get);
 
 /* ---- Inquiry support ---- */
 
@@ -2941,6 +2944,7 @@ void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 		*bdaddr_type = ADDR_LE_DEV_PUBLIC;
 	}
 }
+EXPORT_SYMBOL(hci_copy_identity_address);
 
 /* Alloc HCI device */
 struct hci_dev *hci_alloc_dev(void)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2ab8814..1bf534d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -484,6 +484,7 @@ void l2cap_chan_hold(struct l2cap_chan *c)
 
 	kref_get(&c->kref);
 }
+EXPORT_SYMBOL(l2cap_chan_hold);
 
 void l2cap_chan_put(struct l2cap_chan *c)
 {
-- 
2.9.0

