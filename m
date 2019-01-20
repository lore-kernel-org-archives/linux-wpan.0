Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38290 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726541AbfATSdt (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Sun, 20 Jan 2019 13:33:49 -0500
From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [RFC net-next] net: Z-Wave driver prototype
Date: Sun, 20 Jan 2019 19:33:15 +0100
Message-Id: <20190120183315.22743-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-lpwan@lists.infradead.org, linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, TL Lim <tllim@pine64.org>, "David S. Miller" <davem@davemloft.net>

Inspired from my LoRa and FSK driver project, I've hacked together a PoC
for an in-kernel Z-Wave driver. Tested with Pine64 Z-Wave module.

The by now SiLabs ZM5304 module exposes a UART interface that this
serdev driver can be attached to, using Device Tree.

There didn't appear to be any schematics for the Pine64 Z-Wave adapter,
so the reset GPIO handling is still missing.

Helpers are implemented for dealing with command, response and respective
checksum-based acknowledgements.

While by now there is extensive public documentation on Command Classes
for individual types of Z-Wave devices, I still couldn't find any proper
documentation of the UART protocol below and relied on a former tutorial
by Henrik Leidecker Jørgensen documenting commands for device discovery.

Tested as external kernel module, so Kconfig/Makefile integration missing.

Some ideas where to take this from here:
1) Try to expose this as a net device and leave node communication to
   userspace via sockets (command/response as skb?) or other means.
2) Make this its own, e.g., drivers/zwave/ subsystem as bus and create
   individual drivers (iio, gpio, led, etc.) for the various node types.
   Optionally, implement a zwave-dev driver for generic userspace access
   to one particular node, similar to spidev.

Note: Z-Wave is based on GFSK modulation, so someone with a lot of time
might implement it based on the FSK drivers being created alongside LoRa.
That speaks against relying on the serial protocol, and it would not work
with any tty based userspace applications.

Cc: TL Lim <tllim@pine64.org>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/net/zwave/Makefile |   1 +
 drivers/net/zwave/zwave.c  | 236 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 237 insertions(+)
 create mode 100644 drivers/net/zwave/Makefile
 create mode 100644 drivers/net/zwave/zwave.c

