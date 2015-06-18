Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:53414 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356AbbFRIhs (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Jun 2015 04:37:48 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 2/3] wpan-ping: allow usage of extended addressing scheme
Date: Thu, 18 Jun 2015 10:37:35 +0200
Message-Id: <1434616656-16209-2-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1434616656-16209-1-git-send-email-stefan@osg.samsung.com>
References: <1434616656-16209-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

We now support the 64bit extended addresses next to the 16bit short ones.
Default is still short addressing and the -e/--extended option switches to
the extended scheme.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 wpan-ping/wpan-ping.c | 116 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 102 insertions(+), 14 deletions(-)

diff --git a/wpan-ping/wpan-ping.c b/wpan-ping/wpan-ping.c
index d4d0002..4a159ae 100644
--- a/wpan-ping/wpan-ping.c
+++ b/wpan-ping/wpan-ping.c
@@ -31,6 +31,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <getopt.h>
+#include <stdbool.h>
 
 #include <netlink/netlink.h>
 
@@ -72,6 +73,7 @@ struct sockaddr_ieee802154 {
 static const struct option perf_long_opts[] = {
 	{ "daemon", required_argument, NULL, 'd' },
 	{ "address", required_argument, NULL, 'a' },
+	{ "extended", no_argument, NULL, 'e' },
 	{ "count", required_argument, NULL, 'c' },
 	{ "size", required_argument, NULL, 's' },
 	{ "interface", required_argument, NULL, 'i' },
@@ -87,6 +89,9 @@ struct config {
 	uint16_t dst_addr;
 	uint16_t short_addr;
 	uint16_t pan_id;
+	uint8_t dst_extended[IEEE802154_ADDR_LEN];
+	uint8_t src_extended[IEEE802154_ADDR_LEN];
+	bool extended;
 	char server;
 	char *interface;
 	struct nl_sock *nl_sock;
@@ -100,6 +105,7 @@ void usage(const char *name) {
 	"OPTIONS:\n"
 	"--daemon |-d client address\n"
 	"--address | -a server address\n"
+	"--extended | -e use extended addressing scheme 00:11:22:...\n"
 	"--count | -c number of packets\n"
 	"--size | -s packet length\n"
 	"--interface | -i listen on this interface (default wpan0)\n"
@@ -151,18 +157,21 @@ static int nl_msg_cb(struct nl_msg* msg, void* arg)
 	struct sockaddr_nl nla;
 	struct nlmsghdr *nlh = nlmsg_hdr(msg);
 	struct nlattr *attrs[NL802154_ATTR_MAX+1];
+	uint64_t temp;
 
 	struct genlmsghdr *gnlh = (struct genlmsghdr*) nlmsg_data(nlh);
 
 	nla_parse(attrs, NL802154_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
 		  genlmsg_attrlen(gnlh, 0), NULL);
 
-	if (!attrs[NL802154_ATTR_SHORT_ADDR] || !attrs[NL802154_ATTR_PAN_ID])
+	if (!attrs[NL802154_ATTR_SHORT_ADDR] || !attrs[NL802154_ATTR_PAN_ID]
+	    || !attrs[NL802154_ATTR_EXTENDED_ADDR])
 		return NL_SKIP;
 
-	/* We only handle short addresses right now */
 	conf->short_addr = nla_get_u16(attrs[NL802154_ATTR_SHORT_ADDR]);
 	conf->pan_id = nla_get_u16(attrs[NL802154_ATTR_PAN_ID]);
+	temp = htobe64(nla_get_u64(attrs[NL802154_ATTR_EXTENDED_ADDR]));
+	memcpy(&conf->src_extended, &temp, IEEE802154_ADDR_LEN);
 
 	return NL_SKIP;
 }
@@ -207,6 +216,14 @@ static int generate_packet(unsigned char *buf, struct config *conf, unsigned int
 	return 0;
 }
 
+static int print_address(char *addr, uint8_t dst_extended[IEEE802154_ADDR_LEN])
+{
+	snprintf(addr, 24, "%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x", dst_extended[0],
+		dst_extended[1], dst_extended[2], dst_extended[3], dst_extended[4],
+		dst_extended[5], dst_extended[6], dst_extended[7]);
+	return 0;
+}
+
 static int measure_roundtrip(struct config *conf, int sd) {
 	unsigned char *buf;
 	struct timeval start_time, end_time, timeout;
@@ -218,9 +235,17 @@ static int measure_roundtrip(struct config *conf, int sd) {
 	unsigned short seq_num;
 	float rtt_min = 0.0, rtt_avg = 0.0, rtt_max = 0.0;
 	float packet_loss = 100.0;
+	char addr[24];
 
-	fprintf(stdout, "PING 0x%04x (PAN ID 0x%04x) %i data bytes\n",
-		conf->dst_addr, conf->pan_id, conf->packet_len);
+	if (conf->extended)
+		print_address(addr, conf->dst_extended);
+
+	if (conf->extended)
+		fprintf(stdout, "PING %s (PAN ID 0x%04x) %i data bytes\n",
+			addr, conf->pan_id, conf->packet_len);
+	else
+		fprintf(stdout, "PING 0x%04x (PAN ID 0x%04x) %i data bytes\n",
+			conf->dst_addr, conf->pan_id, conf->packet_len);
 	buf = (unsigned char *)malloc(MAX_PAYLOAD_LEN);
 
 	/* 2 seconds packet receive timeout */
@@ -263,8 +288,12 @@ static int measure_roundtrip(struct config *conf, int sd) {
 			if (sec > 0)
 				fprintf(stdout, "Warning: packet return time over a second!\n");
 
-			fprintf(stdout, "%i bytes from 0x%04x seq=%i time=%.1f ms\n", ret,
-				conf->dst_addr, (int)seq_num, (float)usec/1000);
+			if (conf->extended)
+				fprintf(stdout, "%i bytes from %s seq=%i time=%.1f ms\n", ret,
+					addr, (int)seq_num, (float)usec/1000);
+			else
+				fprintf(stdout, "%i bytes from 0x%04x seq=%i time=%.1f ms\n", ret,
+					conf->dst_addr, (int)seq_num, (float)usec/1000);
 		} else
 			fprintf(stderr, "Hit 2s packet timeout\n");
 	}
@@ -279,7 +308,10 @@ static int measure_roundtrip(struct config *conf, int sd) {
 	if (usec_max)
 		rtt_max = (float)usec_max/1000;
 
-	fprintf(stdout, "\n--- 0x%04x ping statistics ---\n", conf->dst_addr);
+	if (conf->extended)
+		fprintf(stdout, "\n--- %s ping statistics ---\n", addr);
+	else
+		fprintf(stdout, "\n--- 0x%04x ping statistics ---\n", conf->dst_addr);
 	fprintf(stdout, "%i packets transmitted, %i received, %.0f%% packet loss\n",
 		conf->packets, count, packet_loss);
 	fprintf(stdout, "rtt min/avg/max = %.3f/%.3f/%.3f ms\n", rtt_min, rtt_avg, rtt_max);
@@ -324,11 +356,19 @@ static int init_network(struct config *conf) {
 	get_interface_info(conf);
 
 	a.family = AF_IEEE802154;
-	a.addr.addr_type = IEEE802154_ADDR_SHORT;
 	a.addr.pan_id = conf->pan_id;
+	if (conf->extended)
+		a.addr.addr_type = IEEE802154_ADDR_LONG;
+	else
+		a.addr.addr_type = IEEE802154_ADDR_SHORT;
+
 
 	/* Bind socket on this side */
-	a.addr.short_addr = conf->short_addr;
+	if (conf->extended)
+		memcpy(&a.addr.hwaddr, &conf->src_extended, IEEE802154_ADDR_LEN);
+	else
+		a.addr.short_addr = conf->short_addr;
+
 	ret = bind(sd, (struct sockaddr *)&a, sizeof(a));
 	if (ret) {
 		perror("bind");
@@ -336,7 +376,11 @@ static int init_network(struct config *conf) {
 	}
 
 	/* Connect to other side */
-	a.addr.short_addr = conf->dst_addr;
+	if (conf->extended)
+		memcpy(&a.addr.hwaddr, &conf->dst_extended, IEEE802154_ADDR_LEN);
+	else
+		a.addr.short_addr = conf->dst_addr;
+
 	ret = connect(sd, (struct sockaddr *)&a, sizeof(a));
 	if (ret) {
 		perror("connect");
@@ -353,9 +397,42 @@ static int init_network(struct config *conf) {
 	return 0;
 }
 
+static int parse_address(struct config *conf, char *arg)
+{
+	int i;
+
+	if (!conf->extended) {
+		conf->dst_addr = strtol(arg, NULL, 16);
+		return 0;
+	}
+
+	for (i = 0; i < IEEE802154_ADDR_LEN; i++) {
+		int temp;
+		char *cp = strchr(arg, ':');
+		if (cp) {
+			*cp = 0;
+			cp++;
+		}
+		if (sscanf(arg, "%x", &temp) != 1)
+			return -1;
+		if (temp < 0 || temp > 255)
+			return -1;
+
+		conf->dst_extended[i] = temp;
+		if (!cp)
+			break;
+		arg = cp;
+	}
+	if (i < IEEE802154_ADDR_LEN - 1)
+		return -1;
+
+	return 0;
+}
+
 int main(int argc, char *argv[]) {
 	int c;
 	struct config *conf;
+	char *address;
 
 	conf = (struct config *) malloc(sizeof(struct config));
 
@@ -365,6 +442,9 @@ int main(int argc, char *argv[]) {
 	/* Deafult to minimum packet size */
 	conf->packet_len = MIN_PAYLOAD_LEN;
 
+	/* Default to short addressing */
+	conf->extended = false;
+
 	if (argc < 2) {
 		usage(argv[0]);
 		exit(1);
@@ -373,19 +453,22 @@ int main(int argc, char *argv[]) {
 	while (1) {
 #ifdef HAVE_GETOPT_LONG
 		int opt_idx = -1;
-		c = getopt_long(argc, argv, "b:a:c:s:i:d:vh", perf_long_opts, &opt_idx);
+		c = getopt_long(argc, argv, "b:a:ec:s:i:d:vh", perf_long_opts, &opt_idx);
 #else
-		c = getopt(argc, argv, "b:a:c:s:i:d:vh");
+		c = getopt(argc, argv, "b:a:ec:s:i:d:vh");
 #endif
 		if (c == -1)
 			break;
 		switch(c) {
 		case 'a':
-			conf->dst_addr = strtol(optarg, NULL, 16);
+			address = optarg;
+			break;
+		case 'e':
+			conf->extended = true;
 			break;
 		case 'd':
 			conf->server = 1;
-			conf->dst_addr = strtol(optarg, NULL, 16);
+			address = optarg;
 			break;
 		case 'c':
 			conf->packets = atoi(optarg);
@@ -413,6 +496,11 @@ int main(int argc, char *argv[]) {
 		}
 	}
 
+	if (parse_address(conf, address) < 0) {
+		fprintf(stderr, "Address given in wrong format.\n");
+		return 1;
+	}
+
 	init_network(conf);
 	free(conf);
 	return 0;
-- 
2.4.3

