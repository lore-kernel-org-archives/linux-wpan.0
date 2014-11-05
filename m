Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:62504 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbaKETwV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 5 Nov 2014 14:52:21 -0500
Received: by mail-wi0-f181.google.com with SMTP id n3so3084299wiv.8
        for <linux-wpan@vger.kernel.org>; Wed, 05 Nov 2014 11:52:20 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 13/18] mac802154: cleanup ieee802154_netdev_to_extended_addr
Date: Wed,  5 Nov 2014 20:51:24 +0100
Message-Id: <1415217089-24919-14-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
References: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch cleanups the ieee802154_be64_to_le64 to have a similar
function like ieee802154_le64_to_be64 only with switched source and
destionation types.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/mac802154.h | 11 +++++++----
 net/mac802154/iface.c   |  2 +-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index cc188cb..632f656 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -224,12 +224,15 @@ struct ieee802154_ops {
 };
 
 /**
- * ieee802154_netdev_to_extended_addr - convert big endian 64 byte void pointer to __le64
- * @dev_addr: big endian address pointer like netdevice dev_addr attribute
+ * ieee802154_be64_to_le64 - copies and convert be64 to le64
+ * @le64_dst: le64 destination pointer
+ * @be64_src: be64 source pointer
  */
-static inline __le64 ieee802154_netdev_to_extended_addr(const void *dev_addr)
+static inline void ieee802154_be64_to_le64(void *le64_dst, const void *be64_src)
 {
-	return (__force __le64)swab64p(dev_addr);
+	__le64 tmp = (__force __le64)swab64p(be64_src);
+
+	memcpy(le64_dst, &tmp, IEEE802154_EXTENDED_ADDR_LEN);
 }
 
 /**
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 764ce49..a1aa09b 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -117,7 +117,7 @@ static int mac802154_wpan_mac_addr(struct net_device *dev, void *p)
 	if (netif_running(dev))
 		return -EBUSY;
 
-	extended_addr = ieee802154_netdev_to_extended_addr(addr->sa_data);
+	ieee802154_be64_to_le64(&extended_addr, addr->sa_data);
 	if (!ieee802154_is_valid_extended_addr(extended_addr))
 		return -EINVAL;
 
-- 
2.1.3