diff --git a/drivers/net/zwave/Makefile b/drivers/net/zwave/Makefile
new file mode 100644
index 000000000000..1a4171308c79
--- /dev/null
+++ b/drivers/net/zwave/Makefile
@@ -0,0 +1 @@
+obj-m += zwave.o
diff --git a/drivers/net/zwave/zwave.c b/drivers/net/zwave/zwave.c
new file mode 100644
index 000000000000..8ac680bbb969
--- /dev/null
+++ b/drivers/net/zwave/zwave.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Z-Wave
+ *
+ * Copyright (c) 2019 Andreas Färber
+ */
+
+#include <linux/bitops.h>
+#include <linux/completion.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/rculist.h>
+#include <linux/serdev.h>
+
+struct zwave_msg_dispatcher {
+	struct list_head list;
+	u8 id;
+	void (*dispatch)(const u8 *data, u8 len, struct zwave_msg_dispatcher *d);
+};
+
+struct zwave_device {
+	struct serdev_device *serdev;
+
+	struct completion ack_comp;
+	struct list_head msg_dispatchers;
+
+	struct zwave_msg_dispatcher node_list_disp;
+};
+
+static void zwave_add_dispatcher(struct zwave_device *zdev,
+	struct zwave_msg_dispatcher *entry)
+{
+	list_add_tail_rcu(&entry->list, &zdev->msg_dispatchers);
+}
+
+static void zwave_remove_dispatcher(struct zwave_device *zdev,
+	struct zwave_msg_dispatcher *entry)
+{
+	list_del_rcu(&entry->list);
+}
+
+static u8 zwave_msg_checksum_first(const u8 first, const u8 *data, int len)
+{
+	u8 chksum;
+	int i;
+
+	chksum = first;
+	for (i = 0; i < len; i++) {
+		chksum ^= data[i];
+	}
+	return ~chksum;
+}
+
+static u8 zwave_msg_checksum(const u8 *data, int len)
+{
+	return zwave_msg_checksum_first(data[0], data + 1, len - 1);
+}
+
+static int zwave_send_msg(struct zwave_device *zdev, const u8 *data, int data_len,
+	unsigned long timeout)
+{
+	u8 chksum;
+	u8 buf[2];
+	int ret;
+
+	reinit_completion(&zdev->ack_comp);
+
+	buf[0] = 0x01;
+	buf[1] = data_len + 1;
+
+	chksum = zwave_msg_checksum_first(buf[1], data, data_len);
+	dev_dbg(&zdev->serdev->dev, "checksum: 0x%02x\n", (unsigned int)chksum);
+
+	ret = serdev_device_write(zdev->serdev, buf, 2, timeout);
+	if (ret < 0)
+		return ret;
+	if (ret > 0 && ret < 2)
+		return -EIO;
+
+	ret = serdev_device_write(zdev->serdev, data, data_len, timeout);
+	if (ret < 0)
+		return ret;
+	if (ret > 0 && ret < data_len)
+		return -EIO;
+
+	ret = serdev_device_write(zdev->serdev, &chksum, 1, timeout);
+	if (ret < 0)
+		return ret;
+
+	timeout = wait_for_completion_timeout(&zdev->ack_comp, timeout);
+	if (!timeout)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static void zwave_node_list_report(const u8 *data, u8 len,
+	struct zwave_msg_dispatcher *d)
+{
+	struct zwave_device *zdev = container_of(d, struct zwave_device, node_list_disp);
+	struct device *dev = &zdev->serdev->dev;
+	int i, j;
+
+	if (len != 36) {
+		dev_err(dev, "node list report unexpected length (%u)\n", (unsigned int)len);
+		return;
+	};
+
+	dev_info(dev, "node list report\n");
+	for (i = 0; i < data[4]; i++) {
+		u8 tmp = data[5 + i];
+		for (j = 0; j < 8; j++) {
+			if (tmp & BIT(j))
+				dev_info(dev, "node list data %u: node id %u\n", i + 1, i * 8 + j + 1);
+		}
+	}
+}
+
+static int zwave_receive_buf(struct serdev_device *sdev, const u8 *data, size_t count)
+{
+	struct zwave_device *zdev = serdev_device_get_drvdata(sdev);
+	struct zwave_msg_dispatcher *e;
+	u8 buf[1] = { 0x06 };
+	u8 msglen;
+	u8 chksum;
+
+	dev_dbg(&sdev->dev, "Receive (%zu)\n", count);
+
+	if (data[0] == 0x06) {
+		dev_info(&sdev->dev, "ACK received\n");
+		complete(&zdev->ack_comp);
+		return 1;
+	} else {
+		if (count < 2)
+			return 0;
+		msglen = data[1];
+		if (count < 2 + msglen) {
+			dev_dbg(&sdev->dev, "%s: received %zu, expecting %u\n", __func__, count, 2 + (unsigned int)msglen);
+			return 0;
+		}
+		print_hex_dump_bytes("received: ", DUMP_PREFIX_OFFSET, data, 2 + msglen);
+		if (msglen > 0) {
+			chksum = zwave_msg_checksum(data + 1, msglen);
+			if (data[1 + msglen] == chksum) {
+				dev_info(&sdev->dev, "sending ACK\n");
+				serdev_device_write_buf(sdev, buf, 1);
+			} else {
+				dev_warn(&sdev->dev, "checksum mismatch\n");
+				return 2 + msglen;
+			}
+		}
+		list_for_each_entry(e, &zdev->msg_dispatchers, list) {
+			if (msglen > 2 && e->id == data[3])
+				e->dispatch(data + 2, msglen ? msglen - 1 : 0, e);
+		}
+		return 2 + msglen;
+	}
+}
+
+static const struct serdev_device_ops zwave_serdev_client_ops = {
+	.receive_buf = zwave_receive_buf,
+	.write_wakeup = serdev_device_write_wakeup,
+};
+
+static int zwave_probe(struct serdev_device *sdev)
+{
+	struct zwave_device *zdev;
+	int ret;
+	const u8 msg[] = { 0x00, 0x02 };
+	//const u8 msg[] = { 0x00, 0x41, 1 };
+
+	dev_dbg(&sdev->dev, "Probing");
+
+	zdev = devm_kzalloc(&sdev->dev, sizeof(*zdev), GFP_KERNEL);
+	if (!zdev)
+		return -ENOMEM;
+
+	zdev->serdev = sdev;
+	init_completion(&zdev->ack_comp);
+	INIT_LIST_HEAD(&zdev->msg_dispatchers);
+	serdev_device_set_drvdata(sdev, zdev);
+
+	ret = serdev_device_open(sdev);
+	if (ret) {
+		dev_err(&sdev->dev, "Failed to open (%d)\n", ret);
+		return ret;
+	}
+
+	serdev_device_set_baudrate(sdev, 115200);
+	serdev_device_set_flow_control(sdev, false);
+	serdev_device_set_client_ops(sdev, &zwave_serdev_client_ops);
+
+	zdev->node_list_disp.id = 0x02;
+	zdev->node_list_disp.dispatch = zwave_node_list_report;
+	zwave_add_dispatcher(zdev, &zdev->node_list_disp);
+
+	ret = zwave_send_msg(zdev, msg, sizeof(msg), HZ);
+	if (ret) {
+		dev_warn(&sdev->dev, "Failed to send (%d)\n", ret);
+	}
+
+	dev_dbg(&sdev->dev, "Done.\n");
+
+	return 0;
+}
+
+static void zwave_remove(struct serdev_device *sdev)
+{
+	struct zwave_device *zdev = serdev_device_get_drvdata(sdev);
+
+	serdev_device_close(sdev);
+
+	zwave_remove_dispatcher(zdev, &zdev->node_list_disp);
+
+	dev_dbg(&sdev->dev, "Removed\n");
+}
+
+static const struct of_device_id zwave_of_match[] = {
+	{ .compatible = "zwave,zwave" }, /* XXX */
+	{}
+};
+MODULE_DEVICE_TABLE(of, zwave_of_match);
+
+static struct serdev_device_driver zwave_serdev_driver = {
+	.probe = zwave_probe,
+	.remove = zwave_remove,
+	.driver = {
+		.name = "zwave",
+		.of_match_table = zwave_of_match,
+	},
+};
+module_serdev_device_driver(zwave_serdev_driver);
+
+MODULE_DESCRIPTION("Z-Wave serdev driver");
+MODULE_AUTHOR("Andreas Färber <afaerber@suse.de>");
+MODULE_LICENSE("GPL");
-- 
2.16.4
