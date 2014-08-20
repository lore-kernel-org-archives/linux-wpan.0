Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:62637 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbaHTXS0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 Aug 2014 19:18:26 -0400
Received: by mail-wg0-f47.google.com with SMTP id b13so8288709wgh.6
        for <linux-wpan@vger.kernel.org>; Wed, 20 Aug 2014 16:18:24 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 6/8] phy: initial commit for phy pib handling
Date: Thu, 21 Aug 2014 01:17:55 +0200
Message-Id: <1408576677-28149-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1408576677-28149-1-git-send-email-alex.aring@gmail.com>
References: <1408576677-28149-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch adds src/phy.c file. In this file should be the
implement the phy pib handling of the IEEE 802.15.4 standard.

In this patch we add handling to set channel and page according
channel/page number.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/Makefile.am |  3 ++-
 src/phy.c       | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 1 deletion(-)
 create mode 100644 src/phy.c

diff --git a/src/Makefile.am b/src/Makefile.am
index 9b42fc1..ef7e846 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -4,7 +4,8 @@ bin_PROGRAMS = \
 iwpan_SOURCES = \
 	iwpan.c \
 	sections.c \
-	interface.c
+	interface.c \
+	phy.c
 
 iwpan_CFLAGS = $(AM_CFLAGS) $(LIBNL3_CFLAGS)
 iwpan_LDADD = $(LIBNL3_LIBS)
diff --git a/src/phy.c b/src/phy.c
new file mode 100644
index 0000000..33365dd
--- /dev/null
+++ b/src/phy.c
@@ -0,0 +1,67 @@
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
+static int handle_page_set(struct nl802154_state *state,
+			   struct nl_cb *cb,
+			   struct nl_msg *msg,
+			   int argc, char **argv,
+			   enum id_input id)
+{
+	unsigned long page;
+	char *end;
+
+	if (argc < 1)
+		return 1;
+
+	/* PAGE */
+	page = strtoul(argv[0], &end, 10);
+	if (*end != '\0')
+		return 1;
+
+	NLA_PUT_U8(msg, NL802154_ATTR_PAGE, page);
+
+	return 0;
+
+nla_put_failure:
+	return -ENOBUFS;
+}
+COMMAND(set, page, "<page>",
+	NL802154_CMD_SET_PAGE, 0, CIB_PHY, handle_page_set, NULL);
+
+static int handle_channel_set(struct nl802154_state *state,
+			      struct nl_cb *cb,
+			      struct nl_msg *msg,
+			      int argc, char **argv,
+			      enum id_input id)
+{
+	unsigned long channel;
+	char *end;
+
+	if (argc < 1)
+		return 1;
+
+	/* CHANNEL */
+	channel = strtoul(argv[0], &end, 10);
+	if (*end != '\0')
+		return 1;
+
+	NLA_PUT_U8(msg, NL802154_ATTR_CHANNEL, channel);
+
+	return 0;
+
+nla_put_failure:
+	return -ENOBUFS;
+}
+COMMAND(set, channel, "<channel>",
+	NL802154_CMD_SET_CHANNEL, 0, CIB_PHY, handle_channel_set, NULL);
-- 
2.0.4

