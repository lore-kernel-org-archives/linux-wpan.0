Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:54211 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752014AbdJZJah (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 26 Oct 2017 05:30:37 -0400
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v2 7/7] ipsp: Add support for bt_6lo
Date: Thu, 26 Oct 2017 12:30:26 +0300
Message-Id: <20171026093026.27952-8-luiz.dentz@gmail.com>
In-Reply-To: <20171026093026.27952-1-luiz.dentz@gmail.com>
References: <20171026093026.27952-1-luiz.dentz@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: patrik.flykt@linux.intel.com, linux-wpan@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of bt_6lo instance to create interfaces and attach
channels to them.
---
 profiles/network/ipsp.c | 131 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 111 insertions(+), 20 deletions(-)

diff --git a/profiles/network/ipsp.c b/profiles/network/ipsp.c
index 28683f4b6..f6bace956 100644
--- a/profiles/network/ipsp.c
+++ b/profiles/network/ipsp.c
@@ -40,6 +40,7 @@
 #include "src/shared/queue.h"
 #include "src/shared/gatt-db.h"
 #include "src/shared/gatt-client.h"
+#include "src/shared/6lo.h"
 #include "src/plugin.h"
 #include "src/adapter.h"
 #include "src/device.h"
@@ -50,8 +51,12 @@
 #define IPSP_UUID16 0x1820
 #define IPSP_PSM 0x0023
 #define IPSP_MTU 1280
+#define IF_PREFIX "bt"
+
+static struct bt_6lo *lo;
 
 struct ipsp_session {
+	int ifindex;
 	GIOChannel *io;
 	unsigned int id;
 };
@@ -63,36 +68,49 @@ static void ipsp_cleanup(struct btd_service *service)
 	if (!session)
 		return;
 
-	btd_service_set_user_data(service, NULL);
-
-	if (session->id > 0)
+	if (session->id > 0) {
 		g_source_remove(session->id);
+		session->id = 0;
+	}
 
-	g_io_channel_unref(session->io);
+	if (session->io) {
+		g_io_channel_unref(session->io);
+		session->io = NULL;
+	}
 }
 
 static int ipsp_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	const char *path = device_get_path(device);
+	struct ipsp_session *session;
 
 	DBG("path %s", path);
 
+	session = new0(struct ipsp_session, 1);
+
+	/* Attach session to the service */
+	btd_service_set_user_data(service, session);
+
 	return 0;
 }
 
 static void ipsp_remove(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
+	struct ipsp_session *session = btd_service_get_user_data(service);
 	const char *path = device_get_path(device);
 
 	DBG("path %s", path);
 
 	ipsp_cleanup(service);
+
+	btd_service_set_user_data(service, NULL);
+
+	g_free(session);
 }
 
-static gboolean ipsp_session(GIOChannel *chan, GIOCondition cond,
-				gpointer data)
+static gboolean ipsp_hup(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
 	struct btd_service *service = data;
 
@@ -112,19 +130,38 @@ static void ipsp_connect(GIOChannel *io, GError *err, gpointer user_data)
 {
 	struct btd_service *service = user_data;
 	struct ipsp_session *session = btd_service_get_user_data(service);
+	GError *gerr = NULL;
+	bdaddr_t src, dst;
+	int fd;
 
 	if (err) {
 		DBG("%s", err->message);
-
 		ipsp_cleanup(service);
+		btd_service_connecting_complete(service, -EIO);
+		return;
+	}
+
+	bt_io_get(io, &gerr, BT_IO_OPT_SOURCE_BDADDR, &src,
+					BT_IO_OPT_DEST_BDADDR, &dst,
+					BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("bt_io_get: %s", gerr->message);
+		g_error_free(gerr);
+		g_io_channel_unref(io);
+		return;
+	}
+
+	fd = g_io_channel_unix_get_fd(io);
 
+	if (bt_6lo_attach(lo, src.b, fd, dst.b) < 0) {
+		DBG("Unable to attach channel");
+		ipsp_cleanup(service);
 		btd_service_connecting_complete(service, -EIO);
 		return;
 	}
 
-	session->id = g_io_add_watch(io,
-				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-				(GIOFunc) ipsp_session, service);
+	session->id = g_io_add_watch(io, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+					(GIOFunc) ipsp_hup, service);
 
 	g_io_channel_unref(session->io);
 	session->io = NULL;
@@ -144,10 +181,10 @@ static int ipsp_accept(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	struct btd_adapter *adapter = device_get_adapter(device);
+	struct ipsp_session *session = btd_service_get_user_data(service);
 	struct gatt_db *db = btd_device_get_gatt_db(device);
 	bool found = false;
 	bt_uuid_t ipsp_uuid;
-	struct ipsp_session *session;
 
 	DBG("path %s", device_get_path(device));
 
@@ -159,11 +196,8 @@ static int ipsp_accept(struct btd_service *service)
 		return -EINVAL;
 	}
 
-	session = g_new0(struct ipsp_session, 1);
-	if (!session) {
-		error("Unable to allocate IPSP session");
-		return -ENOMEM;
-	}
+	if (session->io)
+		return -EINPROGRESS;
 
 	/* Connect L2CAP channel */
 	session->io = bt_io_connect(ipsp_connect, service, NULL, NULL,
@@ -184,9 +218,6 @@ static int ipsp_accept(struct btd_service *service)
 		return -EIO;
 	}
 
-	/* Attach session to the service */
-	btd_service_set_user_data(service, session);
-
 	return 0;
 }
 
@@ -213,14 +244,74 @@ static struct btd_profile ipsp_profile = {
 	.disconnect	= ipsp_disconnect,
 };
 
+static int net_6lo_probe(struct btd_adapter *adapter)
+{
+	uint16_t index = btd_adapter_get_index(adapter);
+	const bdaddr_t *addr = btd_adapter_get_address(adapter);
+	char *ifname;
+	int err;
+
+	DBG("");
+
+	ifname = g_strdup_printf("%s%u", IF_PREFIX, index);
+
+	err = bt_6lo_add(lo, ifname, addr->b);
+
+	g_free(ifname);
+
+	return err;
+}
+
+static void net_6lo_remove(struct btd_adapter *adapter)
+{
+	const bdaddr_t *addr = btd_adapter_get_address(adapter);
+
+	DBG("");
+
+	bt_6lo_remove(lo, addr->b);
+}
+
+static struct btd_adapter_driver net_6lo_driver = {
+	.name	= "network-6lo",
+	.probe	= net_6lo_probe,
+	.remove	= net_6lo_remove,
+};
+
+static void net_6lo_debug(const char *str, void *user_data)
+{
+	DBG("%s", str);
+}
+
 static int ipsp_init(void)
 {
-	return btd_profile_register(&ipsp_profile);
+	int err;
+
+	lo = bt_6lo_new_default();
+	if (!lo)
+		return -ENOTSUP;
+
+	bt_6lo_set_debug(lo, net_6lo_debug, NULL, NULL);
+
+	err = btd_register_adapter_driver(&net_6lo_driver);
+	if (err < 0) {
+		bt_6lo_unref(lo);
+		return err;
+	}
+
+	err = btd_profile_register(&ipsp_profile);
+	if (err < 0) {
+		btd_unregister_adapter_driver(&net_6lo_driver);
+		bt_6lo_unref(lo);
+	}
+
+	return err;
 }
 
 static void ipsp_exit(void)
 {
 	btd_profile_unregister(&ipsp_profile);
+	btd_unregister_adapter_driver(&net_6lo_driver);
+	bt_6lo_unref(lo);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(ipsp, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
-- 
2.13.6

