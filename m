Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F52CD37B0
	for <linux-wpan@archiver.kernel.org>; Mon, 18 Sep 2023 15:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjIRPrD (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 18 Sep 2023 11:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjIRPrB (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 18 Sep 2023 11:47:01 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [IPv6:2001:4b98:dc4:8::240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE89E172B;
        Mon, 18 Sep 2023 08:45:48 -0700 (PDT)
Received: from relay5-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::225])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 97406D0512;
        Mon, 18 Sep 2023 15:08:33 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C47CC1C0004;
        Mon, 18 Sep 2023 15:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695049713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fLbkdQ5FKMBkZ8ku8+A9PPhvmnQ/W+CH50JC0Ef1AEk=;
        b=ihLLpEBtxV7e7aBRiZQwMoRKFUBTPxxvwy/adKHNx3TB+L27SsEJ3yvFqjh4d0Ki9YvdpE
        UsdTSAHN3mqcdl2tnk0eJuFfPFjxUGN3JVpd8+ZUjdghgrLPM1kHC4K9GwFipJDlUlq7w9
        pi3AE86TrVy1D0uV9zxRNgQChOZHhYtJY8Cri9NyUY2UwNuGMIWR/6LAyc14NXC7KEbAnT
        RJgnM9iokwr5yFNWZ3n5MDVvwHEBfosr+ZLV2x17/vZg7noSZSTBO1S8eni1Ril5wGubze
        qpg7EWBwPJhJSjSN+/M/CBWwfTgk6PhRnwELHoZEmRE9HOKvDUnCl2TA0YIA0Q==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-next v3 02/11] ieee802154: Internal PAN management
Date:   Mon, 18 Sep 2023 17:08:00 +0200
Message-Id: <20230918150809.275058-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918150809.275058-1-miquel.raynal@bootlin.com>
References: <20230918150809.275058-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Introduce structures to describe peer devices in a PAN as well as a few
related helpers. We basically care about:
- Our unique parent after associating with a coordinator.
- Peer devices, children, which successfully associated with us.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/net/cfg802154.h | 46 +++++++++++++++++++++++++
 net/ieee802154/Makefile |  2 +-
 net/ieee802154/core.c   |  2 ++
 net/ieee802154/pan.c    | 75 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 124 insertions(+), 1 deletion(-)
 create mode 100644 net/ieee802154/pan.c

diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index f79ce133e51a..6c7193b4873c 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -303,6 +303,22 @@ struct ieee802154_coord_desc {
 	bool gts_permit;
 };
 
+/**
+ * struct ieee802154_pan_device - PAN device information
+ * @pan_id: the PAN ID of this device
+ * @mode: the preferred mode to reach the device
+ * @short_addr: the short address of this device
+ * @extended_addr: the extended address of this device
+ * @node: the list node
+ */
+struct ieee802154_pan_device {
+	__le16 pan_id;
+	u8 mode;
+	__le16 short_addr;
+	__le64 extended_addr;
+	struct list_head node;
+};
+
 /**
  * struct cfg802154_scan_request - Scan request
  *
@@ -478,6 +494,11 @@ struct wpan_dev {
 
 	/* fallback for acknowledgment bit setting */
 	bool ackreq;
+
+	/* Associations */
+	struct mutex association_lock;
+	struct ieee802154_pan_device *parent;
+	struct list_head children;
 };
 
 #define to_phy(_dev)	container_of(_dev, struct wpan_phy, dev)
@@ -529,4 +550,29 @@ static inline const char *wpan_phy_name(struct wpan_phy *phy)
 void ieee802154_configure_durations(struct wpan_phy *phy,
 				    unsigned int page, unsigned int channel);
 
+/**
+ * cfg802154_device_is_associated - Checks whether we are associated to any device
+ * @wpan_dev: the wpan device
+ */
+bool cfg802154_device_is_associated(struct wpan_dev *wpan_dev);
+
+/**
+ * cfg802154_device_is_parent - Checks if a device is our coordinator
+ * @wpan_dev: the wpan device
+ * @target: the expected parent
+ * @return: true if @target is our coordinator
+ */
+bool cfg802154_device_is_parent(struct wpan_dev *wpan_dev,
+				struct ieee802154_addr *target);
+
+/**
+ * cfg802154_device_is_child - Checks whether a device is associated to us
+ * @wpan_dev: the wpan device
+ * @target: the expected child
+ * @return: the PAN device
+ */
+struct ieee802154_pan_device *
+cfg802154_device_is_child(struct wpan_dev *wpan_dev,
+			  struct ieee802154_addr *target);
+
 #endif /* __NET_CFG802154_H */
