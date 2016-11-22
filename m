Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:54294 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754303AbcKVCQv (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Nov 2016 21:16:51 -0500
From: wsn.iot.xwq@cn.fujitsu.com
Subject: [PATCH wpan-tools v3] Add the support to set wpan-ping interval
Date: Tue, 22 Nov 2016 02:15:54 +0000
Message-Id: <1479780954-3827-1-git-send-email-wsn.iot.xwq@cn.fujitsu.com>
MIME-Version: 1.0
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Xue Wenqian <wsn.iot.xwq@cn.fujitsu.com>

From: Xue Wenqian <wsn.iot.xwq@cn.fujitsu.com>

This patch adds the support to set wpan-ping interval, you can use the command `-I $interval(ms)` to set the value (default 500ms).

Signed-off-by: Xue Wenqian <wsn.iot.xwq@cn.fujitsu.com>
---
The name problem has been fixed (sorry for my misunderstanding). Also the mentioned curly brace has been changed.

 wpan-ping/wpan-ping.c |   51 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/wpan-ping/wpan-ping.c b/wpan-ping/wpan-ping.c
index 2c63758..e6df2b4 100644
--- a/wpan-ping/wpan-ping.c
+++ b/wpan-ping/wpan-ping.c
@@ -49,6 +49,7 @@
 #define IEEE802154_ADDR_LEN 8
 /* Set the dispatch header to not 6lowpan for compat */
 #define NOT_A_6LOWPAN_FRAME 0x00
+#define DEFAULT_INTERVAL 500
 
 #define DEBUG 0
 
@@ -96,6 +97,7 @@ struct config {
 	int nl802154_id;
 	struct sockaddr_ieee802154 src;
 	struct sockaddr_ieee802154 dst;
+	unsigned short interval;
 };
 
 extern char *optarg;
@@ -109,6 +111,7 @@ static void usage(const char *name) {
 	"--count | -c number of packets\n"
 	"--size | -s packet length\n"
 	"--interface | -i listen on this interface (default wpan0)\n"
+	"--interval | -I wait interval in milliseconds between sending packets (default 500ms)\n"
 	"--version | -v print out version\n"
 	"--help | -h this usage text\n", name);
 }
@@ -232,9 +235,28 @@ static int print_address(char *addr, uint8_t dst_extended[IEEE802154_ADDR_LEN])
 	return 0;
 }
 
+static void sleeping(struct timeval ping_start_time, struct timeval timeout) {
+	struct timeval curr_time;
+	long sec, usec, interval_usec, timeout_usec;
+	long sleep_usec = 0;
+	gettimeofday(&curr_time, NULL);
+	sec = curr_time.tv_sec - ping_start_time.tv_sec;
+	usec = curr_time.tv_usec - ping_start_time.tv_usec;
+	if (usec < 0) {
+		usec += 1000000;
+		sec--;
+	}
+	interval_usec = sec * 1000000 + usec;
+	timeout_usec = timeout.tv_sec * 1000000 + timeout.tv_usec;
+	if (interval_usec < timeout_usec) {
+		sleep_usec = timeout_usec - interval_usec;
+		usleep(sleep_usec);
+	}
+}
+
 static int measure_roundtrip(struct config *conf, int sd) {
 	unsigned char *buf;
-	struct timeval start_time, end_time, timeout;
+	struct timeval ping_start_time, start_time, end_time, timeout;
 	long sec = 0, usec = 0;
 	long sec_max = 0, usec_max = 0;
 	long sec_min = 2147483647, usec_min = 2147483647;
@@ -256,9 +278,15 @@ static int measure_roundtrip(struct config *conf, int sd) {
 			conf->dst.addr.short_addr, conf->dst.addr.pan_id, conf->packet_len);
 	buf = (unsigned char *)malloc(MAX_PAYLOAD_LEN);
 
-	/* 500ms seconds packet receive timeout */
-	timeout.tv_sec = 0;
-	timeout.tv_usec = 500000;
+	/* default 500ms seconds packet receive timeout */
+	if (conf->interval >= 1000) { /* when interval is larger than 1s */
+		double d_interval = (conf->interval * 1.0) / 1000;
+		timeout.tv_sec = (int)d_interval;
+		timeout.tv_usec = (int)((d_interval - timeout.tv_sec) * 1000000);
+	} else {
+		timeout.tv_sec = 0;
+		timeout.tv_usec = conf->interval * 1000;
+	}
 	ret = setsockopt(sd, SOL_SOCKET, SO_RCVTIMEO, (struct timeval *)&timeout,sizeof(struct timeval));
 	if (ret < 0) {
 		perror("setsockopt receive timeout");
@@ -266,6 +294,7 @@ static int measure_roundtrip(struct config *conf, int sd) {
 
 	count = 0;
 	for (i = 0; i < conf->packets; i++) {
+		gettimeofday(&ping_start_time, NULL);
 		generate_packet(buf, conf, i);
 		seq_num = (buf[2] << 8)| buf[3];
 		ret = sendto(sd, buf, conf->packet_len, 0, (struct sockaddr *)&conf->dst, sizeof(conf->dst));
@@ -309,7 +338,9 @@ static int measure_roundtrip(struct config *conf, int sd) {
 				fprintf(stdout, "%i bytes from 0x%04x seq=%i time=%.1f ms\n", ret,
 					conf->dst.addr.short_addr, (int)seq_num, (float)usec/1000);
 		} else
-			fprintf(stderr, "Hit 500 ms packet timeout\n");
+			fprintf(stderr, "Hit %i ms packet timeout\n", conf->interval);
+		/* sleeping */
+		sleeping(ping_start_time, timeout);
 	}
 
 	if (count)
@@ -456,6 +487,9 @@ int main(int argc, char *argv[]) {
 	/* Default to 65535 packets being sent */
 	conf->packets = USHRT_MAX;
 
+	/* Default to 500ms for interval value */
+	conf->interval = DEFAULT_INTERVAL;
+
 	if (argc < 2) {
 		usage(argv[0]);
 		exit(1);
@@ -464,9 +498,9 @@ int main(int argc, char *argv[]) {
 	while (1) {
 #ifdef _GNU_SOURCE
 		int opt_idx = -1;
-		c = getopt_long(argc, argv, "a:ec:s:i:dvh", perf_long_opts, &opt_idx);
+		c = getopt_long(argc, argv, "a:ec:s:i:dvhI:", perf_long_opts, &opt_idx);
 #else
-		c = getopt(argc, argv, "a:ec:s:i:dvh");
+		c = getopt(argc, argv, "a:ec:s:i:dvhI:");
 #endif
 		if (c == -1)
 			break;
@@ -495,6 +529,9 @@ int main(int argc, char *argv[]) {
 		case 'i':
 			conf->interface = optarg;
 			break;
+		case 'I':
+			conf->interval = atoi(optarg);
+			break;
 		case 'v':
 			fprintf(stdout, "wpan-ping " PACKAGE_VERSION "\n");
 			free(conf);
-- 
1.7.10.4



