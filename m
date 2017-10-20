Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:51508 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752874AbdJTKWm (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 20 Oct 2017 06:22:42 -0400
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [RFC 2/7] shared: Add initial code for 6LoWPAN
Date: Fri, 20 Oct 2017 13:22:31 +0300
Message-Id: <20171020102236.17499-3-luiz.dentz@gmail.com>
In-Reply-To: <20171020102236.17499-1-luiz.dentz@gmail.com>
References: <20171020102236.17499-1-luiz.dentz@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: patrik.flykt@linux.intel.com, linux-wpan@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces struct bt_6lo to interface with 6LoWPAN kernel
driver.
---
 Makefile.am      |   2 +-
 src/shared/6lo.c | 493 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/6lo.h |  40 +++++
 3 files changed, 534 insertions(+), 1 deletion(-)
 create mode 100644 src/shared/6lo.c
 create mode 100644 src/shared/6lo.h

diff --git a/Makefile.am b/Makefile.am
index 8faabf44b..bb5a77408 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -119,7 +119,7 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
 			src/shared/gatt-server.h src/shared/gatt-server.c \
 			src/shared/gatt-db.h src/shared/gatt-db.c \
 			src/shared/gap.h src/shared/gap.c \
-			src/shared/tty.h
+			src/shared/tty.h src/shared/6lo.h src/shared/6lo.c
 
 src_libshared_glib_la_SOURCES = $(shared_sources) \
 				src/shared/io-glib.c \
diff --git a/src/shared/6lo.c b/src/shared/6lo.c
new file mode 100644
index 000000000..70f7ec25c
--- /dev/null
+++ b/src/shared/6lo.c
@@ -0,0 +1,493 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <net/if.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <linux/if.h>
+#include <linux/if_arp.h>
+#include <linux/if_tun.h>
+#include <net/ethernet.h>
+#include <arpa/inet.h>
+#include <netinet/ip6.h>
+
+#include "src/shared/io.h"
+#include "src/shared/util.h"
+#include "src/shared/queue.h"
+#include "src/shared/6lo.h"
+
+#define DEV_6LO "/dev/net/tun"
+#define IFF_6LO 0x0040
+#define IFF_6LO_FLAGS IFF_TAP | IFF_6LO | IFF_NO_PI
+#define IFMTU ETHERMTU /* TUN/TAP doesn't seem to allow changing this */
+
+struct bt_6lo_chan {
+	struct bt_6lo_if *iface;
+	struct ether_addr addr;
+	struct io *io;
+};
+
+struct bt_6lo_if {
+	struct bt_6lo *lo;
+	struct ether_addr addr;
+	char name[IFNAMSIZ];
+	unsigned int index;
+	uint8_t buf[IFMTU];
+	struct io *io;
+	struct queue *channels;
+};
+
+struct bt_6lo {
+	int ref_count;
+	int fd;
+	struct queue *ifs;
+
+	bt_6lo_debug_func_t debug_callback;
+	bt_6lo_destroy_func_t debug_destroy;
+	void *debug_data;
+};
+
+static void chan_free(void *data)
+{
+	struct bt_6lo_chan *chan = data;
+
+	io_destroy(chan->io);
+	free(chan);
+}
+
+static void if_free(void *data)
+{
+	struct bt_6lo_if *iface = data;
+
+	queue_destroy(iface->channels, chan_free);
+	io_destroy(iface->io);
+	free(iface);
+}
+
+static void lo_free(struct bt_6lo *lo)
+{
+	if (lo->fd > 0)
+		close(lo->fd);
+
+	queue_destroy(lo->ifs, if_free);
+	free(lo);
+}
+
+struct bt_6lo *bt_6lo_new_default(void)
+{
+	int fd;
+
+	if ((fd = open(DEV_6LO, O_RDWR)) < 0)
+		return NULL;
+
+	return bt_6lo_new(fd);
+}
+
+struct bt_6lo *bt_6lo_new(int fd)
+{
+	struct bt_6lo *lo;
+
+	lo = new0(struct bt_6lo, 1);
+	lo->fd = fd;
+	lo->ifs = queue_new();
+
+	return bt_6lo_ref(lo);
+}
+
+struct bt_6lo *bt_6lo_ref(struct bt_6lo *lo)
+{
+	if (!lo)
+		return NULL;
+
+	__sync_fetch_and_add(&lo->ref_count, 1);
+
+	return lo;
+}
+
+void bt_6lo_unref(struct bt_6lo *lo)
+{
+	if (!lo)
+		return;
+
+	if (__sync_sub_and_fetch(&lo->ref_count, 1))
+		return;
+
+	lo_free(lo);
+}
+
+bool bt_6lo_set_debug(struct bt_6lo *lo, bt_6lo_debug_func_t callback,
+			void *user_data, bt_6lo_destroy_func_t destroy)
+{
+	if (!lo)
+		return false;
+
+	if (lo->debug_destroy)
+		lo->debug_destroy(lo->debug_data);
+
+	lo->debug_callback = callback;
+	lo->debug_destroy = destroy;
+	lo->debug_data = user_data;
+
+	return true;
+}
+
+static inline void memswap(void *dst, const void *src, size_t len)
+{
+	src += len - 1;
+
+	for (; len > 0; len--)
+		*((uint8_t *)dst++) = *((uint8_t *)src--);
+}
+
+static int if_set_mac(struct bt_6lo_if *iface, const uint8_t *addr)
+{
+	struct ifreq ifr = {};
+	int err = 0;
+
+	strcpy(ifr.ifr_name, iface->name);
+	/* TODO: This should be changed to ARPHRD_6LOWPAN */
+	ifr.ifr_hwaddr.sa_family = ARPHRD_ETHER;
+	/* MAC address is big endian */
+	memswap(&ifr.ifr_hwaddr.sa_data, addr, 6);
+
+	if (ioctl(iface->lo->fd, SIOCSIFHWADDR, &ifr) < 0)
+		err = -errno;
+
+	return err;
+}
+
+static bool find_chan(const void *data, const void *match_data)
+{
+	const struct bt_6lo_chan *chan = data;
+	const struct ether_header *mac = match_data;
+
+	return !memcmp(&chan->addr, mac->ether_dhost, sizeof(chan->addr));
+}
+
+static bool if_read(struct io *io, void *user_data)
+{
+	struct bt_6lo_if *iface = user_data;
+	struct ether_header mac = {};
+	struct bt_6lo_chan *chan;
+	struct iovec iov[2];
+	ssize_t ret;
+
+	iov[0].iov_base = &mac;
+	iov[0].iov_len = sizeof(mac);
+
+	iov[1].iov_base = iface->buf;
+	iov[1].iov_len = sizeof(iface->buf);
+
+	ret = io_recv(io, iov, 2);
+	if (ret < 0 || (size_t) ret < sizeof(mac)) {
+		util_debug(iface->lo->debug_callback, iface->lo->debug_data,
+						"iface recv %zd", ret);
+		return true;
+	}
+
+	if (queue_length(iface->channels) == 1) {
+		chan = queue_peek_head(iface->channels);
+		goto done;
+	}
+
+	chan = queue_find(iface->channels, find_chan, &mac);
+	if (!chan) {
+		/* MAC doesn't match any of the existing channels? */
+		return true;
+	}
+
+done:
+	/* Update received length */
+	iov[1].iov_len = ret - sizeof(mac);
+
+	ret = io_send(chan->io, &iov[1], 1);
+	if (ret < 0) {
+		util_debug(iface->lo->debug_callback, iface->lo->debug_data,
+						"chan send %zd", ret);
+		return true;
+	}
+
+	return true;
+}
+
+static bool if_hup(struct io *io, void *user_data)
+{
+	struct bt_6lo_if *iface = user_data;
+
+	util_debug(iface->lo->debug_callback, iface->lo->debug_data,
+			"iface %s disconnected", iface->name);
+
+	queue_remove(iface->lo->ifs, iface);
+	if_free(iface);
+
+	return false;
+}
+
+int bt_6lo_add(struct bt_6lo *lo, const char *name, const uint8_t *addr)
+{
+	struct bt_6lo_if *iface;
+	struct ifreq ifr = {};
+	int err;
+
+	if (!lo)
+		return -EINVAL;
+
+	ifr.ifr_flags = IFF_6LO_FLAGS;
+	strncpy(ifr.ifr_name, name, IFNAMSIZ - 1);
+
+	if (lo->fd == -1) {
+		lo->fd = open(DEV_6LO, O_RDWR);
+		if (lo->fd < 0)
+			return -errno;
+	}
+
+	if (ioctl(lo->fd, TUNSETIFF, &ifr) < 0)
+		return -errno;
+
+	/* read back iff flags to see if IFF_6LO is supported */
+	if (ioctl(lo->fd, TUNGETIFF, &ifr) < 0 || !(ifr.ifr_flags & IFF_6LO))
+		return -ENOTSUP;
+
+	iface = new0(struct bt_6lo_if, 1);
+	iface->lo = lo;
+	memswap(&iface->addr, addr, sizeof(iface->addr));
+	strcpy(iface->name, ifr.ifr_name);
+	iface->index = if_nametoindex(iface->name);
+	iface->channels = queue_new();
+
+	err = if_set_mac(iface, addr);
+	if (err < 0) {
+		if_free(iface);
+		return err;
+	}
+
+	iface->io = io_new(lo->fd);
+	io_set_close_on_destroy(iface->io, true);
+	io_set_read_handler(iface->io, if_read, iface, NULL);
+	io_set_disconnect_handler(iface->io, if_hup, iface, NULL);
+
+	util_debug(iface->lo->debug_callback, iface->lo->debug_data,
+					"iface %s added", iface->name);
+
+	lo->fd = -1;
+
+	queue_push_tail(lo->ifs, iface);
+
+	return 0;
+}
+
+static bool find_if_by_name(const void *data, const void *match_data)
+{
+	const struct bt_6lo_if *iface = data;
+	const char *name = match_data;
+
+	return !strcmp(iface->name, name);
+}
+
+static int if_name(struct bt_6lo *lo, const char *name, struct ifreq *ifr)
+{
+	struct bt_6lo_if *iface;
+
+	iface = queue_find(lo->ifs, find_if_by_name, name);
+	if (!iface)
+		return -ENOENT;
+
+	if_indextoname(iface->index, ifr->ifr_name);
+
+	return 0;
+}
+
+static int if_up(struct bt_6lo *lo, const char *name)
+{
+	struct ifreq ifr = {};
+	int err;
+
+	if (!lo || !name)
+		return -EINVAL;
+
+	err = if_name(lo, name, &ifr);
+	if (err < 0)
+		return err;
+
+	ifr.ifr_flags |= IFF_UP;
+	ifr.ifr_flags |= IFF_RUNNING;
+	ifr.ifr_flags |= IFF_MULTICAST;
+
+	if (ioctl(lo->fd, SIOCSIFFLAGS, &ifr) < 0)
+		return -errno;
+
+	util_debug(lo->debug_callback, lo->debug_data, "iface %s up",
+							ifr.ifr_name);
+
+	return err;
+}
+
+static int if_down(struct bt_6lo *lo, const char *name)
+{
+	struct ifreq ifr = {};
+	int err;
+
+	if (!lo || !name)
+		return -EINVAL;
+
+	err = if_name(lo, name, &ifr);
+	if (err < 0)
+		return err;
+
+	ifr.ifr_flags &= ~IFF_UP;
+
+	if (ioctl(lo->fd, SIOCSIFFLAGS, &ifr) < 0)
+		return -errno;
+
+	util_debug(lo->debug_callback, lo->debug_data, "iface %s down",
+							ifr.ifr_name);
+
+	return err;
+}
+
+static bool find_if_by_addr(const void *data, const void *match_data)
+{
+	const struct bt_6lo_if *iface = data;
+	const uint8_t *addr = match_data;
+	struct ether_addr ifaddr;
+
+	memswap(&ifaddr, addr, sizeof(ifaddr));
+
+	return !memcmp(&iface->addr, &ifaddr, sizeof(iface->addr));
+}
+
+int bt_6lo_remove(struct bt_6lo *lo, const uint8_t *addr)
+{
+	struct bt_6lo_if *iface;
+
+	if (!lo)
+		return -EINVAL;
+
+	iface = queue_remove_if(lo->ifs, find_if_by_addr, (void *) addr);
+	if (!iface)
+		return -ENOENT;
+
+	util_debug(iface->lo->debug_callback, iface->lo->debug_data,
+			"iface %s removed", iface->name);
+
+	if_free(iface);
+
+	return 0;
+}
+
+static bool chan_hup(struct io *io, void *user_data)
+{
+	struct bt_6lo_chan *chan = user_data;
+	struct bt_6lo_if *iface = chan->iface;
+
+	util_debug(iface->lo->debug_callback, iface->lo->debug_data,
+						"chan %p hup", chan);
+
+	queue_remove(iface->channels, chan);
+	chan_free(chan);
+
+	/* Auto down when last IO is detached */
+	if (queue_isempty(iface->channels))
+		if_down(iface->lo, iface->name);
+
+	return false;
+}
+
+static bool chan_read(struct io *io, void *user_data)
+{
+	struct bt_6lo_chan *chan = user_data;
+	struct bt_6lo_if *iface = chan->iface;
+	struct ether_header mac = {};
+	struct iovec iov[2];
+	ssize_t ret;
+
+	iov[1].iov_base = iface->buf;
+	iov[1].iov_len = sizeof(iface->buf);
+
+	ret = io_recv(io, &iov[1], 1);
+	if (ret < 0) {
+		util_debug(iface->lo->debug_callback, iface->lo->debug_data,
+						"chan recv %zd", ret);
+		return true;
+	}
+
+	memcpy(&mac.ether_shost, &chan->addr, sizeof(mac.ether_shost));
+	memcpy(&mac.ether_dhost, &iface->addr, sizeof(mac.ether_dhost));
+
+	iov[0].iov_base = &mac;
+	iov[0].iov_len = sizeof(mac);
+
+	iov[1].iov_len = ret;
+
+	ret = io_send(iface->io, iov, 2);
+	if (ret < 0) {
+		util_debug(iface->lo->debug_callback, iface->lo->debug_data,
+						"iface send %zd", ret);
+		return true;
+	}
+
+	return true;
+}
+
+int bt_6lo_attach(struct bt_6lo *lo, const uint8_t *ifaddr, int fd,
+						const uint8_t *addr)
+{
+	struct bt_6lo_if *iface;
+	struct bt_6lo_chan *chan;
+
+	iface = queue_find(lo->ifs, find_if_by_addr, ifaddr);
+	if (!iface)
+		return -ENOENT;
+
+	chan = new0(struct bt_6lo_chan, 1);
+	chan->iface = iface;
+	memswap(&chan->addr, addr, sizeof(chan->addr));
+	chan->io = io_new(fd);
+	io_set_close_on_destroy(chan->io, true);
+	io_set_read_handler(chan->io, chan_read, chan, NULL);
+	io_set_disconnect_handler(chan->io, chan_hup, chan, NULL);
+
+	/* Auto up when first IO is attached */
+	if (queue_isempty(iface->channels))
+		if_up(lo, iface->name);
+
+	queue_push_tail(iface->channels, chan);
+
+	util_debug(iface->lo->debug_callback, iface->lo->debug_data,
+				"chan %p attached to %s", chan, iface->name);
+
+	return 0;
+}
diff --git a/src/shared/6lo.h b/src/shared/6lo.h
new file mode 100644
index 000000000..4dbe780b2
--- /dev/null
+++ b/src/shared/6lo.h
@@ -0,0 +1,40 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+struct bt_6lo;
+
+struct bt_6lo *bt_6lo_new_default(void);
+struct bt_6lo *bt_6lo_new(int fd);
+
+struct bt_6lo *bt_6lo_ref(struct bt_6lo *lo);
+void bt_6lo_unref(struct bt_6lo *lo);
+
+typedef void (*bt_6lo_destroy_func_t)(void *user_data);
+typedef void (*bt_6lo_debug_func_t)(const char *str, void *user_data);
+bool bt_6lo_set_debug(struct bt_6lo *lo, bt_6lo_debug_func_t callback,
+			void *user_data, bt_6lo_destroy_func_t destroy);
+
+int bt_6lo_add(struct bt_6lo *lo, const char *name, const uint8_t *addr);
+int bt_6lo_remove(struct bt_6lo *lo, const uint8_t *addr);
+
+int bt_6lo_attach(struct bt_6lo *lo, const uint8_t *src, int fd,
+						const uint8_t *dst);
-- 
2.13.6

