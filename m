Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:57865 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756619AbaJ2Ufz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 16:35:55 -0400
Received: by mail-wg0-f52.google.com with SMTP id b13so2192069wgh.11
        for <linux-wpan@vger.kernel.org>; Wed, 29 Oct 2014 13:35:54 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 05/17] mac802154: add support for promiscuous mode
Date: Wed, 29 Oct 2014 21:34:32 +0100
Message-Id: <1414614884-20243-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
References: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a new driver operation to bring the transceiver into
promiscuous mode.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/mac802154.h    |  7 +++++++
 net/mac802154/driver-ops.h | 13 +++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 2f523fc..166ef6c5 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -92,6 +92,8 @@ struct ieee802154_hw {
 #define IEEE802154_HW_FRAME_RETRIES	0x00000080
 /* Indicates that transceiver will support hardware address filter setting. */
 #define IEEE802154_HW_AFILT		0x00000100
+/* Indicates that transceiver will support promiscuous mode setting. */
+#define IEEE802154_HW_PROMISCUOUS	0x00000200
 
 /* This groups the most common CSMA support fields into one. */
 #define IEEE802154_HW_CSMA		(IEEE802154_HW_CCA_MODE | \
@@ -173,6 +175,9 @@ struct ieee802154_hw {
  * set_frame_retries
  *	  Sets the retransmission attempt limit. Called with pib_lock held.
  *	  Returns either zero, or negative errno.
+ *
+ * set_promiscuous_mode
+ *	  Enables or disable promiscuous mode.
  */
 struct ieee802154_ops {
 	struct module	*owner;
@@ -197,6 +202,8 @@ struct ieee802154_ops {
 					   u8 min_be, u8 max_be, u8 retries);
 	int		(*set_frame_retries)(struct ieee802154_hw *hw,
 					     s8 retries);
+	int             (*set_promiscuous_mode)(struct ieee802154_hw *hw,
+						const bool on);
 };
 
 /* Basic interface to register ieee802154 hwice */
diff --git a/net/mac802154/driver-ops.h b/net/mac802154/driver-ops.h
index 4b820cf..dfd29ff 100644
--- a/net/mac802154/driver-ops.h
+++ b/net/mac802154/driver-ops.h
@@ -210,4 +210,17 @@ static inline int drv_set_max_frame_retries(struct ieee802154_local *local,
 	return local->ops->set_frame_retries(&local->hw, max_frame_retries);
 }
 
+static inline int drv_set_promiscuous_mode(struct ieee802154_local *local,
+					   const bool on)
+{
+	might_sleep();
+
+	if (!local->ops->set_promiscuous_mode) {
+		WARN_ON(1);
+		return -EOPNOTSUPP;
+	}
+
+	return local->ops->set_promiscuous_mode(&local->hw, on);
+}
+
 #endif /* __MAC802154_DRVIER_OPS */
-- 
2.1.2

