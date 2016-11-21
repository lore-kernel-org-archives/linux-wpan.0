Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:47100 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754857AbcKUUen (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Nov 2016 15:34:43 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 6/8] examples: af_packet_tx example
Date: Mon, 21 Nov 2016 21:34:19 +0100
Message-Id: <1479760461-18947-7-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1479760461-18947-1-git-send-email-stefan@osg.samsung.com>
References: <1479760461-18947-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>

The transmit side example for a manually constructed 802.15.4 frame send over
a socket.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 examples/Makefile.am    |   1 +
 examples/af_packet_tx.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)
 create mode 100644 examples/af_packet_tx.c

diff --git a/examples/Makefile.am b/examples/Makefile.am
index 7cd67d9..efc8a44 100644
--- a/examples/Makefile.am
+++ b/examples/Makefile.am
@@ -1,5 +1,6 @@
 bin_PROGRAMS = af_ieee802154_tx \
 	       af_ieee802154_rx \
+	       af_packet_tx \
 	       af_packet_rx \
 	       af_inet6_rx
 
diff --git a/examples/af_packet_tx.c b/examples/af_packet_tx.c
new file mode 100644
index 0000000..82a15f4
--- /dev/null
+++ b/examples/af_packet_tx.c
@@ -0,0 +1,109 @@
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
+/* gcc af_packet_tx.c -o af_packet_tx */
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/ioctl.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+
+#include <net/if.h>
+#include <linux/if_packet.h>
+#include <arpa/inet.h>
+
+#ifndef ETH_P_IEEE802154
+#define ETH_P_IEEE802154 0x00F6
+#endif
+
+#define MAX_PACKET_LEN 127
+
+int main(int argc, char *argv[]) {
+	int ret, sd;
+	ssize_t len;
+	struct sockaddr_ll sll;
+	struct ifreq ifr;
+	unsigned char buf[MAX_PACKET_LEN + 1];
+
+	/* Create AF_PACKET address family socket for the SOCK_RAW type */
+	sd = socket(PF_PACKET, SOCK_RAW, htons(ETH_P_IEEE802154));
+	if (sd < 0) {
+		perror("socket");
+		return 1;
+	}
+
+	/* Using a monitor interface here results in a bad FCS and two missing
+	 * bytes from payload, using the normal IEEE 802.15.4 interface here */
+	strncpy(ifr.ifr_name, "wpan0", IFNAMSIZ);
+	ret = ioctl(sd, SIOCGIFINDEX, &ifr);
+	if (ret < 0) {
+		perror("ioctl");
+		close(sd);
+		return 1;
+	}
+
+	/* Prepare destination socket address struct */
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
+	/* Construct raw packet payload, length and FCS gets added in the kernel */
+	buf[0] = 0x21; /* Frame Control Field */
+	buf[1] = 0xc8; /* Frame Control Field */
+	buf[2] = 0x8b; /* Sequence number */
+	buf[3] = 0xff; /* Destination PAN ID 0xffff */
+	buf[4] = 0xff; /* Destination PAN ID */
+	buf[5] = 0x02; /* Destination short address 0x0002 */
+	buf[6] = 0x00; /* Destination short address */
+	buf[7] = 0x23; /* Source PAN ID 0x0023 */
+	buf[8] = 0x00; /* */
+	buf[9] = 0x60; /* Source extended address ae:c2:4a:1c:21:16:e2:60 */
+	buf[10] = 0xe2; /* */
+	buf[11] = 0x16; /* */
+	buf[12] = 0x21; /* */
+	buf[13] = 0x1c; /* */
+	buf[14] = 0x4a; /* */
+	buf[15] = 0xc2; /* */
+	buf[16] = 0xae; /* */
+	buf[17] = 0xAA; /* Payload */
+	buf[18] = 0xBB; /* */
+	buf[19] = 0xCC; /* */
+
+	/* Send constructed packet over binded interface */
+	len = send(sd, buf, 20, 0);
+	if (len < 0) {
+		perror("send");
+	}
+
+	shutdown(sd, SHUT_RDWR);
+	close(sd);
+	return 0;
+}
-- 
2.5.5

