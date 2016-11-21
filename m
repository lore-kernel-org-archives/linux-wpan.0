Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:47098 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754857AbcKUUeo (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Nov 2016 15:34:44 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 7/8] examples: af_inet6_tx example
Date: Mon, 21 Nov 2016 21:34:20 +0100
Message-Id: <1479760461-18947-8-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1479760461-18947-1-git-send-email-stefan@osg.samsung.com>
References: <1479760461-18947-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>

Simple example to send IPv6 packets over our 6LoWPAN implementation.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 examples/Makefile.am   |  1 +
 examples/af_inet6_tx.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 examples/af_inet6_tx.c

diff --git a/examples/Makefile.am b/examples/Makefile.am
index efc8a44..9759646 100644
--- a/examples/Makefile.am
+++ b/examples/Makefile.am
@@ -2,6 +2,7 @@ bin_PROGRAMS = af_ieee802154_tx \
 	       af_ieee802154_rx \
 	       af_packet_tx \
 	       af_packet_rx \
+	       af_inet6_tx \
 	       af_inet6_rx
 
 EXTRA_DIST = README.examples
diff --git a/examples/af_inet6_tx.c b/examples/af_inet6_tx.c
new file mode 100644
index 0000000..9fe7491
--- /dev/null
+++ b/examples/af_inet6_tx.c
@@ -0,0 +1,75 @@
+/*
+ * AF_INET6 over IEEE 802.15.4 socket example
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
+/* gcc af_inet6_tx.c -o af_inet6_tx */
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <arpa/inet.h>
+#include <net/if.h>
+
+#define IEEE802154_ADDR_LEN 8
+#define MAX_PACKET_LEN 2048
+
+int main(int argc, char *argv[]) {
+	int ret, sd;
+	struct sockaddr_in6 dst;
+	struct ifreq ifr;
+	unsigned char buf[MAX_PACKET_LEN + 1];
+
+	/* Create IPv6 address family socket for the SOCK_DGRAM type */
+	sd = socket(PF_INET6, SOCK_DGRAM, 0);
+	if (sd < 0) {
+		perror("socket");
+		return 1;
+	}
+
+	/* Bind the socket to lowpan0 to make sure we send over it, adapt to your setup */
+	memset(&ifr, 0, sizeof(ifr));
+	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "lowpan0");
+	ret = setsockopt(sd, SOL_SOCKET, SO_BINDTODEVICE, (void *)&ifr, sizeof(ifr));
+	if (ret < 0) {
+		perror("setsockopt");
+		return 1;
+	}
+
+	/* Prepare destination socket address struct */
+	memset(&dst, 0, sizeof(dst));
+	dst.sin6_family = AF_INET6;
+	/* Port within the compressed port range for potential NHC UDP compression */
+	dst.sin6_port = htons(61617);
+	inet_pton(AF_INET6, "ff02::1", &(dst.sin6_addr));
+
+	sprintf(buf, "Hello world from AF_INET6 socket example!");
+
+	/* sendto() is used for implicity in this example, bin()/send() would
+	 * be an alternative */
+	ret = sendto(sd, buf, strlen(buf), 0, (struct sockaddr *)&dst, sizeof(dst));
+	if (ret < 0) {
+		perror("sendto");
+	}
+
+	shutdown(sd, SHUT_RDWR);
+	close(sd);
+	return 0;
+}
-- 
2.5.5

