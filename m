Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:43379 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbaKBDTU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 1 Nov 2014 23:19:20 -0400
Received: by mail-wi0-f169.google.com with SMTP id n3so3769872wiv.4
        for <linux-wpan@vger.kernel.org>; Sat, 01 Nov 2014 20:19:19 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 09/16] mac802154: add helper for converting dev_addr
Date: Sun,  2 Nov 2014 04:18:40 +0100
Message-Id: <1414898327-20759-10-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
References: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a helper for converting the dev_addr attribute in
netdevice to __le64 type. The dev_addr attribute is a char pointer
and contains the extended address in big endian byte order.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/mac802154.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 8f1de68..c17acbd 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -214,6 +214,15 @@ struct ieee802154_ops {
 						const bool on);
 };
 
+/**
+ * ieee802154_netdev_to_extended_addr - convert __be64 u8 pointer to __le64
+ * @dev_addr: big endian address pointer like netdevice dev_addr attribute
+ */
+static inline __le64 ieee802154_netdev_to_extended_addr(const u8 *dev_addr)
+{
+	return (__le64)swab64(*((__be64 *)dev_addr));
+}
+
 /* Basic interface to register ieee802154 hwice */
 struct ieee802154_hw *
 ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops);
-- 
2.1.3

