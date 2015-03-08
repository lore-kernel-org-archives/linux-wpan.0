Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:33428 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbbCHIRk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 8 Mar 2015 04:17:40 -0400
Received: by wggz12 with SMTP id z12so2315534wgg.0
        for <linux-wpan@vger.kernel.org>; Sun, 08 Mar 2015 00:17:39 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 1/2] of: net: add support for extended address
Date: Sun,  8 Mar 2015 09:17:22 +0100
Message-Id: <1425802643-5798-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1425802643-5798-1-git-send-email-alex.aring@gmail.com>
References: <1425802643-5798-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a general of_get_extended_address function. The idea is
that 802.15.4 transceivers contains an "extended-address" property like
"mac-address" property. In driver layer each driver can request such address
via calling the of_get_extended_address function and set the
perm_extended_addr attribute of a 802.15.4 phy. This is the default used
extended address of a 802.15.4 interface.
The of_get_extended_address function returns an invalid address on
error. The sense is to validate the extended afterwards by calling
ieee802154_is_valid_extended_addr then the driver can choose an other
source for default extended address like reading firmware or a random
one.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/of/of_net.c    | 34 ++++++++++++++++++++++++++++++++++
 include/linux/of_net.h |  6 ++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/of/of_net.c b/drivers/of/of_net.c
index 73e1418..316048e 100644
--- a/drivers/of/of_net.c
+++ b/drivers/of/of_net.c
@@ -6,11 +6,14 @@
  * Initially copied out of arch/powerpc/kernel/prom_parse.c
  */
 #include <linux/etherdevice.h>
+#include <linux/ieee802154.h>
 #include <linux/kernel.h>
 #include <linux/of_net.h>
 #include <linux/phy.h>
 #include <linux/export.h>
 
+#include <net/mac802154.h>
+
 /**
  * of_get_phy_mode - Get phy mode for given device_node
  * @np:	Pointer to the given device_node
@@ -75,3 +78,34 @@ const void *of_get_mac_address(struct device_node *np)
 	return NULL;
 }
 EXPORT_SYMBOL(of_get_mac_address);
+
+/**
+ * Search the device tree for the best extended address to use.
+ * 'extended-address' is checked first, because that is supposed to contain
+ * to "most recent" extended address. If that isn't set, then
+ * 'local-extended-address' is checked next, because that is the default
+ * address.
+ *
+ * Returns a valid extended address on success, otherwise an invalid extended
+ * address.
+*/
+__le64 of_get_extended_address(struct device_node *np)
+{
+	struct property *pp;
+	__le64 extended_addr = cpu_to_le64(0x0000000000000000ULL);
+
+	pp = of_find_property(np, "extended-address", NULL);
+	if (pp && (pp->length == IEEE802154_EXTENDED_ADDR_LEN)) {
+		ieee802154_be64_to_le64(&extended_addr, pp->value);
+
+		if (ieee802154_is_valid_extended_addr(extended_addr))
+			return extended_addr;
+	}
+
+	pp = of_find_property(np, "local-extended-address", NULL);
+	if (pp && (pp->length == IEEE802154_EXTENDED_ADDR_LEN))
+		ieee802154_be64_to_le64(&extended_addr, pp->value);
+
+	return extended_addr;
+}
+EXPORT_SYMBOL(of_get_extended_address);
diff --git a/include/linux/of_net.h b/include/linux/of_net.h
index 34597c8..6e677ab 100644
--- a/include/linux/of_net.h
+++ b/include/linux/of_net.h
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 extern int of_get_phy_mode(struct device_node *np);
 extern const void *of_get_mac_address(struct device_node *np);
+extern __le64 of_get_extended_address(struct device_node *np);
 #else
 static inline int of_get_phy_mode(struct device_node *np)
 {
@@ -21,6 +22,11 @@ static inline const void *of_get_mac_address(struct device_node *np)
 {
 	return NULL;
 }
+
+static inline __le64 of_get_extended_address(struct device_node *np)
+{
+	return cpu_to_le64(0x0000000000000000ULL);
+}
 #endif
 
 #endif /* __LINUX_OF_NET_H */
-- 
2.3.0

