Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35918 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460AbbIBMWS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 2 Sep 2015 08:22:18 -0400
Received: by wibz8 with SMTP id z8so63886080wib.1
        for <linux-wpan@vger.kernel.org>; Wed, 02 Sep 2015 05:22:17 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 14/16] ieee802154: 6lowpan: check on valid 802.15.4 frame
Date: Wed,  2 Sep 2015 14:21:29 +0200
Message-Id: <1441196491-25013-15-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1441196491-25013-1-git-send-email-alex.aring@gmail.com>
References: <1441196491-25013-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds frame control checks to check if the received frame is
something which could contain a 6LoWPAN packet.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/linux/ieee802154.h  | 25 +++++++++++++++++++++++++
 include/net/mac802154.h     | 15 +++++++++++++++
 net/ieee802154/6lowpan/rx.c |  8 ++++++++
 3 files changed, 48 insertions(+)

diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index 1dc1f4e..db01492 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -205,6 +205,31 @@ enum {
 	IEEE802154_SCAN_IN_PROGRESS = 0xfc,
 };
 
+/* frame control handling */
+#define IEEE802154_FCTL_FTYPE		0x0003
+#define IEEE802154_FCTL_INTRA_PAN	0x0040
+
+#define IEEE802154_FTYPE_DATA		0x0001
+
+/*
+ * ieee802154_is_data - check if type is IEEE802154_FTYPE_DATA
+ * @fc: frame control bytes in little-endian byteorder
+ */
+static inline int ieee802154_is_data(__le16 fc)
+{
+	return (fc & cpu_to_le16(IEEE802154_FCTL_FTYPE)) ==
+		cpu_to_le16(IEEE802154_FTYPE_DATA);
+}
+
+/**
+ * ieee802154_is_intra_pan - check if intra pan id communication
+ * @fc: frame control bytes in little-endian byteorder
+ */
+static inline bool ieee802154_is_intra_pan(__le16 fc)
+{
+	return fc & cpu_to_le16(IEEE802154_FCTL_INTRA_PAN);
+}
+
 /**
  * ieee802154_is_valid_psdu_len - check if psdu len is valid
  * available lengths:
diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index b7f9961..32bd7c0 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -250,6 +250,21 @@ struct ieee802154_ops {
 };
 
 /**
+ * ieee802154_get_fc_from_skb - get the frame control field from an skb
+ * @skb: skb where the frame control field will be get from
+ */
+static inline __le16 ieee802154_get_fc_from_skb(const struct sk_buff *skb)
+{
+	/* return some invalid fc on failure */
+	if (unlikely(skb->mac_len < 2)) {
+		WARN_ON(1);
+		return cpu_to_le16(0);
+	}
+
+	return (__force __le16)__get_unaligned_memmove16(skb_mac_header(skb));
+}
+
+/**
  * ieee802154_be64_to_le64 - copies and convert be64 to le64
  * @le64_dst: le64 destination pointer
  * @be64_src: be64 source pointer
diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index 45ce121..f7eb091 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -11,6 +11,7 @@
 #include <linux/if_arp.h>
 
 #include <net/6lowpan.h>
+#include <net/mac802154.h>
 #include <net/ieee802154_netdev.h>
 
 #include "6lowpan_i.h"
@@ -280,6 +281,13 @@ static inline bool lowpan_is_reserved(u8 dispatch)
  */
 static inline bool lowpan_rx_h_check(struct sk_buff *skb)
 {
+	__le16 fc = ieee802154_get_fc_from_skb(skb);
+
+	/* check on ieee802154 conform 6LoWPAN header */
+	if (!ieee802154_is_data(fc) ||
+	    !ieee802154_is_intra_pan(fc))
+		return false;
+
 	/* check if we can dereference the dispatch */
 	if (unlikely(!skb->len))
 		return false;
-- 
2.5.1

