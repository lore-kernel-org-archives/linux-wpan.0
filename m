Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12658C7EE2A
	for <linux-wpan@archiver.kernel.org>; Thu,  1 Jun 2023 15:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjFAPta (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 1 Jun 2023 11:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbjFAPsf (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 1 Jun 2023 11:48:35 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BA7189;
        Thu,  1 Jun 2023 08:48:28 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685634507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ZXLtrqhWqGyuck/r86Slt1LonxLqDc5LEcJQMiVK0A=;
        b=TqBFWUNSdpXgPH0W1Fvghfy17fVQTKvlohw+Dk4tgL4Bo1pwL/LtVUR8v+lsGz7TX9fzrH
        HeaNd8scOdI85OTGo1FCgp9e/cU5ePEwTE2GvGGKouB+xL/MZkB2fxcMMSfE3N5hjisrP0
        KkuHZ+VNTFJRAyg+KJbGPEtbWpdGoFQxXYnTA/+t3tN+DY/Zli9GJEqM5j4f87eET8O4uf
        8QYpb8HD/gzKR6arDrldtZE8m1TN/5IggUptNsicnrAoc407ktBBpPXkrsB7oOz4vC8C9z
        7s4HnSyP0eY498RsPS7KZW0M4yUqkt5PRJ3OpTB93ZDJq/ojRgjDO7sPlir+8w==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 187E3C000C;
        Thu,  1 Jun 2023 15:48:24 +0000 (UTC)
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
Subject: [PATCH wpan-next 02/11] ieee802154: Internal PAN management
Date:   Thu,  1 Jun 2023 17:48:08 +0200
Message-Id: <20230601154817.754519-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601154817.754519-1-miquel.raynal@bootlin.com>
References: <20230601154817.754519-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index e00057984489..c67adf584672 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -302,6 +302,22 @@ struct ieee802154_coord_desc {
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
@@ -477,6 +493,11 @@ struct wpan_dev {
 
 	/* fallback for acknowledgment bit setting */
 	bool ackreq;
+
+	/* Associations */
+	struct mutex association_lock;
+	struct ieee802154_pan_device *parent;
+	struct list_head children;
 };
 
 #define to_phy(_dev)	container_of(_dev, struct wpan_phy, dev)
@@ -528,4 +549,29 @@ static inline const char *wpan_phy_name(struct wpan_phy *phy)
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

