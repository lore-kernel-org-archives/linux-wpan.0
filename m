Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:53701 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbbFRW1x (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Jun 2015 18:27:53 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 2/3] wpan-ping: unify src and dst address handling
Date: Fri, 19 Jun 2015 00:27:38 +0200
Message-Id: <1434666459-27827-3-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1434666459-27827-1-git-send-email-stefan@osg.samsung.com>
References: <1434666459-27827-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

Instead of having parts of the sockaddr struct parsed and kept in different
places we put it all in the correct struct from the start now. All local
information for the src address are requested over netlink while the dst
address is parsed from the commandline. As the PAN ID has to be the same we
take this also from netlink for dst.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 wpan-ping/wpan-ping.c | 86 +++++++++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 48 deletions(-)

diff --git a/wpan-ping/wpan-ping.c b/wpan-ping/wpan-ping.c
index d3f44f1..5432bfa 100644
--- a/wpan-ping/wpan-ping.c
+++ b/wpan-ping/wpan-ping.c
@@ -86,16 +86,13 @@ static const struct option perf_long_opts[] = {
 struct config {
 	char packet_len;
 	unsigned short packets;
-	uint16_t dst_addr;
-	uint16_t short_addr;
-	uint16_t pan_id;
-	uint8_t dst_extended[IEEE802154_ADDR_LEN];
-	uint8_t src_extended[IEEE802154_ADDR_LEN];
 	bool extended;
 	bool server;
 	char *interface;
 	struct nl_sock *nl_sock;
 	int nl802154_id;
+	struct sockaddr_ieee802154 src;
+	struct sockaddr_ieee802154 dst;
 };
 
 extern char *optarg;
@@ -168,10 +165,17 @@ static int nl_msg_cb(struct nl_msg* msg, void* arg)
 	    || !attrs[NL802154_ATTR_EXTENDED_ADDR])
 		return NL_SKIP;
 
-	conf->short_addr = nla_get_u16(attrs[NL802154_ATTR_SHORT_ADDR]);
-	conf->pan_id = nla_get_u16(attrs[NL802154_ATTR_PAN_ID]);
-	temp = htobe64(nla_get_u64(attrs[NL802154_ATTR_EXTENDED_ADDR]));
-	memcpy(&conf->src_extended, &temp, IEEE802154_ADDR_LEN);
+	conf->src.family = AF_IEEE802154;
+	conf->src.addr.pan_id = conf->dst.addr.pan_id = nla_get_u16(attrs[NL802154_ATTR_PAN_ID]);
+
+	if (!conf->extended) {
+		conf->src.addr.addr_type = IEEE802154_ADDR_SHORT;
+		conf->src.addr.short_addr = nla_get_u16(attrs[NL802154_ATTR_SHORT_ADDR]);
+	} else {
+		conf->src.addr.addr_type = IEEE802154_ADDR_LONG;
+		temp = htobe64(nla_get_u64(attrs[NL802154_ATTR_EXTENDED_ADDR]));
+		memcpy(&conf->src.addr.hwaddr, &temp, IEEE802154_ADDR_LEN);
+	}
 
 	return NL_SKIP;
 }
@@ -238,14 +242,14 @@ static int measure_roundtrip(struct config *conf, int sd) {
 	char addr[24];
 
 	if (conf->extended)
-		print_address(addr, conf->dst_extended);
+		print_address(addr, conf->dst.addr.hwaddr);
 
 	if (conf->extended)
 		fprintf(stdout, "PING %s (PAN ID 0x%04x) %i data bytes\n",
-			addr, conf->pan_id, conf->packet_len);
+			addr, conf->dst.addr.pan_id, conf->packet_len);
 	else
 		fprintf(stdout, "PING 0x%04x (PAN ID 0x%04x) %i data bytes\n",
-			conf->dst_addr, conf->pan_id, conf->packet_len);
+			conf->dst.addr.short_addr, conf->dst.addr.pan_id, conf->packet_len);
 	buf = (unsigned char *)malloc(MAX_PAYLOAD_LEN);
 
 	/* 500ms seconds packet receive timeout */
@@ -293,7 +297,7 @@ static int measure_roundtrip(struct config *conf, int sd) {
 					addr, (int)seq_num, (float)usec/1000);
 			else
 				fprintf(stdout, "%i bytes from 0x%04x seq=%i time=%.1f ms\n", ret,
-					conf->dst_addr, (int)seq_num, (float)usec/1000);
+					conf->dst.addr.short_addr, (int)seq_num, (float)usec/1000);
 		} else
 			fprintf(stderr, "Hit 500 ms packet timeout\n");
 	}
