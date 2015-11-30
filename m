Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:40000 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbbK3LV3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 30 Nov 2015 06:21:29 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 1/4] wpan-ping: hide packet dump behind DEBUG flag
Date: Mon, 30 Nov 2015 12:21:19 +0100
Message-Id: <1448882482-20784-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

This was disabled by default and we are now hiding it behind a more generic
DEBUG flag and keep it off by default.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 wpan-ping/wpan-ping.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/wpan-ping/wpan-ping.c b/wpan-ping/wpan-ping.c
index b454ddb..08211c3 100644
--- a/wpan-ping/wpan-ping.c
+++ b/wpan-ping/wpan-ping.c
@@ -49,6 +49,8 @@
 /* Set the dispatch header to not 6lowpan for compat */
 #define NOT_A_6LOWPAN_FRAME 0x00
 
+#define DEBUG 0
+
 enum {
 	IEEE802154_ADDR_NONE = 0x0,
 	IEEE802154_ADDR_SHORT = 0x2,
@@ -195,6 +197,7 @@ static int get_interface_info(struct config *conf) {
 	return 0;
 }
 
+#if DEBUG
 static void dump_packet(unsigned char *buf, int len) {
 	int i;
 
@@ -204,6 +207,7 @@ static void dump_packet(unsigned char *buf, int len) {
 	}
 	printf("\n");
 }
+#endif
 
 static int generate_packet(unsigned char *buf, struct config *conf, unsigned int seq_num) {
 	int i;
@@ -347,7 +351,9 @@ static void init_server(struct config *conf, int sd) {
 			perror("recvfrom");
 			continue;
 		}
-		//dump_packet(buf, len);
+#if DEBUG
+		dump_packet(buf, len);
+#endif
 		/* Send same packet back */
 		len = sendto(sd, buf, len, 0, (struct sockaddr *)&src, addrlen);
 		if (len < 0) {
-- 
2.4.3

