Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:43162 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752809AbdJTKWo (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 20 Oct 2017 06:22:44 -0400
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [RFC 3/7] unit: Add initial test for bt_6lo
Date: Fri, 20 Oct 2017 13:22:32 +0300
Message-Id: <20171020102236.17499-4-luiz.dentz@gmail.com>
In-Reply-To: <20171020102236.17499-1-luiz.dentz@gmail.com>
References: <20171020102236.17499-1-luiz.dentz@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: patrik.flykt@linux.intel.com, linux-wpan@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 Makefile.am     |   6 ++
 unit/test-6lo.c | 271 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 277 insertions(+)
 create mode 100644 unit/test-6lo.c

diff --git a/Makefile.am b/Makefile.am
index bb5a77408..3ba1a8dab 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -430,6 +430,12 @@ unit_test_midi_LDADD = src/libshared-glib.la \
 			@GLIB_LIBS@ @ALSA_LIBS@
 endif
 
+unit_tests += unit/test-6lo
+
+unit_test_6lo_SOURCES = unit/test-6lo.c
+unit_test_6lo_LDADD = src/libshared-glib.la \
+				lib/libbluetooth-internal.la @GLIB_LIBS@
+
 if MAINTAINER_MODE
 noinst_PROGRAMS += $(unit_tests)
 endif
diff --git a/unit/test-6lo.c b/unit/test-6lo.c
new file mode 100644
index 000000000..77f24e795
--- /dev/null
+++ b/unit/test-6lo.c
@@ -0,0 +1,271 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <inttypes.h>
+#include <string.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/socket.h>
+
+#include <glib.h>
+
+#include "src/shared/6lo.h"
+#include "src/shared/util.h"
+
+#include "src/shared/tester.h"
+
+struct test_pdu {
+	bool valid;
+	const uint8_t *data;
+	size_t size;
+};
+
+struct test_data {
+	char *test_name;
+	struct test_pdu *pdu_list;
+};
+
+struct context {
+	struct bt_6lo *lo;
+	guint source;
+	guint process;
+	int fd;
+	unsigned int pdu_offset;
+	const struct test_data *data;
+};
+
+#define data(args...) ((const unsigned char[]) { args })
+
+#define raw_pdu(args...)					\
+	{							\
+		.valid = true,					\
+		.data = data(args),				\
+		.size = sizeof(data(args)),			\
+	}
+
+#define define_test(name, function, args...)				\
+	do {								\
+		const struct test_pdu pdus[] = {			\
+			args, { }					\
+		};							\
+		static struct test_data data;				\
+		data.test_name = g_strdup(name);			\
+		data.pdu_list = g_memdup(pdus, sizeof(pdus));		\
+		tester_add(name, &data, NULL, function, NULL);		\
+	} while (0)
+
+static const uint8_t src[] = { 0xac, 0x9f, 0xa0, 0xf3, 0x42, 0x42 };
+static const uint8_t dst[] = { 0xac, 0x9f, 0xa0, 0xf3, 0x42, 0x43 };
+
+static void test_debug(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+
+	tester_debug("%s%s\n", prefix, str);
+}
+
+static void test_free(gconstpointer user_data)
+{
+	const struct test_data *data = user_data;
+
+	g_free(data->test_name);
+	g_free(data->pdu_list);
+}
+
+static void destroy_context(struct context *context)
+{
+	if (context->source > 0)
+		g_source_remove(context->source);
+
+	bt_6lo_unref(context->lo);
+
+	test_free(context->data);
+	g_free(context);
+}
+
+static gboolean context_quit(gpointer user_data)
+{
+	struct context *context = user_data;
+
+	if (context == NULL)
+		return FALSE;
+
+	if (context->process > 0)
+		g_source_remove(context->process);
+
+	destroy_context(context);
+	tester_test_passed();
+
+	return FALSE;
+}
+
+static gboolean send_pdu(gpointer user_data)
+{
+	struct context *context = user_data;
+	const struct test_pdu *pdu;
+	ssize_t len;
+
+	pdu = &context->data->pdu_list[context->pdu_offset++];
+
+	len = write(context->fd, pdu->data, pdu->size);
+
+	util_hexdump('<', pdu->data, len, test_debug, "6lo: ");
+
+	g_assert_cmpint(len, ==, pdu->size);
+
+	context->process = 0;
+	return FALSE;
+}
+
+static void context_process(struct context *context)
+{
+	if (!context->data->pdu_list[context->pdu_offset].valid) {
+		context_quit(context);
+		return;
+	}
+
+	context->process = g_idle_add(send_pdu, context);
+}
+
+static gboolean test_handler(GIOChannel *channel, GIOCondition cond,
+							gpointer user_data)
+{
+	struct context *context = user_data;
+	const struct test_pdu *pdu;
+	unsigned char buf[1280];
+	ssize_t len;
+	int fd;
+
+	pdu = &context->data->pdu_list[context->pdu_offset++];
+
+	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
+		context->source = 0;
+		g_print("%s: cond %x\n", __func__, cond);
+		return FALSE;
+	}
+
+	fd = g_io_channel_unix_get_fd(channel);
+
+	len = read(fd, buf, sizeof(buf));
+
+	g_assert(len > 0);
+
+	util_hexdump('>', buf, len, test_debug, "6lo: ");
+
+	g_assert_cmpint(len, ==, pdu->size);
+
+	g_assert(memcmp(buf, pdu->data, pdu->size) == 0);
+
+	context_process(context);
+
+	return TRUE;
+}
+
+static struct context *create_context(gconstpointer data)
+{
+	struct bt_6lo *lo;
+	struct context *context;
+	int err = 0;
+
+	lo = bt_6lo_new_default();
+	if (!lo) {
+		err = -ENOTSUP;
+		goto fail;
+	}
+
+	err = bt_6lo_add(lo, "bt0", src);
+	if (err < 0) {
+		bt_6lo_unref(lo);
+		goto fail;
+	}
+
+	context = g_new0(struct context, 1);
+	context->lo = lo;
+
+	context->data = data;
+
+	return context;
+
+fail:
+	tester_warn("Failed to setup bt_6lo: %s", strerror(-err));
+	return NULL;
+}
+
+static void attach_client(struct context *context)
+{
+	GIOChannel *channel;
+	int err, sv[2];
+
+	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
+	g_assert(err == 0);
+
+	err = bt_6lo_attach(context->lo, src, sv[0], dst);
+	g_assert(err == 0);
+
+	channel = g_io_channel_unix_new(sv[1]);
+
+	g_io_channel_set_close_on_unref(channel, TRUE);
+	g_io_channel_set_encoding(channel, NULL, NULL);
+	g_io_channel_set_buffered(channel, FALSE);
+
+	context->source = g_io_add_watch(channel,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				test_handler, context);
+	g_assert(context->source > 0);
+
+	g_io_channel_unref(channel);
+
+	context->fd = sv[1];
+}
+
+static void test_run(gconstpointer data)
+{
+	struct context *context = create_context(data);
+
+	if (!context) {
+		tester_test_abort();
+		return;
+	}
+
+	if (!g_str_equal(context->data->test_name, "/6lo/init"))
+		attach_client(context);
+
+	context_quit(context);
+}
+
+int main(int argc, char *argv[])
+{
+	tester_init(&argc, &argv);
+
+	define_test("/6lo/init", test_run, raw_pdu());
+	define_test("/6lo/attach", test_run, raw_pdu());
+
+	return tester_run();
+}
-- 
2.13.6

