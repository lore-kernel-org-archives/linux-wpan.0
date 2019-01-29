Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53368 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725298AbfA2FBo (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 29 Jan 2019 00:01:44 -0500
From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [RFC net-next 3/4] net: enocean: Add ESP3 driver
Date: Tue, 29 Jan 2019 06:01:29 +0100
Message-Id: <20190129050130.10932-4-afaerber@suse.de>
In-Reply-To: <20190129050130.10932-1-afaerber@suse.de>
References: <20190129050130.10932-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-lpwan@lists.infradead.org, linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, support@enocean.com, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

This implements the EnOcean Serial Protocol 3.
Rudimentary sending is prepared. Error handling is lacking and
reception handling is missing.

Tested with EnOcean TCM310 gateway module.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/net/enocean/Makefile       |   4 +
 drivers/net/enocean/enocean_esp.c  | 277 +++++++++++++++++++++++++++
 drivers/net/enocean/enocean_esp.h  |  38 ++++
 drivers/net/enocean/enocean_esp3.c | 372 +++++++++++++++++++++++++++++++++++++
 4 files changed, 691 insertions(+)
 create mode 100644 drivers/net/enocean/enocean_esp.c
 create mode 100644 drivers/net/enocean/enocean_esp.h
 create mode 100644 drivers/net/enocean/enocean_esp3.c

diff --git a/drivers/net/enocean/Makefile b/drivers/net/enocean/Makefile
index efb3cd16c7f2..4492e3d48c0a 100644
--- a/drivers/net/enocean/Makefile
+++ b/drivers/net/enocean/Makefile
@@ -1,2 +1,6 @@
 obj-m += enocean-dev.o
 enocean-dev-y := enocean.o
+
+obj-m += enocean-esp.o
+enocean-esp-y := enocean_esp.o
+enocean-esp-y += enocean_esp3.o
diff --git a/drivers/net/enocean/enocean_esp.c b/drivers/net/enocean/enocean_esp.c
new file mode 100644
index 000000000000..61bddb77762d
--- /dev/null
+++ b/drivers/net/enocean/enocean_esp.c
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * EnOcean Serial Protocol
+ *
+ * Copyright (c) 2019 Andreas Färber
+ */
+
+#include <linux/bitops.h>
+#include <linux/completion.h>
+#include <linux/enocean/dev.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/serdev.h>
+
+#include "enocean_esp.h"
+
+struct enocean_esp_version {
+	int version;
+	int baudrate;
+	const struct serdev_device_ops *serdev_client_ops;
+	int (*init)(struct enocean_device *edev);
+	int (*send)(struct enocean_device *edev, u32 dest, const void *data, int data_len);
+	void (*cleanup)(struct enocean_device *edev);
+};
+
+struct enocean_esp_priv {
+	struct enocean_dev_priv priv;
+
+	struct enocean_device *edev;
+
+	struct sk_buff *tx_skb;
+	int tx_len;
+
+	struct workqueue_struct *wq;
+	struct work_struct tx_work;
+};
+
+static netdev_tx_t enocean_dev_start_xmit(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct enocean_esp_priv *priv = netdev_priv(netdev);
+
+	netdev_dbg(netdev, "%s\n", __func__);
+
+	if (skb->protocol != htons(ETH_P_ERP1) &&
+	    skb->protocol != htons(ETH_P_ERP2)) {
+		kfree_skb(skb);
+		netdev->stats.tx_dropped++;
+		return NETDEV_TX_OK;
+	}
+
+	netif_stop_queue(netdev);
+	priv->tx_skb = skb;
+	queue_work(priv->wq, &priv->tx_work);
+
+	return NETDEV_TX_OK;
+}
+
+static int enocean_esp_tx(struct enocean_device *edev, void *data, int data_len)
+{
+	if (!edev->version->send)
+		return -ENOTSUPP;
+	return edev->version->send(edev, 0xffffffff, data, data_len);
+}
+
+static void enocean_esp_tx_work_handler(struct work_struct *ws)
+{
+	struct enocean_esp_priv *priv = container_of(ws, struct enocean_esp_priv, tx_work);
+	struct enocean_device *edev = priv->edev;
+	struct net_device *netdev = edev->netdev;
+
+	netdev_dbg(netdev, "%s\n", __func__);
+
+	if (priv->tx_skb) {
+		enocean_esp_tx(edev, priv->tx_skb->data, priv->tx_skb->len);
+		priv->tx_len = 1 + priv->tx_skb->len;
+		if (!(netdev->flags & IFF_ECHO) ||
+			priv->tx_skb->pkt_type != PACKET_LOOPBACK ||
+			(priv->tx_skb->protocol != htons(ETH_P_ERP1) &&
+			 priv->tx_skb->protocol != htons(ETH_P_ERP2)))
+			kfree_skb(priv->tx_skb);
+		priv->tx_skb = NULL;
+	}
+}
+
+void enocean_esp_tx_done(struct enocean_device *edev)
+{
+	struct net_device *netdev = edev->netdev;
+	struct enocean_esp_priv *priv = netdev_priv(netdev);
+
+	netdev_info(netdev, "TX done.\n");
+	netdev->stats.tx_packets++;
+	netdev->stats.tx_bytes += priv->tx_len - 1;
+	priv->tx_len = 0;
+	netif_wake_queue(netdev);
+}
+
+static int enocean_dev_open(struct net_device *netdev)
+{
+	struct enocean_esp_priv *priv = netdev_priv(netdev);
+	int ret;
+
+	netdev_dbg(netdev, "%s\n", __func__);
+
+	ret = open_enocean_dev(netdev);
+	if (ret)
+		return ret;
+
+	priv->tx_skb = NULL;
+	priv->tx_len = 0;
+
+	priv->wq = alloc_workqueue("enocean_esp_wq", WQ_FREEZABLE | WQ_MEM_RECLAIM, 0);
+	INIT_WORK(&priv->tx_work, enocean_esp_tx_work_handler);
+
+	netif_wake_queue(netdev);
+
+	return 0;
+}
+
+static int enocean_dev_stop(struct net_device *netdev)
+{
+	struct enocean_esp_priv *priv = netdev_priv(netdev);
+
+	netdev_dbg(netdev, "%s\n", __func__);
+
+	close_enocean_dev(netdev);
+
+	destroy_workqueue(priv->wq);
+	priv->wq = NULL;
+
+	if (priv->tx_skb || priv->tx_len)
+		netdev->stats.tx_errors++;
+	if (priv->tx_skb)
+		dev_kfree_skb(priv->tx_skb);
+	priv->tx_skb = NULL;
+	priv->tx_len = 0;
+
+	return 0;
+}
+
+static const struct net_device_ops enocean_esp_netdev_ops =  {
+	.ndo_open = enocean_dev_open,
+	.ndo_stop = enocean_dev_stop,
+	.ndo_start_xmit = enocean_dev_start_xmit,
+};
+
+static void enocean_esp_cleanup(struct enocean_device *edev)
+{
+	if (edev->version->cleanup)
+		edev->version->cleanup(edev);
+}
+
+static const struct enocean_esp_version enocean_esp3 = {
+	.version = 3,
+	.baudrate = 57600,
+	.serdev_client_ops = &enocean_esp3_serdev_client_ops,
+	.init = enocean_esp3_init,
+	.send = enocean_esp3_send,
+	.cleanup = enocean_esp3_cleanup,
+};
+
+static const struct of_device_id enocean_of_match[] = {
+	{ .compatible = "enocean,esp3", .data = &enocean_esp3 },
+	{}
+};
+MODULE_DEVICE_TABLE(of, enocean_of_match);
+
+static int enocean_probe(struct serdev_device *sdev)
+{
+	struct enocean_esp_priv *priv;
+	struct enocean_device *edev;
+	int ret;
+
+	dev_dbg(&sdev->dev, "Probing");
+
+	edev = devm_kzalloc(&sdev->dev, sizeof(*edev), GFP_KERNEL);
+	if (!edev)
+		return -ENOMEM;
+
+	edev->version = of_device_get_match_data(&sdev->dev);
+	if (!edev->version)
+		return -ENOTSUPP;
+
+	dev_dbg(&sdev->dev, "ESP%d\n", edev->version->version);
+
+	edev->serdev = sdev;
+	INIT_LIST_HEAD(&edev->esp_dispatchers);
+	serdev_device_set_drvdata(sdev, edev);
+
+	ret = serdev_device_open(sdev);
+	if (ret) {
+		dev_err(&sdev->dev, "Failed to open (%d)\n", ret);
+		return ret;
+	}
+
+	serdev_device_set_baudrate(sdev, edev->version->baudrate);
+	serdev_device_set_flow_control(sdev, false);
+	serdev_device_set_client_ops(sdev, edev->version->serdev_client_ops);
+
+	if (edev->version->init) {
+		ret = edev->version->init(edev);
+		if (ret) {
+			serdev_device_close(sdev);
+			return ret;
+		}
+	}
+
+	edev->netdev = devm_alloc_enocean_dev(&sdev->dev, sizeof(struct enocean_esp_priv));
+	if (!edev->netdev) {
+		enocean_esp_cleanup(edev);
+		serdev_device_close(sdev);
+		return -ENOMEM;
+	}
+
+	edev->netdev->netdev_ops = &enocean_esp_netdev_ops;
+	edev->netdev->flags |= IFF_ECHO;
+	SET_NETDEV_DEV(edev->netdev, &sdev->dev);
+
+	priv = netdev_priv(edev->netdev);
+	priv->edev = edev;
+
+	ret = register_enocean_dev(edev->netdev);
+	if (ret) {
+		enocean_esp_cleanup(edev);
+		serdev_device_close(sdev);
+		return ret;
+	}
+
+	dev_dbg(&sdev->dev, "Done.\n");
+
+	return 0;
+}
+
+static void enocean_remove(struct serdev_device *sdev)
+{
+	struct enocean_device *edev = serdev_device_get_drvdata(sdev);
+
+	unregister_enocean_dev(edev->netdev);
+	enocean_esp_cleanup(edev);
+	serdev_device_close(sdev);
+
+	dev_dbg(&sdev->dev, "Removed\n");
+}
+
+static struct serdev_device_driver enocean_serdev_driver = {
+	.probe = enocean_probe,
+	.remove = enocean_remove,
+	.driver = {
+		.name = "enocean-esp",
+		.of_match_table = enocean_of_match,
+	},
+};
+
+static int __init enocean_init(void)
+{
+	int ret;
+
+	enocean_esp3_crc8_populate();
+
+	ret = serdev_device_driver_register(&enocean_serdev_driver);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void __exit enocean_exit(void)
+{
+	serdev_device_driver_unregister(&enocean_serdev_driver);
+}
+
+module_init(enocean_init);
+module_exit(enocean_exit);
+
+MODULE_DESCRIPTION("EnOcean serdev driver");
+MODULE_AUTHOR("Andreas Färber <afaerber@suse.de>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/enocean/enocean_esp.h b/drivers/net/enocean/enocean_esp.h
new file mode 100644
index 000000000000..e02bf5352d61
--- /dev/null
+++ b/drivers/net/enocean/enocean_esp.h
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * EnOcean Serial Protocol
+ *
+ * Copyright (c) 2019 Andreas Färber
+ */
+#ifndef ENOCEAN_H
+#define ENOCEAN_H
+
+#include <linux/netdevice.h>
+#include <linux/rculist.h>
+#include <linux/serdev.h>
+
+struct enocean_esp_version;
+
+struct enocean_device {
+	struct serdev_device *serdev;
+	const struct enocean_esp_version *version;
+
+	struct net_device *netdev;
+
+	struct list_head esp_dispatchers;
+
+	void *priv;
+};
+
+extern const struct serdev_device_ops enocean_esp3_serdev_client_ops;
+
+void enocean_esp3_crc8_populate(void);
+
+int enocean_esp3_init(struct enocean_device *edev);
+
+int enocean_esp3_send(struct enocean_device *edev, u32 dest, const void *data, int data_len);
+void enocean_esp_tx_done(struct enocean_device *edev);
+
+void enocean_esp3_cleanup(struct enocean_device *edev);
+
+#endif
diff --git a/drivers/net/enocean/enocean_esp3.c b/drivers/net/enocean/enocean_esp3.c
new file mode 100644
index 000000000000..707c4054ac69
--- /dev/null
+++ b/drivers/net/enocean/enocean_esp3.c
@@ -0,0 +1,372 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * EnOcean Serial Protocol 3
+ *
+ * Copyright (c) 2019 Andreas Färber
+ */
+
+#include <asm/unaligned.h>
+#include <linux/completion.h>
+#include <linux/crc8.h>
+#include <linux/rculist.h>
+#include <linux/serdev.h>
+#include <linux/slab.h>
+
+#include "enocean_esp.h"
+
+/* G(x) = x^8 + x^2 + x^1 + x^0 */
+#define ESP3_CRC8_POLY_MSB 0x07
+
+DECLARE_CRC8_TABLE(enocean_esp3_crc8_table);
+
+void enocean_esp3_crc8_populate(void)
+{
+	crc8_populate_msb(enocean_esp3_crc8_table, ESP3_CRC8_POLY_MSB);
+}
+
+static inline u8 enocean_esp3_crc8(u8 *pdata, size_t nbytes)
+{
+	return crc8(enocean_esp3_crc8_table, pdata, nbytes, 0x00);
+}
+
+#define ESP3_SYNC_WORD 0x55
+
+struct enocean_esp3_dispatcher {
+	struct list_head list;
+	u8 packet_type;
+	void (*dispatch)(const u8 *data, u16 data_len, struct enocean_esp3_dispatcher *d);
+};
+
+static void enocean_add_esp3_dispatcher(struct enocean_device *edev,
+	struct enocean_esp3_dispatcher *entry)
+{
+	list_add_tail_rcu(&entry->list, &edev->esp_dispatchers);
+}
+
+static void enocean_remove_esp3_dispatcher(struct enocean_device *edev,
+	struct enocean_esp3_dispatcher *entry)
+{
+	list_del_rcu(&entry->list);
+}
+
+struct enocean_esp3_response {
+	struct enocean_esp3_dispatcher disp;
+
+	u8 code;
+	void *data;
+	u16 data_len;
+
+	struct completion comp;
+};
+
+static void enocean_esp3_response_dispatch(const u8 *data, u16 data_len,
+	struct enocean_esp3_dispatcher *d)
+{
+	struct enocean_esp3_response *resp =
+		container_of(d, struct enocean_esp3_response, disp);
+
+	if (completion_done(&resp->comp))
+		return;
+
+	if (data_len < 1)
+		return;
+
+	resp->code = data[0];
+	if (data_len > 1) {
+		resp->data = kzalloc(data_len - 1, GFP_KERNEL);
+		if (resp->data)
+			memcpy(resp->data, data + 1, data_len - 1);
+		resp->data_len = data_len - 1;
+	} else {
+		resp->data = NULL;
+		resp->data_len = 0;
+	}
+
+	complete(&resp->comp);
+}
+
+struct enocean_esp3_priv {
+	struct enocean_device *edev;
+	struct enocean_esp3_dispatcher radio_erp1_response;
+};
+
+static inline int enocean_esp3_packet_size(u16 data_len, u8 optional_len)
+{
+	return 1 + 4 + 1 + data_len + optional_len + 1;
+}
+
+static int enocean_send_esp3_packet(struct enocean_device *edev, u8 packet_type,
+	const void *data, u16 data_len, const void *optional_data, u8 optional_len,
+	unsigned long timeout)
+{
+	int len = enocean_esp3_packet_size(data_len, optional_len);
+	u8 *buf;
+	int ret;
+
+	buf = kzalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] = ESP3_SYNC_WORD;
+	put_unaligned_be16(data_len, buf + 1);
+	buf[3] = optional_len;
+	buf[4] = packet_type;
+	buf[5] = enocean_esp3_crc8(buf + 1, 4);
+	dev_dbg(&edev->serdev->dev, "CRC8H = %02x\n", (unsigned int)buf[5]);
+	memcpy(buf + 6, data, data_len);
+	memcpy(buf + 6 + data_len, optional_data, optional_len);
+	buf[6 + data_len + optional_len] = enocean_esp3_crc8(buf + 6, data_len + optional_len);
+	dev_dbg(&edev->serdev->dev, "CRC8D = %02x\n", (unsigned int)buf[6 + data_len + optional_len]);
+
+	ret = serdev_device_write(edev->serdev, buf, len, timeout);
+
+	kfree(buf);
+
+	if (ret < 0)
+		return ret;
+	if (ret > 0 && ret < len)
+		return -EIO;
+	return 0;
+}
+
+#define ESP3_RADIO_ERP1		0x1
+#define ESP3_RESPONSE		0x2
+#define ESP3_COMMON_COMMAND	0x5
+
+static void enocean_esp3_radio_erp1_response_dispatch(const u8 *data, u16 data_len,
+	struct enocean_esp3_dispatcher *d)
+{
+	struct enocean_esp3_priv *priv = container_of(d, struct enocean_esp3_priv, radio_erp1_response);
+	struct enocean_device *edev = priv->edev;
+	int ret;
+
+	enocean_remove_esp3_dispatcher(edev, d);
+
+	if (data_len < 1)
+		return;
+
+	switch (data[0]) {
+	case 0:
+		enocean_esp_tx_done(edev);
+		break;
+	case 2:
+		ret = -ENOTSUPP;
+		break;
+	case 3:
+		ret = -EINVAL;
+		break;
+	case 5:
+		ret = -EIO;
+		break;
+	default:
+		ret = -EIO;
+		break;
+	}
+}
+
+static int enocean_esp3_send_radio_erp1(struct enocean_device *edev, u32 dest,
+	const u8 *data, int data_len, unsigned long timeout)
+{
+	struct enocean_esp3_priv *priv = edev->priv;
+	struct esp3_radio_erp1_optional {
+		u8 sub_tel_num;
+		__be32 destination_id;
+		u8 dbm;
+		u8 security_level;
+	} __packed opt = {
+		.sub_tel_num = 3,
+		.destination_id = cpu_to_be32(dest),
+		.dbm = 0xff,
+		.security_level = 0,
+	};
+	int ret;
+
+	enocean_add_esp3_dispatcher(edev, &priv->radio_erp1_response);
+
+	ret = enocean_send_esp3_packet(edev, ESP3_RADIO_ERP1, data, data_len, &opt, sizeof(opt), timeout);
+	if (ret) {
+		enocean_remove_esp3_dispatcher(edev, &priv->radio_erp1_response);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int enocean_esp3_reset(struct enocean_device *edev, unsigned long timeout)
+{
+	struct enocean_esp3_response resp;
+	const u8 buf[1] = { 0x02 };
+	int ret;
+
+	init_completion(&resp.comp);
+	resp.disp.packet_type = ESP3_RESPONSE;
+	resp.disp.dispatch = enocean_esp3_response_dispatch;
+	enocean_add_esp3_dispatcher(edev, &resp.disp);
+
+	ret = enocean_send_esp3_packet(edev, ESP3_COMMON_COMMAND, buf, sizeof(buf), NULL, 0, timeout);
+	if (ret) {
+		enocean_remove_esp3_dispatcher(edev, &resp.disp);
+		return ret;
+	}
+
+	timeout = wait_for_completion_timeout(&resp.comp, timeout);
+	enocean_remove_esp3_dispatcher(edev, &resp.disp);
+	if (!timeout)
+		return -ETIMEDOUT;
+
+	switch (resp.code) {
+	case 0:
+		return 0;
+	case 1:
+		return -EIO;
+	case 2:
+		return -ENOTSUPP;
+	default:
+		return -EIO;
+	}
+}
+
+struct enocean_esp3_version {
+	u8 app_version[4];
+	u8 api_version[4];
+	__be32 chip_id;
+	__be32 chip_version;
+	char app_desc[16];
+} __packed;
+
+static int enocean_esp3_read_version(struct enocean_device *edev, unsigned long timeout)
+{
+	struct enocean_esp3_response resp;
+	struct enocean_esp3_version *ver;
+	const u8 buf[1] = { 0x03 };
+	int ret;
+
+	init_completion(&resp.comp);
+	resp.disp.packet_type = ESP3_RESPONSE;
+	resp.disp.dispatch = enocean_esp3_response_dispatch;
+	enocean_add_esp3_dispatcher(edev, &resp.disp);
+
+	ret = enocean_send_esp3_packet(edev, ESP3_COMMON_COMMAND, buf, sizeof(buf), NULL, 0, timeout);
+	if (ret) {
+		enocean_remove_esp3_dispatcher(edev, &resp.disp);
+		return ret;
+	}
+
+	timeout = wait_for_completion_timeout(&resp.comp, timeout);
+	enocean_remove_esp3_dispatcher(edev, &resp.disp);
+	if (!timeout)
+		return -ETIMEDOUT;
+
+	switch (resp.code) {
+	case 0:
+		if (!resp.data)
+			return -ENOMEM;
+		break;
+	case 2:
+		if (resp.data)
+			kfree(resp.data);
+		return -ENOTSUPP;
+	default:
+		if (resp.data)
+			kfree(resp.data);
+		return -EIO;
+	}
+
+	ver = resp.data;
+	ver->app_desc[15] = '\0';
+	dev_info(&edev->serdev->dev, "'%s'\n", ver->app_desc);
+	kfree(resp.data);
+
+	return 0;
+}
+
+static int enocean_esp3_receive_buf(struct serdev_device *sdev, const u8 *data, size_t count)
+{
+	struct enocean_device *edev = serdev_device_get_drvdata(sdev);
+	struct enocean_esp3_dispatcher *e;
+	u8 crc8h, crc8d, optional_len;
+	u16 data_len;
+
+	dev_dbg(&sdev->dev, "Receive (%zu)\n", count);
+
+	if (data[0] != ESP3_SYNC_WORD) {
+		dev_warn(&sdev->dev, "not Sync Word (found 0x%02x), skipping\n",
+			(unsigned int)data[0]);
+		return 1;
+	}
+
+	if (count < 6)
+		return 0;
+
+	crc8h = enocean_esp3_crc8((u8*)data + 1, 4);
+	if (data[5] != crc8h) {
+		dev_warn(&sdev->dev, "invalid CRC8H (expected 0x%02x, found 0x%02x), skipping\n",
+			(unsigned int)crc8h, (unsigned int)data[5]);
+		return 1;
+	}
+
+	data_len = be16_to_cpup((__be16 *)(data + 1));
+	optional_len = data[3];
+	if (count < enocean_esp3_packet_size(data_len, optional_len))
+		return 0;
+
+	crc8d = enocean_esp3_crc8((u8*)data + 6, data_len + optional_len);
+	if (data[6 + data_len + optional_len] != crc8d) {
+		dev_warn(&sdev->dev, "invalid CRC8D (expected 0x%02x, found 0x%02x), skipping\n",
+			(unsigned int)crc8d, (unsigned int)data[6 + data_len + optional_len]);
+		return 1;
+	}
+
+	print_hex_dump_debug("received: ", DUMP_PREFIX_NONE, 16, 1, data,
+		enocean_esp3_packet_size(data_len, optional_len), false);
+
+	list_for_each_entry_rcu(e, &edev->esp_dispatchers, list) {
+		if (e->packet_type == data[4])
+			e->dispatch(data + 6, data_len, e);
+	}
+
+	return enocean_esp3_packet_size(data_len, optional_len);
+}
+
+const struct serdev_device_ops enocean_esp3_serdev_client_ops = {
+	.receive_buf = enocean_esp3_receive_buf,
+	.write_wakeup = serdev_device_write_wakeup,
+};
+
+int enocean_esp3_send(struct enocean_device *edev, u32 dest, const void *data, int data_len)
+{
+	return enocean_esp3_send_radio_erp1(edev, dest, data, data_len, HZ / 10);
+}
+
+int enocean_esp3_init(struct enocean_device *edev)
+{
+	struct enocean_esp3_priv *priv;
+	int ret;
+
+	ret = enocean_esp3_reset(edev, HZ / 10);
+	if (ret)
+		return ret;
+
+	msleep(100); /* XXX */
+
+	ret = enocean_esp3_read_version(edev, HZ / 10);
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->edev = edev;
+	edev->priv = priv;
+
+	priv->radio_erp1_response.packet_type = ESP3_RESPONSE;
+	priv->radio_erp1_response.dispatch = enocean_esp3_radio_erp1_response_dispatch;
+
+	return 0;
+}
+
+void enocean_esp3_cleanup(struct enocean_device *edev)
+{
+	struct enocean_esp3_priv *priv = edev->priv;
+
+	kfree(priv);
+}
-- 
2.16.4