@@ -311,7 +315,7 @@ static int measure_roundtrip(struct config *conf, int sd) {
 	if (conf->extended)
 		fprintf(stdout, "\n--- %s ping statistics ---\n", addr);
 	else
-		fprintf(stdout, "\n--- 0x%04x ping statistics ---\n", conf->dst_addr);
+		fprintf(stdout, "\n--- 0x%04x ping statistics ---\n", conf->dst.addr.short_addr);
 	fprintf(stdout, "%i packets transmitted, %i received, %.0f%% packet loss\n",
 		conf->packets, count, packet_loss);
 	fprintf(stdout, "rtt min/avg/max = %.3f/%.3f/%.3f ms\n", rtt_min, rtt_avg, rtt_max);
@@ -345,7 +349,6 @@ static void init_server(struct config *conf, int sd) {
 static int init_network(struct config *conf) {
 	int sd;
 	int ret;
-	struct sockaddr_ieee802154 a;
 
 	sd = socket(PF_IEEE802154, SOCK_DGRAM, 0);
 	if (sd < 0) {
@@ -353,35 +356,15 @@ static int init_network(struct config *conf) {
 		return 1;
 	}
 
-	get_interface_info(conf);
-
-	a.family = AF_IEEE802154;
-	a.addr.pan_id = conf->pan_id;
-	if (conf->extended)
-		a.addr.addr_type = IEEE802154_ADDR_LONG;
-	else
-		a.addr.addr_type = IEEE802154_ADDR_SHORT;
-
-
 	/* Bind socket on this side */
-	if (conf->extended)
-		memcpy(&a.addr.hwaddr, &conf->src_extended, IEEE802154_ADDR_LEN);
-	else
-		a.addr.short_addr = conf->short_addr;
-
-	ret = bind(sd, (struct sockaddr *)&a, sizeof(a));
+	ret = bind(sd, (struct sockaddr *)&conf->src, sizeof(conf->src));
 	if (ret) {
 		perror("bind");
 		return 1;
 	}
 
 	/* Connect to other side */
-	if (conf->extended)
-		memcpy(&a.addr.hwaddr, &conf->dst_extended, IEEE802154_ADDR_LEN);
-	else
-		a.addr.short_addr = conf->dst_addr;
-
-	ret = connect(sd, (struct sockaddr *)&a, sizeof(a));
+	ret = connect(sd, (struct sockaddr *)&conf->dst, sizeof(conf->dst));
 	if (ret) {
 		perror("connect");
 		return 1;
@@ -389,23 +372,29 @@ static int init_network(struct config *conf) {
 
 	if (conf->server)
 		init_server(conf, sd);
-
-	measure_roundtrip(conf, sd);
+	else
+		measure_roundtrip(conf, sd);
 
 	shutdown(sd, SHUT_RDWR);
 	close(sd);
 	return 0;
 }
 
-static int parse_address(struct config *conf, char *arg)
+static int parse_dst_addr(struct config *conf, char *arg)
 {
 	int i;
 
+	/* PAN ID is filled from netlink in get_interface_info */
+	conf->dst.family = AF_IEEE802154;
+
 	if (!conf->extended) {
-		conf->dst_addr = strtol(arg, NULL, 16);
+		conf->dst.addr.addr_type = IEEE802154_ADDR_SHORT;
+		conf->dst.addr.short_addr = strtol(arg, NULL, 16);
 		return 0;
 	}
 
+	conf->dst.addr.addr_type = IEEE802154_ADDR_LONG;
+
 	for (i = 0; i < IEEE802154_ADDR_LEN; i++) {
 		int temp;
 		char *cp = strchr(arg, ':');
@@ -418,7 +407,7 @@ static int parse_address(struct config *conf, char *arg)
 		if (temp < 0 || temp > 255)
 			return -1;
 
-		conf->dst_extended[i] = temp;
+		conf->dst.addr.hwaddr[i] = temp;
 		if (!cp)
 			break;
 		arg = cp;
@@ -432,9 +421,9 @@ static int parse_address(struct config *conf, char *arg)
 int main(int argc, char *argv[]) {
 	int c;
 	struct config *conf;
-	char *address;
+	char *dst_addr;
 
-	conf = (struct config *) malloc(sizeof(struct config));
+	conf = malloc(sizeof(struct config));
 
 	/* Default to interface wpan0 if nothing else is given */
 	conf->interface = "wpan0";
@@ -461,14 +450,14 @@ int main(int argc, char *argv[]) {
 			break;
 		switch(c) {
 		case 'a':
-			address = optarg;
+			dst_addr = optarg;
 			break;
 		case 'e':
 			conf->extended = true;
 			break;
 		case 'd':
+			dst_addr = optarg;
 			conf->server = true;
-			address = optarg;
 			break;
 		case 'c':
 			conf->packets = atoi(optarg);
@@ -496,11 +485,12 @@ int main(int argc, char *argv[]) {
 		}
 	}
 
-	if (parse_address(conf, address) < 0) {
+	get_interface_info(conf);
+
+	if (parse_dst_addr(conf, dst_addr) < 0) {
 		fprintf(stderr, "Address given in wrong format.\n");
 		return 1;
 	}
-
 	init_network(conf);
 	free(conf);
 	return 0;
-- 
2.4.3

