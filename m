Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:40865 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbaKETwU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 5 Nov 2014 14:52:20 -0500
Received: by mail-wi0-f178.google.com with SMTP id bs8so1090947wib.17
        for <linux-wpan@vger.kernel.org>; Wed, 05 Nov 2014 11:52:19 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 12/18] mac802154: add ieee802154_le64_to_be64
Date: Wed,  5 Nov 2014 20:51:23 +0100
Message-Id: <1415217089-24919-13-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
References: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a new function to convert a le64 to a be64. This is
useful to translate an extended address to a netdev dev_addr.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/mac802154.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 10711a6..cc188cb 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -17,6 +17,7 @@
 #define NET_MAC802154_H
 
 #include <net/af_ieee802154.h>
+#include <linux/ieee802154.h>
 #include <linux/skbuff.h>
 
 /* General MAC frame format:
@@ -231,6 +232,18 @@ static inline __le64 ieee802154_netdev_to_extended_addr(const void *dev_addr)
 	return (__force __le64)swab64p(dev_addr);
 }
 
+/**
+ * ieee802154_le64_to_be64 - copies and convert le64 to be64
+ * @be64_dst: be64 destination pointer
+ * @le64_src: le64 source pointer
+ */
+static inline void ieee802154_le64_to_be64(void *be64_dst, const void *le64_src)
+{
+	__be64 tmp = (__force __be64)swab64p(le64_src);
+
+	memcpy(be64_dst, &tmp, IEEE802154_EXTENDED_ADDR_LEN);
+}
+
 /* Basic interface to register ieee802154 hwice */
 struct ieee802154_hw *
 ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops);
-- 
2.1.3

