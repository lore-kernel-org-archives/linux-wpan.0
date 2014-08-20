Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:42356 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229AbaHTXS0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 Aug 2014 19:18:26 -0400
Received: by mail-wg0-f42.google.com with SMTP id l18so8322501wgh.1
        for <linux-wpan@vger.kernel.org>; Wed, 20 Aug 2014 16:18:25 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 7/8] mac: initial commit for mac pib handling
Date: Thu, 21 Aug 2014 01:17:56 +0200
Message-Id: <1408576677-28149-8-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1408576677-28149-1-git-send-email-alex.aring@gmail.com>
References: <1408576677-28149-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch adds a new mac.c file into src directory. In this
file we should implement all mac pib handling according the
IEEE 802.15.4 standard.

For this initial commit we support setting for the pan id of
an IEEE 802.15.4 interface.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/Makefile.am |  3 ++-
 src/mac.c       | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 src/mac.c

diff --git a/src/Makefile.am b/src/Makefile.am
index ef7e846..b702c91 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -5,7 +5,8 @@ iwpan_SOURCES = \
 	iwpan.c \
 	sections.c \
 	interface.c \
-	phy.c
+	phy.c \
+	mac.c
 
 iwpan_CFLAGS = $(AM_CFLAGS) $(LIBNL3_CFLAGS)
 iwpan_LDADD = $(LIBNL3_LIBS)
diff --git a/src/mac.c b/src/mac.c
new file mode 100644
index 0000000..5fa1111
--- /dev/null
+++ b/src/mac.c
@@ -0,0 +1,40 @@
+#include <net/if.h>
+#include <errno.h>
+#include <string.h>
+#include <stdbool.h>
+
+#include <netlink/genl/genl.h>
+#include <netlink/genl/family.h>
+#include <netlink/genl/ctrl.h>
+#include <netlink/msg.h>
+#include <netlink/attr.h>
+
+#include "nl802154.h"
+#include "iwpan.h"
+
+static int handle_pan_id_set(struct nl802154_state *state,
+			     struct nl_cb *cb,
+			     struct nl_msg *msg,
+			     int argc, char **argv,
+			     enum id_input id)
+{
+	unsigned long pan_id;
+	char *end;
+
+	if (argc < 1)
+		return 1;
+
+	/* PAN ID */
+	pan_id = strtoul(argv[0], &end, 0);
+	if (*end != '\0')
+		return 1;
+
+	NLA_PUT_U16(msg, NL802154_ATTR_PAN_ID, pan_id);
+
+	return 0;
+
+nla_put_failure:
+	return -ENOBUFS;
+}
+COMMAND(set, pan_id, "<pan_id>",
+	NL802154_CMD_SET_PAN_ID, 0, CIB_NETDEV, handle_pan_id_set, NULL);
-- 
2.0.4

