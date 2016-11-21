Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:47095 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754751AbcKUUei (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Nov 2016 15:34:38 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 2/8] examples: af_ieee802154_tx example
Date: Mon, 21 Nov 2016 21:34:15 +0100
Message-Id: <1479760461-18947-3-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1479760461-18947-1-git-send-email-stefan@osg.samsung.com>
References: <1479760461-18947-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>

Simple example demonstrating sending plain 802.15.4 frames.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 examples/Makefile.am        |  2 +
 examples/af_ieee802154_tx.c | 95 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 examples/af_ieee802154_tx.c

diff --git a/examples/Makefile.am b/examples/Makefile.am
index 1b6a35e..4ddb3b7 100644
--- a/examples/Makefile.am
+++ b/examples/Makefile.am
@@ -1 +1,3 @@
+bin_PROGRAMS = af_ieee802154_tx
+
 EXTRA_DIST = README.examples
diff --git a/examples/af_ieee802154_tx.c b/examples/af_ieee802154_tx.c
new file mode 100644
index 0000000..e85a109
--- /dev/null
+++ b/examples/af_ieee802154_tx.c
@@ -0,0 +1,95 @@
+/*
+ * IEEE 802.15.4 socket example
+ *
+ * Copyright (C) 2016 Samsung Electronics Co., Ltd.
+ *
+ * Author: Stefan Schmidt <stefan@osg.samsung.com>
+ *
+ * Permission to use, copy, modify, and/or distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+
+/* gcc af_ieee802154_tx.c -o af_ieee802154_tx */
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <string.h>
+
+#define IEEE802154_ADDR_LEN 8
+#define MAX_PACKET_LEN 127
+#define EXTENDED 1
+
+enum {
+	IEEE802154_ADDR_NONE = 0x0,
+	IEEE802154_ADDR_SHORT = 0x2,
+	IEEE802154_ADDR_LONG = 0x3,
+};
+
+struct ieee802154_addr_sa {
+	int addr_type;
+	uint16_t pan_id;
+	union {
+		uint8_t hwaddr[IEEE802154_ADDR_LEN];
+		uint16_t short_addr;
+	};
+};
+
+struct sockaddr_ieee802154 {
+	sa_family_t family;
+	struct ieee802154_addr_sa addr;
+};
+
+int main(int argc, char *argv[]) {
+	int sd;
+	ssize_t len;
+	struct sockaddr_ieee802154 dst;
+	unsigned char buf[MAX_PACKET_LEN + 1];
+	/* IEEE 802.15.4 extended send address, adapt to your setup */
+	uint8_t long_addr[IEEE802154_ADDR_LEN] = {0xd6, 0x55, 0x2c, 0xd6, 0xe4, 0x1c, 0xeb, 0x57};
+
+	/* Create IEEE 802.15.4 address family socket for the SOCK_DGRAM type */
+	sd = socket(PF_IEEE802154, SOCK_DGRAM, 0);
+	if (sd < 0) {
+		perror("socket");
+		return 1;
+	}
+
+	/* Prepare destination socket address struct */
+	memset(&dst, 0, sizeof(dst));
+	dst.family = AF_IEEE802154;
+	/* Used PAN ID is 0x23 here, adapt to your setup */
+	dst.addr.pan_id = 0x0023;
+
+#if EXTENDED /* IEEE 802.15.4 extended address usage */
+	dst.addr.addr_type = IEEE802154_ADDR_LONG;
+	memcpy(&dst.addr.hwaddr, long_addr, IEEE802154_ADDR_LEN);
+#else
+	dst.addr.addr_type = IEEE802154_ADDR_SHORT;
+	dst.addr.short_addr = 0x0002;
+#endif
+
+	sprintf(buf, "Hello world from IEEE 802.15.4 socket example!");
+
+	/* sendto() is used for implicity in this example, bin()/send() would
+	 * be an alternative */
+	len = sendto(sd, buf, strlen(buf), 0, (struct sockaddr *)&dst, sizeof(dst));
+	if (len < 0) {
+		perror("sendto");
+	}
+
+	shutdown(sd, SHUT_RDWR);
+	close(sd);
+	return 0;
+}
-- 
2.5.5

