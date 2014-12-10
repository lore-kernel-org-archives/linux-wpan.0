Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:39584 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757261AbaLJOdg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 10 Dec 2014 09:33:36 -0500
Received: by mail-wg0-f51.google.com with SMTP id x12so3785698wgg.10
        for <linux-wpan@vger.kernel.org>; Wed, 10 Dec 2014 06:33:35 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/4] nl802154: introduce cca mode enums
Date: Wed, 10 Dec 2014 15:33:11 +0100
Message-Id: <1418221994-17976-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1418221994-17976-1-git-send-email-alex.aring@gmail.com>
References: <1418221994-17976-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds enums for 802.15.4 specific CCA settings.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/nl802154.h | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/include/net/nl802154.h b/include/net/nl802154.h
index 6dbd406..86c1b2f 100644
--- a/include/net/nl802154.h
+++ b/include/net/nl802154.h
@@ -119,4 +119,47 @@ enum nl802154_iftype {
 	NL802154_IFTYPE_MAX = NUM_NL802154_IFTYPES - 1
 };
 
+/**
+ * enum nl802154_cca_modes - cca modes
+ *
+ * @__NL802154_CCA_INVALID: cca mode number 0 is reserved
+ * @NL802154_CCA_ENERGY: Energy above threshold
+ * @NL802154_CCA_CARRIER: Carrier sense only
+ * @NL802154_CCA_ENERGY_CARRIER: Carrier sense with energy above threshold
+ * @NL802154_CCA_ALOHA: CCA shall always report an idle medium
+ * @NL802154_CCA_UWB_SHR: UWB preamble sense based on the SHR of a frame
+ * @NL802154_CCA_UWB_MULTIPEXED: UWB preamble sense based on the packet with
+ *	the multiplexed preamble
+ * @__NL802154_CCA_ATTR_AFTER_LAST: Internal
+ * @NL802154_CCA_ATTR_MAX: Maximum CCA attribute number
+ */
+enum nl802154_cca_modes {
+	__NL802154_CCA_INVALID,
+	NL802154_CCA_ENERGY,
+	NL802154_CCA_CARRIER,
+	NL802154_CCA_ENERGY_CARRIER,
+	NL802154_CCA_ALOHA,
+	NL802154_CCA_UWB_SHR,
+	NL802154_CCA_UWB_MULTIPEXED,
+
+	/* keep last */
+	__NL802154_CCA_ATTR_AFTER_LAST,
+	NL802154_CCA_ATTR_MAX = __NL802154_CCA_ATTR_AFTER_LAST - 1
+};
+
+/**
+ * enum nl802154_cca_opts - additional options for cca modes
+ *
+ * @NL802154_CCA_OPT_ENERGY_CARRIER_OR: NL802154_CCA_ENERGY_CARRIER with OR
+ * @NL802154_CCA_OPT_ENERGY_CARRIER_AND: NL802154_CCA_ENERGY_CARRIER with AND
+ */
+enum nl802154_cca_opts {
+	NL802154_CCA_OPT_ENERGY_CARRIER_AND,
+	NL802154_CCA_OPT_ENERGY_CARRIER_OR,
+
+	/* keep last */
+	__NL802154_CCA_OPT_ATTR_AFTER_LAST,
+	NL802154_CCA_OPT_ATTR_MAX = __NL802154_CCA_OPT_ATTR_AFTER_LAST - 1
+};
+
 #endif /* __NL802154_H */
-- 
2.1.3

