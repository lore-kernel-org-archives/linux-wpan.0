Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C564CA0FEC
	for <linux-wpan@archiver.kernel.org>; Fri,  1 Sep 2023 17:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345724AbjIARFS (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 1 Sep 2023 13:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348824AbjIARFS (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 1 Sep 2023 13:05:18 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8738910F4;
        Fri,  1 Sep 2023 10:05:14 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5F225C0008;
        Fri,  1 Sep 2023 17:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693587913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=80PjSG1lomz0gvY0FXNTK/3IctexZpKvaYYUNputLzM=;
        b=QkmBKLu1wW4JhQTQSFF75nMwRpfUD11UVp+iyv/IzFx2Eth6F8XGFu2t/PA2j4y9KrpyC7
        I25bgmFMhPsMvzd/vXmjjlXD9iggDzvXNSBOXAfVmS4AeyQh/9tl3xWHZWh/vLcvSjpjbE
        iklAT9cGuzglPLeySosjfkD5FoMwDU8XuVI/jwB8b5DcUJxTtiZ7dqFB40e5ji7b3Penhm
        7Dt57dVDygEgWhIWeL2xYnZI6Souf29qI5tnsq93nEu/apbrjzr23CV/FQc9EQxLL/sUIV
        UbMp2983HYGXAxfW5/+7/6U7070nChKezBRqhPMCrfOhwrm8ggH+wetCHzKhqQ==
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
Subject: [PATCH wpan-next v2 02/11] ieee802154: Internal PAN management
Date:   Fri,  1 Sep 2023 19:04:52 +0200
Message-Id: <20230901170501.1066321-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901170501.1066321-1-miquel.raynal@bootlin.com>
References: <20230901170501.1066321-1-miquel.raynal@bootlin.com>
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
 include/net/cfg802154.h | 46 ++++++++++++++++++++++++++++
 net/ieee802154/Makefile |  2 +-
 net/ieee802154/core.c   |  2 ++
 net/ieee802154/pan.c    | 66 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+), 1 deletion(-)
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
index 000000000000..e2a12a42ba2b
--- /dev/null
+++ b/net/ieee802154/pan.c
@@ -0,0 +1,66 @@
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
+static bool cfg802154_same_addr(struct ieee802154_pan_device *a,
+				struct ieee802154_addr *b)
+{
+	if (!a || !b)
+		return false;
+
+	switch (b->mode) {
+	case IEEE802154_ADDR_SHORT:
+		return a->short_addr == b->short_addr;
+	case IEEE802154_ADDR_LONG:
+		return a->extended_addr == b->extended_addr;
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
+	if (cfg802154_same_addr(wpan_dev->parent, target))
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
+		if (cfg802154_same_addr(child, target))
+			return child;
+
+	return NULL;
+}
-- 
2.34.1

