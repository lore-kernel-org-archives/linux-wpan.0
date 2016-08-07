Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59011 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751713AbcHGOdE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Aug 2016 10:33:04 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFCv2 bluetooth-next 09/19] bluetooth: introduce l2cap chan priv data
Date: Sun,  7 Aug 2016 16:30:46 +0200
Message-Id: <20160807143056.3116-10-aar@pengutronix.de>
In-Reply-To: <20160807143056.3116-1-aar@pengutronix.de>
References: <20160807143056.3116-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, Alexander Aring <aar@pengutronix.de>

This patch adds possibility to add a private data room to the l2cap_chan
structure. This private dataroom will be freed when the l2cap_chan
reference count reach zero. This avoids dealing with separate allocated
data pointer for l2cap_chan "data" attribute.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 include/net/bluetooth/l2cap.h |  4 ++++
 net/bluetooth/l2cap_core.c    | 21 +++++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 8a4d26e..925c78a 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -598,6 +598,9 @@ struct l2cap_chan {
 	void			*data;
 	const struct l2cap_ops	*ops;
 	struct mutex		lock;
+
+	/* must be last */
+	u8 priv[0] __aligned(sizeof(void *));
 };
 
 struct l2cap_ops {
@@ -925,6 +928,7 @@ int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm);
 int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid);
 
 struct l2cap_chan *l2cap_chan_create(void);
+struct l2cap_chan *l2cap_chan_create_priv(size_t priv_size);
 void l2cap_chan_close(struct l2cap_chan *chan, int reason);
 int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		       bdaddr_t *dst, u8 dst_type);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2ab8814..cce5d21 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -433,11 +433,11 @@ static void l2cap_chan_timeout(struct work_struct *work)
 	l2cap_chan_put(chan);
 }
 
-struct l2cap_chan *l2cap_chan_create(void)
+static struct l2cap_chan *__l2cap_chan_create(size_t priv_size)
 {
 	struct l2cap_chan *chan;
 
-	chan = kzalloc(sizeof(*chan), GFP_ATOMIC);
+	chan = kzalloc(sizeof(*chan) + priv_size, GFP_ATOMIC);
 	if (!chan)
 		return NULL;
 
@@ -463,8 +463,25 @@ struct l2cap_chan *l2cap_chan_create(void)
 
 	return chan;
 }
+
+struct l2cap_chan *l2cap_chan_create(void)
+{
+	return __l2cap_chan_create(0);
+}
 EXPORT_SYMBOL_GPL(l2cap_chan_create);
 
+struct l2cap_chan *l2cap_chan_create_priv(size_t priv_size)
+{
+	struct l2cap_chan *chan = __l2cap_chan_create(priv_size);
+
+	/* let's point data pointer to private space */
+	if (chan)
+		chan->data = chan->priv;
+
+	return chan;
+}
+EXPORT_SYMBOL_GPL(l2cap_chan_create_priv);
+
 static void l2cap_chan_destroy(struct kref *kref)
 {
 	struct l2cap_chan *chan = container_of(kref, struct l2cap_chan, kref);
-- 
2.9.2