diff --git a/net/ieee802154/Makefile b/net/ieee802154/Makefile
index f05b7bdae2aa..7bce67673e83 100644
--- a/net/ieee802154/Makefile
+++ b/net/ieee802154/Makefile
@@ -4,7 +4,7 @@ obj-$(CONFIG_IEEE802154_SOCKET) += ieee802154_socket.o
 obj-y += 6lowpan/
 
 ieee802154-y := netlink.o nl-mac.o nl-phy.o nl_policy.o core.o \
-                header_ops.o sysfs.o nl802154.o trace.o
+                header_ops.o sysfs.o nl802154.o trace.o pan.o
 ieee802154_socket-y := socket.o
 
 CFLAGS_trace.o := -I$(src)
diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index 57546e07e06a..cd69bdbfd59f 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -276,6 +276,8 @@ static int cfg802154_netdev_notifier_call(struct notifier_block *nb,
 		wpan_dev->identifier = ++rdev->wpan_dev_id;
 		list_add_rcu(&wpan_dev->list, &rdev->wpan_dev_list);
 		rdev->devlist_generation++;
+		mutex_init(&wpan_dev->association_lock);
+		INIT_LIST_HEAD(&wpan_dev->children);
 
 		wpan_dev->netdev = dev;
 		break;
diff --git a/net/ieee802154/pan.c b/net/ieee802154/pan.c
new file mode 100644
index 000000000000..012b5e821d54
--- /dev/null
+++ b/net/ieee802154/pan.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IEEE 802.15.4 PAN management
+ *
+ * Copyright (C) 2021 Qorvo US, Inc
+ * Authors:
+ *   - David Girault <david.girault@qorvo.com>
+ *   - Miquel Raynal <miquel.raynal@bootlin.com>
+ */
+
+#include <linux/kernel.h>
+#include <net/cfg802154.h>
+#include <net/af_ieee802154.h>
+
+/* Checks whether a device address matches one from the PAN list */
+static bool cfg802154_device_in_pan(struct ieee802154_pan_device *pan_dev,
+				    struct ieee802154_addr *ext_dev)
+{
+	if (!pan_dev || !ext_dev)
+		return false;
+
+	/* We know the PAN device extended address, and if it is a child which
+	 * required a short address, then we also know its short address and the
+	 * (preferred) mode is set to IEEE802154_ADDR_SHORT.
+	 */
+	if (ext_dev->mode == IEEE802154_ADDR_SHORT &&
+	    pan_dev->mode != IEEE802154_ADDR_SHORT)
+		return false;
+
+	switch (ext_dev->mode) {
+	case IEEE802154_ADDR_SHORT:
+		return pan_dev->short_addr == ext_dev->short_addr;
+	case IEEE802154_ADDR_LONG:
+		return pan_dev->extended_addr == ext_dev->extended_addr;
+	default:
+		return false;
+	}
+}
+
+bool cfg802154_device_is_associated(struct wpan_dev *wpan_dev)
+{
+	bool is_assoc;
+
+	mutex_lock(&wpan_dev->association_lock);
+	is_assoc = !list_empty(&wpan_dev->children) || wpan_dev->parent;
+	mutex_unlock(&wpan_dev->association_lock);
+
+	return is_assoc;
+}
+
+bool cfg802154_device_is_parent(struct wpan_dev *wpan_dev,
+				struct ieee802154_addr *target)
+{
+	lockdep_assert_held(&wpan_dev->association_lock);
+
+	if (cfg802154_device_in_pan(wpan_dev->parent, target))
+		return true;
+
+	return false;
+}
+
+struct ieee802154_pan_device *
+cfg802154_device_is_child(struct wpan_dev *wpan_dev,
+			  struct ieee802154_addr *target)
+{
+	struct ieee802154_pan_device *child;
+
+	lockdep_assert_held(&wpan_dev->association_lock);
+
+	list_for_each_entry(child, &wpan_dev->children, node)
+		if (cfg802154_device_in_pan(child, target))
+			return child;
+
+	return NULL;
+}
-- 
2.34.1

