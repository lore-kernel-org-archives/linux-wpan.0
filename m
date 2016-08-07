Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:35644 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752008AbcHGOdD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Aug 2016 10:33:03 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFCv2 bluetooth-next 07/19] bluetooth: introduce l2cap_hdev_chan_connect
Date: Sun,  7 Aug 2016 16:30:44 +0200
Message-Id: <20160807143056.3116-8-aar@pengutronix.de>
In-Reply-To: <20160807143056.3116-1-aar@pengutronix.de>
References: <20160807143056.3116-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, Alexander Aring <aar@pengutronix.de>

A BTLE 6LoWPAN should be binded to one hci device and is not changeable
afterwards. This patch adds l2cap_hdev_chan_connect function without calling
hci_get_route which decides on bluetooth side which may be the best hci
device which should be use. The hci dev will be available by parameter.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/bluetooth/l2cap.h |  3 +++
 net/bluetooth/l2cap_core.c    | 28 +++++++++++++++++++++-------
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 5ee3c68..8a4d26e 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -928,6 +928,9 @@ struct l2cap_chan *l2cap_chan_create(void);
 void l2cap_chan_close(struct l2cap_chan *chan, int reason);
 int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		       bdaddr_t *dst, u8 dst_type);
+int l2cap_hdev_chan_connect(struct hci_dev *hdev,
+			    struct l2cap_chan *chan, __le16 psm, u16 cid,
+			    bdaddr_t *dst, u8 dst_type);
 int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
 int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 54ceb1f..2ab8814 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7041,21 +7041,17 @@ static bool is_valid_psm(u16 psm, u8 dst_type) {
 	return ((psm & 0x0101) == 0x0001);
 }
 
-int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
-		       bdaddr_t *dst, u8 dst_type)
+int l2cap_hdev_chan_connect(struct hci_dev *hdev,
+			    struct l2cap_chan *chan, __le16 psm, u16 cid,
+			    bdaddr_t *dst, u8 dst_type)
 {
 	struct l2cap_conn *conn;
 	struct hci_conn *hcon;
-	struct hci_dev *hdev;
 	int err;
 
 	BT_DBG("%pMR -> %pMR (type %u) psm 0x%2.2x", &chan->src, dst,
 	       dst_type, __le16_to_cpu(psm));
 
-	hdev = hci_get_route(dst, &chan->src);
-	if (!hdev)
-		return -EHOSTUNREACH;
-
 	hci_dev_lock(hdev);
 
 	if (!is_valid_psm(__le16_to_cpu(psm), dst_type) && !cid &&
@@ -7199,7 +7195,25 @@ chan_unlock:
 	mutex_unlock(&conn->chan_lock);
 done:
 	hci_dev_unlock(hdev);
+	return err;
+}
+EXPORT_SYMBOL_GPL(l2cap_hdev_chan_connect);
+
+int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
+		       bdaddr_t *dst, u8 dst_type)
+{
+	struct hci_dev *hdev;
+	int err = -EHOSTUNREACH;
+
+	hdev = hci_get_route(dst, &chan->src);
+	if (!hdev)
+		goto done;
+
+	err = l2cap_hdev_chan_connect(hdev, chan, psm, cid, dst, dst_type);
+
 	hci_dev_put(hdev);
+
+done:
 	return err;
 }
 EXPORT_SYMBOL_GPL(l2cap_chan_connect);
-- 
2.9.2

