Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:45645 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751434AbcELAqG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 11 May 2016 20:46:06 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCHv2 wpan-tools 2/2] phy: add netns support
Date: Thu, 12 May 2016 02:45:49 +0200
Message-Id: <1463013949-6028-2-git-send-email-aar@pengutronix.de>
In-Reply-To: <1463013949-6028-1-git-send-email-aar@pengutronix.de>
References: <1463013949-6028-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <aar@pengutronix.de>

This patch adds netns support, basically most parts are copy&pasted from
iw tool, same handling just wpan instead wireless.

Reviewed-by: Stefan Schmidt<stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
changes since v2:
 - add static to handle_netns
 - add Reviewed-by tags

 src/phy.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/src/phy.c b/src/phy.c
index 816bdd8..f97900f 100644
--- a/src/phy.c
+++ b/src/phy.c
@@ -2,6 +2,10 @@
 #include <errno.h>
 #include <string.h>
 #include <stdbool.h>
+#include <sys/param.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 
 #include <netlink/genl/genl.h>
 #include <netlink/genl/family.h>
@@ -144,3 +148,65 @@ nla_put_failure:
 }
 COMMAND(set, cca_ed_level, "<level>",
 	NL802154_CMD_SET_CCA_ED_LEVEL, 0, CIB_PHY, handle_cca_ed_level, NULL);
+
+#ifndef NETNS_RUN_DIR
+#define NETNS_RUN_DIR "/var/run/netns"
+#endif
+static int netns_get_fd(const char *name)
+{
+	char pathbuf[MAXPATHLEN];
+	const char *path, *ptr;
+
+	path = name;
+	ptr = strchr(name, '/');
+	if (!ptr) {
+		snprintf(pathbuf, sizeof(pathbuf), "%s/%s",
+			NETNS_RUN_DIR, name );
+		path = pathbuf;
+	}
+	return open(path, O_RDONLY);
+}
+
+static int handle_netns(struct nl802154_state *state,
+			struct nl_cb *cb,
+			struct nl_msg *msg,
+			int argc, char **argv,
+			enum id_input id)
+{
+	char *end;
+	int fd;
+
+	if (argc < 1 || !*argv[0])
+		return 1;
+
+	if (argc == 1) {
+		NLA_PUT_U32(msg, NL802154_ATTR_PID,
+			    strtoul(argv[0], &end, 10));
+		if (*end != '\0') {
+			printf("Invalid parameter: pid(%s)\n", argv[0]);
+			return 1;
+		}
+		return 0;
+	}
+
+	if (argc != 2 || strcmp(argv[0], "name"))
+		return 1;
+
+	if ((fd = netns_get_fd(argv[1])) >= 0) {
+		NLA_PUT_U32(msg, NL802154_ATTR_NETNS_FD, fd);
+		return 0;
+	} else {
+		printf("Invalid parameter: nsname(%s)\n", argv[0]);
+	}
+
+	return 1;
+
+ nla_put_failure:
+	return -ENOBUFS;
+}
+COMMAND(set, netns, "{ <pid> | name <nsname> }",
+	NL802154_CMD_SET_WPAN_PHY_NETNS, 0, CIB_PHY, handle_netns,
+	"Put this wpan device into a different network namespace:\n"
+	"    <pid>    - change network namespace by process id\n"
+	"    <nsname> - change network namespace by name from "NETNS_RUN_DIR"\n"
+	"               or by absolute path (man ip-netns)\n");
-- 
2.8.2

