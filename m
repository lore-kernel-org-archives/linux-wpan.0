Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:54278 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119AbbFENcY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 5 Jun 2015 09:32:24 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 1/3] wpan-ping: Take 6LoWPAN dispatch byte into account
Date: Fri,  5 Jun 2015 15:32:10 +0200
Message-Id: <1433511132-15818-2-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1433511132-15818-1-git-send-email-stefan@osg.samsung.com>
References: <1433511132-15818-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

In rfc4944 section 5.1 a dispatch byte is defined as the first transmitted
byte in the payload. All protocols that want to work in 6LoWPAN networks
without interfering with them should set it to something like 00xxxxxx.

We want to operate in such networks without disturbing them so putting a safe
0x00 here. We might use some of the other bits for flags at some point but do
not need them right now.

And yes, the maximum payload is still increasing by one instead of
decreasing. Earlier versions of this tool had a longer internal header which
resulted in a smaller payload length. That has changed now so we can increase
the payload length by 2 and subtract the dispatch byte to still gain one byte.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 wpan-ping/wpan-ping.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/wpan-ping/wpan-ping.c b/wpan-ping/wpan-ping.c
index dbcc780..0d9da44 100644
--- a/wpan-ping/wpan-ping.c
+++ b/wpan-ping/wpan-ping.c
@@ -43,8 +43,10 @@
 #include "../src/nl802154.h"
 
 #define MIN_PAYLOAD_LEN 5
-#define MAX_PAYLOAD_LEN 115
+#define MAX_PAYLOAD_LEN 116
 #define IEEE802154_ADDR_LEN 8
+/* Set the dispatch header to not 6lowpan for compat */
+#define NOT_A_6LOWPAN_FRAME 0x00
 
 enum {
 	IEEE802154_ADDR_NONE = 0x0,
@@ -194,10 +196,11 @@ static void dump_packet(unsigned char *buf, int len) {
 static int generate_packet(unsigned char *buf, struct config *conf, unsigned int seq_num) {
 	int i;
 
-	buf[0] = conf->packet_len;
-	buf[1] = seq_num >> 8; /* Upper byte */
-	buf[2] = seq_num & 0xFF; /* Lower byte */
-	for (i = 3; i < conf->packet_len; i++) {
+	buf[0] = NOT_A_6LOWPAN_FRAME;
+	buf[1] = conf->packet_len;
+	buf[2] = seq_num >> 8; /* Upper byte */
+	buf[3] = seq_num & 0xFF; /* Lower byte */
+	for (i = 4; i < conf->packet_len; i++) {
 		buf[i] = 0xAB;
 	}
 
@@ -228,11 +231,11 @@ static int measure_roundtrip(struct config *conf, int sd) {
 	count = 0;
 	for (i = 0; i < conf->packets; i++) {
 		generate_packet(buf, conf, i);
-		seq_num = (buf[1] << 8)| buf[2];
+		seq_num = (buf[2] << 8)| buf[3];
 		send(sd, buf, conf->packet_len, 0);
 		gettimeofday(&start_time, NULL);
 		ret = recv(sd, buf, conf->packet_len, 0);
-		if (seq_num != ((buf[1] << 8)| buf[2])) {
+		if (seq_num != ((buf[2] << 8)| buf[3])) {
 			printf("Sequenze number did not match\n");
 			continue;
 		}
-- 
2.1.0

