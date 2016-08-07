Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60785 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751821AbcHGOdF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Aug 2016 10:33:05 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFCv2 bluetooth-next 08/19] bluetooth: add hci dev notifier
Date: Sun,  7 Aug 2016 16:30:45 +0200
Message-Id: <20160807143056.3116-9-aar@pengutronix.de>
In-Reply-To: <20160807143056.3116-1-aar@pengutronix.de>
References: <20160807143056.3116-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, Alexander Aring <aar@pengutronix.de>

I need to react at least somehow on a hci dev unregister event to clean
all 6LoWPAN interfaces on it. This patch adds a notifier for non
socket stuff.

I also thought about to react somehow on "struct device" unregister but
I didn't found any functionality for that.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/bluetooth/hci_core.h |  4 ++++
 net/bluetooth/hci_core.c         | 22 ++++++++++++++++++++++
 net/bluetooth/hci_sock.c         |  2 ++
 3 files changed, 28 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b8d43bd..f808aa0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -907,6 +907,10 @@ void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active);
 
 void hci_le_conn_failed(struct hci_conn *conn, u8 status);
 
+int register_hci_dev_notifier(struct notifier_block *nb);
+void unregister_hci_dev_notifier(struct notifier_block *nb);
+int call_hci_dev_notifiers(unsigned long val, struct hci_dev *hdev);
+
 /*
  * hci_conn_get() and hci_conn_put() are used to control the life-time of an
  * "hci_conn" object. They do not guarantee that the hci_conn object is running,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ddf8432..999c83b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -57,6 +57,28 @@ DEFINE_MUTEX(hci_cb_list_lock);
 /* HCI ID Numbering */
 static DEFINE_IDA(hci_index_ida);
 
+/* HCI device notifier list */
+static RAW_NOTIFIER_HEAD(hci_dev_chain);
+
+/* ---- HCI notifiers functions ---- */
+
+int register_hci_dev_notifier(struct notifier_block *nb)
+{
+	return raw_notifier_chain_register(&hci_dev_chain, nb);
+}
+EXPORT_SYMBOL(register_hci_dev_notifier);
+
+void unregister_hci_dev_notifier(struct notifier_block *nb)
+{
+	raw_notifier_chain_unregister(&hci_dev_chain, nb);
+}
+EXPORT_SYMBOL(unregister_hci_dev_notifier);
+
+int call_hci_dev_notifiers(unsigned long val, struct hci_dev *hdev)
+{
+	return raw_notifier_call_chain(&hci_dev_chain, val, hdev);
+}
+
 /* ---- HCI debugfs entries ---- */
 
 static ssize_t dut_mode_read(struct file *file, char __user *user_buf,
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 6ef8a01..290eb1e 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -529,6 +529,8 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event)
 		}
 		read_unlock(&hci_sk_list.lock);
 	}
+
+	call_hci_dev_notifiers(event, hdev);
 }
 
 static struct hci_mgmt_chan *__hci_mgmt_chan_find(unsigned short channel)
-- 
2.9.2

