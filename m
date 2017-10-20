Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:56466 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752808AbdJTKWq (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 20 Oct 2017 06:22:46 -0400
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [RFC 5/7] build: Add IPSP plugin
Date: Fri, 20 Oct 2017 13:22:34 +0300
Message-Id: <20171020102236.17499-6-luiz.dentz@gmail.com>
In-Reply-To: <20171020102236.17499-1-luiz.dentz@gmail.com>
References: <20171020102236.17499-1-luiz.dentz@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: patrik.flykt@linux.intel.com, linux-wpan@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the initial plugin structure to handle IPSP profile.
---
 Makefile.plugins        |   5 ++
 configure.ac            |   4 ++
 profiles/network/ipsp.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)
 create mode 100644 profiles/network/ipsp.c

diff --git a/Makefile.plugins b/Makefile.plugins
index 73377e532..b5127b697 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -53,6 +53,11 @@ builtin_sources += profiles/network/manager.c \
 			profiles/network/connection.c
 endif
 
+if IPSP
+builtin_modules += ipsp
+builtin_sources += profiles/network/ipsp.c
+endif
+
 if HID
 builtin_modules += input
 builtin_sources += profiles/input/manager.c \
diff --git a/configure.ac b/configure.ac
index 964101412..24489f7d2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -160,6 +160,10 @@ AC_ARG_ENABLE(network, AC_HELP_STRING([--disable-network],
 		[disable network profiles]), [enable_network=${enableval}])
 AM_CONDITIONAL(NETWORK, test "${enable_network}" != "no")
 
+AC_ARG_ENABLE(ipsp, AC_HELP_STRING([--disable-ipsp],
+		[disable ipsp profile]), [enable_ipsp=${enableval}])
+AM_CONDITIONAL(IPSP, test "${enable_ipsp}" != "no")
+
 AC_ARG_ENABLE(hid, AC_HELP_STRING([--disable-hid],
 		[disable HID profile]), [enable_hid=${enableval}])
 AM_CONDITIONAL(HID, test "${enable_hid}" != "no")
diff --git a/profiles/network/ipsp.c b/profiles/network/ipsp.c
new file mode 100644
index 000000000..2645b0598
--- /dev/null
+++ b/profiles/network/ipsp.c
@@ -0,0 +1,132 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2017 Intel Corporation
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
+#include <ctype.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <errno.h>
+
+#include "lib/bluetooth.h"
+#include "lib/hci.h"
+#include "lib/sdp.h"
+#include "lib/uuid.h"
+
+#include "src/shared/util.h"
+#include "src/shared/att.h"
+#include "src/shared/queue.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-client.h"
+#include "src/plugin.h"
+#include "src/adapter.h"
+#include "src/device.h"
+#include "src/profile.h"
+#include "src/service.h"
+#include "src/log.h"
+
+#define IPSP_UUID16 0x1820
+
+static int ipsp_probe(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	const char *path = device_get_path(device);
+
+	DBG("path %s", path);
+
+	return 0;
+}
+
+static void ipsp_remove(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	const char *path = device_get_path(device);
+
+	DBG("path %s", path);
+}
+
+static void foreach_ipsp_service(struct gatt_db_attribute *attr,
+						void *user_data)
+{
+	bool *found = user_data;
+
+	*found = true;
+}
+
+static int ipsp_accept(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct gatt_db *db = btd_device_get_gatt_db(device);
+	const char *path = device_get_path(device);
+	bool found = false;
+	bt_uuid_t ipsp_uuid;
+
+	DBG("path %s", path);
+
+	/* Handle the IPSP services */
+	bt_uuid16_create(&ipsp_uuid, IPSP_UUID16);
+	gatt_db_foreach_service(db, &ipsp_uuid, foreach_ipsp_service, &found);
+	if (!found) {
+		error("IPSP attribute not found");
+		return -EINVAL;
+	}
+
+	btd_service_connecting_complete(service, 0);
+
+	return 0;
+}
+
+static int ipsp_disconnect(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	const char *path = device_get_path(device);
+
+	DBG("path %s", path);
+
+	btd_service_disconnecting_complete(service, 0);
+
+	return 0;
+}
+
+static struct btd_profile ipsp_profile = {
+	.name		= "network-ipsp",
+	.remote_uuid	= IPSP_UUID,
+	.device_probe	= ipsp_probe,
+	.device_remove	= ipsp_remove,
+	.accept		= ipsp_accept,
+	.disconnect	= ipsp_disconnect,
+};
+
+static int ipsp_init(void)
+{
+	return btd_profile_register(&ipsp_profile);
+}
+
+static void ipsp_exit(void)
+{
+	btd_profile_unregister(&ipsp_profile);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(ipsp, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+			ipsp_init, ipsp_exit)
-- 
2.13.6

