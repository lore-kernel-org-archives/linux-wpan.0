Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:53702 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbbFRW1y (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Jun 2015 18:27:54 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 3/3] wpan-ping: use recvfrom and sendto isntead of connecting the socket
Date: Fri, 19 Jun 2015 00:27:39 +0200
Message-Id: <1434666459-27827-4-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1434666459-27827-1-git-send-email-stefan@osg.samsung.com>
References: <1434666459-27827-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

While connecting makes sense when the dst address is known we make our
life easier if we pick the origin address from recvfrom on the server
side. This will eliminate the cumbersome dst parameter on the server
side. A simple ./wpan-ping -d will now respond to different clients.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 wpan-ping/wpan-ping.c | 49 ++++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/wpan-ping/wpan-ping.c b/wpan-ping/wpan-ping.c
index 5432bfa..6607474 100644
--- a/wpan-ping/wpan-ping.c
+++ b/wpan-ping/wpan-ping.c
@@ -71,7 +71,7 @@ struct sockaddr_ieee802154 {
 
 #ifdef HAVE_GETOPT_LONG
 static const struct option perf_long_opts[] = {
-	{ "daemon", required_argument, NULL, 'd' },
+	{ "daemon", no_argument, NULL, 'd' },
 	{ "address", required_argument, NULL, 'a' },
 	{ "extended", no_argument, NULL, 'e' },
 	{ "count", required_argument, NULL, 'c' },
@@ -100,7 +100,7 @@ extern char *optarg;
 void usage(const char *name) {
 	printf("Usage: %s OPTIONS\n"
 	"OPTIONS:\n"
-	"--daemon |-d client address\n"
+	"--daemon |-d\n"
 	"--address | -a server address\n"
 	"--extended | -e use extended addressing scheme 00:11:22:...\n"
 	"--count | -c number of packets\n"
@@ -261,7 +261,10 @@ static int measure_roundtrip(struct config *conf, int sd) {
 	for (i = 0; i < conf->packets; i++) {
 		generate_packet(buf, conf, i);
 		seq_num = (buf[2] << 8)| buf[3];
-		send(sd, buf, conf->packet_len, 0);
+		ret = sendto(sd, buf, conf->packet_len, 0, (struct sockaddr *)&conf->dst, sizeof(conf->dst));
+		if (ret < 0) {
+			perror("sendto");
+		}
 		gettimeofday(&start_time, NULL);
 		ret = recv(sd, buf, conf->packet_len, 0);
 		if (seq_num != ((buf[2] << 8)| buf[3])) {
@@ -327,21 +330,26 @@ static int measure_roundtrip(struct config *conf, int sd) {
 static void init_server(struct config *conf, int sd) {
 	ssize_t len;
 	unsigned char *buf;
-//	struct sockaddr_ieee802154 src;
-//	socklen_t addrlen;
+	struct sockaddr_ieee802154 src;
+	socklen_t addrlen;
 
-//	addrlen = sizeof(src);
+	addrlen = sizeof(src);
 
 	len = 0;
 	fprintf(stdout, "Server mode. Waiting for packets...\n");
 	buf = (unsigned char *)malloc(MAX_PAYLOAD_LEN);
 
 	while (1) {
-		//len = recvfrom(sd, buf, MAX_PAYLOAD_LEN, 0, (struct sockaddr *)&src, &addrlen);
-		len = recv(sd, buf, MAX_PAYLOAD_LEN, 0);
+		len = recvfrom(sd, buf, MAX_PAYLOAD_LEN, 0, (struct sockaddr *)&src, &addrlen);
+		if (len < 0) {
+			perror("recvfrom");
+		}
 		//dump_packet(buf, len);
 		/* Send same packet back */
-		send(sd, buf, len, 0);
+		len = sendto(sd, buf, len, 0, (struct sockaddr *)&src, addrlen);
+		if (len < 0) {
+			perror("sendto");
+		}
 	}
 	free(buf);
 }
@@ -363,13 +371,6 @@ static int init_network(struct config *conf) {
 		return 1;
 	}
 
-	/* Connect to other side */
-	ret = connect(sd, (struct sockaddr *)&conf->dst, sizeof(conf->dst));
-	if (ret) {
-		perror("connect");
-		return 1;
-	}
-
 	if (conf->server)
 		init_server(conf, sd);
 	else
@@ -419,7 +420,7 @@ static int parse_dst_addr(struct config *conf, char *arg)
 }
 
 int main(int argc, char *argv[]) {
-	int c;
+	int c, ret;
 	struct config *conf;
 	char *dst_addr;
 
@@ -442,9 +443,9 @@ int main(int argc, char *argv[]) {
 	while (1) {
 #ifdef HAVE_GETOPT_LONG
 		int opt_idx = -1;
-		c = getopt_long(argc, argv, "b:a:ec:s:i:d:vh", perf_long_opts, &opt_idx);
+		c = getopt_long(argc, argv, "b:a:ec:s:i:dvh", perf_long_opts, &opt_idx);
 #else
-		c = getopt(argc, argv, "b:a:ec:s:i:d:vh");
+		c = getopt(argc, argv, "b:a:ec:s:i:dvh");
 #endif
 		if (c == -1)
 			break;
@@ -456,7 +457,6 @@ int main(int argc, char *argv[]) {
 			conf->extended = true;
 			break;
 		case 'd':
-			dst_addr = optarg;
 			conf->server = true;
 			break;
 		case 'c':
@@ -487,9 +487,12 @@ int main(int argc, char *argv[]) {
 
 	get_interface_info(conf);
 
-	if (parse_dst_addr(conf, dst_addr) < 0) {
-		fprintf(stderr, "Address given in wrong format.\n");
-		return 1;
+	if (!conf->server) {
+		ret = parse_dst_addr(conf, dst_addr);
+		if (ret< 0) {
+			fprintf(stderr, "Address given in wrong format.\n");
+			return 1;
+		}
 	}
 	init_network(conf);
 	free(conf);
-- 
2.4.3

