Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:9199 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751095AbcLUFto (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 21 Dec 2016 00:49:44 -0500
From: wsn.iot.xwq@cn.fujitsu.com
Subject: [PATCH wpan-tools v2] wpan-ping: Add the filtering function for frame receiving
Date: Wed, 21 Dec 2016 05:49:04 +0000
Message-Id: <1482299344-4128-1-git-send-email-wsn.iot.xwq@cn.fujitsu.com>
MIME-Version: 1.0
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: stefan@osg.samsung.com, aar@pengutronix.de, Xue Wenqian <wsn.iot.xwq@cn.fujitsu.com>

From: Xue Wenqian <wsn.iot.xwq@cn.fujitsu.com>

The filtering for wpan-ping client and server is made by checking frame header.

Signed-off-by: Xue Wenqian <wsn.iot.xwq@cn.fujitsu.com>
---
 wpan-ping/wpan-ping.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/wpan-ping/wpan-ping.c b/wpan-ping/wpan-ping.c
index e6df2b4..f825b22 100644
--- a/wpan-ping/wpan-ping.c
+++ b/wpan-ping/wpan-ping.c
@@ -303,6 +303,10 @@ static int measure_roundtrip(struct config *conf, int sd) {
 		}
 		gettimeofday(&start_time, NULL);
 		ret = recv(sd, buf, conf->packet_len, 0);
+		if (buf[0] != NOT_A_6LOWPAN_FRAME) {
+			printf("Non-wpanping packet was received\n");
+			continue;
+		}
 		if (seq_num != ((buf[2] << 8)| buf[3])) {
 			printf("Sequenze number did not match\n");
 			continue;
@@ -386,11 +390,13 @@ static void init_server(int sd) {
 #if DEBUG
 		dump_packet(buf, len);
 #endif
-		/* Send same packet back */
-		len = sendto(sd, buf, len, 0, (struct sockaddr *)&src, addrlen);
-		if (len < 0) {
-			perror("sendto");
-			continue;
+		if (buf[0] == NOT_A_6LOWPAN_FRAME) {
+			/* Send same packet back */
+			len = sendto(sd, buf, len, 0, (struct sockaddr *)&src, addrlen);
+			if (len < 0) {
+				perror("sendto");
+				continue;
+			}
 		}
 	}
 	free(buf);
-- 
1.7.10.4



