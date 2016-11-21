Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:47100 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754751AbcKUUel (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Nov 2016 15:34:41 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 4/8] examples: add af_packet_rx example
Date: Mon, 21 Nov 2016 21:34:17 +0100
Message-Id: <1479760461-18947-5-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1479760461-18947-1-git-send-email-stefan@osg.samsung.com>
References: <1479760461-18947-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>

Special use case to get the whole 802.15.4 frame over the socket. Interesting
for network monitoring, packet generation and network stacks in userspace.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 examples/Makefile.am    |  3 +-
 examples/af_packet_rx.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 examples/af_packet_rx.c

diff --git a/examples/Makefile.am b/examples/Makefile.am
index 1ebedf9..2d188a7 100644
--- a/examples/Makefile.am
+++ b/examples/Makefile.am
@@ -1,4 +1,5 @@
 bin_PROGRAMS = af_ieee802154_tx \
-	       af_ieee802154_rx
+	       af_ieee802154_rx \
+	       af_packet_rx
 
 EXTRA_DIST = README.examples
diff --git a/examples/af_packet_rx.c b/examples/af_packet_rx.c
new file mode 100644
index 0000000..9770965
--- /dev/null
+++ b/examples/af_packet_rx.c
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
+/* gcc af_packet_rx.c -o af_packet_rx */
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+
+#include <net/if.h>
+#include <linux/if_packet.h>
+
+#include <arpa/inet.h>
+#include <sys/ioctl.h>
+
+#define IEEE802154_ADDR_LEN 8
+#define MAX_PACKET_LEN 127
+
+#ifndef ETH_P_IEEE802154
+#define ETH_P_IEEE802154 0x00F6
+#endif
+
+int main(int argc, char *argv[]) {
+	int ret, sd, i;
+	ssize_t len;
+	unsigned char buf[MAX_PACKET_LEN + 1];
+	struct sockaddr_ll sll;
+	struct ifreq ifr;
+
+	/* Create AF_PACKET address family socket for the SOCK_RAW type */
+	sd = socket(PF_PACKET, SOCK_RAW, htons(ETH_P_IEEE802154));
+	if (sd < 0) {
+		perror("socket");
+		return 1;
+	}
+
+	/* Get interface index */
+	strncpy(ifr.ifr_name, "monitor0", IFNAMSIZ);
+	ret = ioctl(sd, SIOCGIFINDEX, &ifr);
+	if (ret < 0) {
+		perror("ioctl");
+		close(sd);
+		return 1;
+	}
+
+	/* Prepare source socket address struct */
+	memset(&sll, 0, sizeof(sll));
+	sll.sll_family = AF_PACKET;
+	sll.sll_ifindex = ifr.ifr_ifindex;
+	sll.sll_protocol = htons(ETH_P_IEEE802154);
+
+	/* Bind socket on this side */
+	ret = bind(sd, (struct sockaddr *)&sll, sizeof(sll));
+	if (ret < 0) {
+		perror("bind");
+		close(sd);
+		return 1;
+	}
+
+	while (1) {
+		/* Receive and print the whole packet payload, including FCS */
+		len = recv(sd, buf, MAX_PACKET_LEN, 0);
+		if (len < 0) {
+			perror("recv");
+			continue;
+		}
+		printf("Received:");
+		for (i = 0; i < len; i++)
+			printf(" %x", buf[i]);
+		printf("\n");
+	}
+
+	shutdown(sd, SHUT_RDWR);
+	close(sd);
+	return 0;
+}
-- 
2.5.5

