Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:48665 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752874AbdJTKWr (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 20 Oct 2017 06:22:47 -0400
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [RFC 6/7] ipsp: Connect to IPSP PSM
Date: Fri, 20 Oct 2017 13:22:35 +0300
Message-Id: <20171020102236.17499-7-luiz.dentz@gmail.com>
In-Reply-To: <20171020102236.17499-1-luiz.dentz@gmail.com>
References: <20171020102236.17499-1-luiz.dentz@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: patrik.flykt@linux.intel.com, linux-wpan@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case the remote device has IPSP service connect attempt to the IPSP
L2CAP PSM.
---
 profiles/network/ipsp.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 98 insertions(+), 3 deletions(-)

diff --git a/profiles/network/ipsp.c b/profiles/network/ipsp.c
index 2645b0598..28683f4b6 100644
--- a/profiles/network/ipsp.c
+++ b/profiles/network/ipsp.c
@@ -34,6 +34,7 @@
 #include "lib/sdp.h"
 #include "lib/uuid.h"
 
+#include "btio/btio.h"
 #include "src/shared/util.h"
 #include "src/shared/att.h"
 #include "src/shared/queue.h"
@@ -47,6 +48,28 @@
 #include "src/log.h"
 
 #define IPSP_UUID16 0x1820
+#define IPSP_PSM 0x0023
+#define IPSP_MTU 1280
+
+struct ipsp_session {
+	GIOChannel *io;
+	unsigned int id;
+};
+
+static void ipsp_cleanup(struct btd_service *service)
+{
+	struct ipsp_session *session = btd_service_get_user_data(service);
+
+	if (!session)
+		return;
+
+	btd_service_set_user_data(service, NULL);
+
+	if (session->id > 0)
+		g_source_remove(session->id);
+
+	g_io_channel_unref(session->io);
+}
 
 static int ipsp_probe(struct btd_service *service)
 {
@@ -64,6 +87,49 @@ static void ipsp_remove(struct btd_service *service)
 	const char *path = device_get_path(device);
 
 	DBG("path %s", path);
+
+	ipsp_cleanup(service);
+}
+
+static gboolean ipsp_session(GIOChannel *chan, GIOCondition cond,
+				gpointer data)
+{
+	struct btd_service *service = data;
+
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	if (cond & (G_IO_HUP | G_IO_ERR)) {
+		DBG("IPSP session disconnected");
+		ipsp_cleanup(service);
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static void ipsp_connect(GIOChannel *io, GError *err, gpointer user_data)
+{
+	struct btd_service *service = user_data;
+	struct ipsp_session *session = btd_service_get_user_data(service);
+
+	if (err) {
+		DBG("%s", err->message);
+
+		ipsp_cleanup(service);
+
+		btd_service_connecting_complete(service, -EIO);
+		return;
+	}
+
+	session->id = g_io_add_watch(io,
+				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+				(GIOFunc) ipsp_session, service);
+
+	g_io_channel_unref(session->io);
+	session->io = NULL;
+
+	btd_service_connecting_complete(service, 0);
 }
 
 static void foreach_ipsp_service(struct gatt_db_attribute *attr,
@@ -77,12 +143,13 @@ static void foreach_ipsp_service(struct gatt_db_attribute *attr,
 static int ipsp_accept(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
+	struct btd_adapter *adapter = device_get_adapter(device);
 	struct gatt_db *db = btd_device_get_gatt_db(device);
-	const char *path = device_get_path(device);
 	bool found = false;
 	bt_uuid_t ipsp_uuid;
+	struct ipsp_session *session;
 
-	DBG("path %s", path);
+	DBG("path %s", device_get_path(device));
 
 	/* Handle the IPSP services */
 	bt_uuid16_create(&ipsp_uuid, IPSP_UUID16);
@@ -92,7 +159,33 @@ static int ipsp_accept(struct btd_service *service)
 		return -EINVAL;
 	}
 
-	btd_service_connecting_complete(service, 0);
+	session = g_new0(struct ipsp_session, 1);
+	if (!session) {
+		error("Unable to allocate IPSP session");
+		return -ENOMEM;
+	}
+
+	/* Connect L2CAP channel */
+	session->io = bt_io_connect(ipsp_connect, service, NULL, NULL,
+				BT_IO_OPT_SOURCE_BDADDR,
+				btd_adapter_get_address(adapter),
+				BT_IO_OPT_SOURCE_TYPE,
+				btd_adapter_get_address_type(adapter),
+				BT_IO_OPT_DEST_BDADDR,
+				device_get_address(device),
+				BT_IO_OPT_DEST_TYPE,
+				btd_device_get_bdaddr_type(device),
+				BT_IO_OPT_PSM, IPSP_PSM,
+				BT_IO_OPT_IMTU, IPSP_MTU,
+				BT_IO_OPT_INVALID);
+	if (!session->io) {
+		error("Unable create IPSP connection");
+		g_free(session);
+		return -EIO;
+	}
+
+	/* Attach session to the service */
+	btd_service_set_user_data(service, session);
 
 	return 0;
 }
@@ -104,6 +197,8 @@ static int ipsp_disconnect(struct btd_service *service)
 
 	DBG("path %s", path);
 
+	ipsp_cleanup(service);
+
 	btd_service_disconnecting_complete(service, 0);
 
 	return 0;
-- 
2.13.6

