Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53342 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725294AbfA2FBo (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 29 Jan 2019 00:01:44 -0500
From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [RFC net-next 2/4] net: Prepare EnOcean device drivers
Date: Tue, 29 Jan 2019 06:01:28 +0100
Message-Id: <20190129050130.10932-3-afaerber@suse.de>
In-Reply-To: <20190129050130.10932-1-afaerber@suse.de>
References: <20190129050130.10932-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-lpwan@lists.infradead.org, linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, support@enocean.com, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

Add net_device helpers for EnOcean.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/net/enocean/Makefile  |   2 +
 drivers/net/enocean/enocean.c | 124 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/enocean/dev.h   |  23 ++++++++
 3 files changed, 149 insertions(+)
 create mode 100644 drivers/net/enocean/Makefile
 create mode 100644 drivers/net/enocean/enocean.c
 create mode 100644 include/linux/enocean/dev.h

diff --git a/drivers/net/enocean/Makefile b/drivers/net/enocean/Makefile
new file mode 100644
index 000000000000..efb3cd16c7f2
--- /dev/null
+++ b/drivers/net/enocean/Makefile
@@ -0,0 +1,2 @@
+obj-m += enocean-dev.o
+enocean-dev-y := enocean.o
diff --git a/drivers/net/enocean/enocean.c b/drivers/net/enocean/enocean.c
new file mode 100644
index 000000000000..087a4de274c8
--- /dev/null
+++ b/drivers/net/enocean/enocean.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * EnOcean net device
+ *
+ * Copyright (c) 2019 Andreas Färber
+ */
+
+#include <linux/enocean/dev.h>
+#include <linux/if_arp.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <net/rtnetlink.h>
+
+int open_enocean_dev(struct net_device *dev)
+{
+	if (!netif_carrier_ok(dev))
+		netif_carrier_on(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(open_enocean_dev);
+
+void close_enocean_dev(struct net_device *dev)
+{
+}
+EXPORT_SYMBOL_GPL(close_enocean_dev);
+
+static void enocean_setup(struct net_device *dev)
+{
+	dev->type = ARPHRD_ENOCEAN;
+	dev->mtu = 255; /* XXX */
+	dev->hard_header_len = 0;
+	dev->addr_len = 0; /* XXX 4 */
+	dev->tx_queue_len = 10;
+
+	dev->flags = IFF_NOARP;
+	dev->features = 0;
+}
+
+struct net_device *alloc_enocean_dev(size_t priv_size)
+{
+	struct enocean_dev_priv *priv;
+	struct net_device *netdev;
+
+	netdev = alloc_netdev(priv_size, "enocean%d", NET_NAME_UNKNOWN, enocean_setup);
+	if (!netdev)
+		return NULL;
+
+	priv = netdev_priv(netdev);
+	priv->dev = netdev;
+
+	return netdev;
+}
+EXPORT_SYMBOL_GPL(alloc_enocean_dev);
+
+void free_enocean_dev(struct net_device *netdev)
+{
+	free_netdev(netdev);
+}
+EXPORT_SYMBOL_GPL(free_enocean_dev);
+
+static void devm_free_enocean_dev(struct device *dev, void *res)
+{
+	struct net_device **net = res;
+
+	free_enocean_dev(*net);
+}
+
+struct net_device *devm_alloc_enocean_dev(struct device *dev, size_t priv)
+{
+	struct net_device **ptr;
+	struct net_device *net;
+
+	net = alloc_enocean_dev(priv);
+	if (!net)
+		return NULL;
+
+	ptr = devres_alloc(devm_free_enocean_dev, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr) {
+		free_enocean_dev(net);
+		return NULL;
+	}
+
+	*ptr = net;
+	devres_add(dev, ptr);
+
+	return net;
+}
+EXPORT_SYMBOL_GPL(devm_alloc_enocean_dev);
+
+static struct rtnl_link_ops enocean_link_ops __read_mostly = {
+	.kind = "enocean",
+	.setup = enocean_setup,
+};
+
+int register_enocean_dev(struct net_device *dev)
+{
+	dev->rtnl_link_ops = &enocean_link_ops;
+	return register_netdev(dev);
+}
+EXPORT_SYMBOL_GPL(register_enocean_dev);
+
+void unregister_enocean_dev(struct net_device *dev)
+{
+	unregister_netdev(dev);
+}
+EXPORT_SYMBOL_GPL(unregister_enocean_dev);
+
+static int __init enocean_dev_init(void)
+{
+	return rtnl_link_register(&enocean_link_ops);
+}
+module_init(enocean_dev_init);
+
+static void __exit enocean_dev_exit(void)
+{
+	rtnl_link_unregister(&enocean_link_ops);
+}
+module_exit(enocean_dev_exit);
+
+MODULE_DESCRIPTION("EnOcean device driver interface");
+MODULE_ALIAS_RTNL_LINK("enocean");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Andreas Färber");
diff --git a/include/linux/enocean/dev.h b/include/linux/enocean/dev.h
new file mode 100644
index 000000000000..be9d37cdde37
--- /dev/null
+++ b/include/linux/enocean/dev.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * linux/enocean/dev.h
+ *
+ * Copyright (c) 2019 Andreas Färber
+ */
+#ifndef _ENOCEAN_DEV_H
+#define _ENOCEAN_DEV_H
+
+#include <linux/netdevice.h>
+
+struct net_device *alloc_enocean_dev(size_t priv_size);
+struct net_device *devm_alloc_enocean_dev(struct device *dev, size_t priv_size);
+int register_enocean_dev(struct net_device *netdev);
+void unregister_enocean_dev(struct net_device *netdev);
+int open_enocean_dev(struct net_device *netdev);
+void close_enocean_dev(struct net_device *netdev);
+
+struct enocean_dev_priv {
+	struct net_device *dev;
+};
+
+#endif
-- 
2.16.4
