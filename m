Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:45899 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751630AbbFBHxV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Jun 2015 03:53:21 -0400
Received: from authenticated-user (unknown [127.0.0.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by box.christofferholmstedt.se (Postfix) with ESMTPSA id 2D7CE140D7F
	for <linux-wpan@vger.kernel.org>; Tue,  2 Jun 2015 03:53:20 -0400 (EDT)
Date: Tue, 2 Jun 2015 09:53:14 +0200
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: [PATCH v2 wpan-tools] info: add frequency to channel listing for phy
 capabilities
Message-ID: <20150602075309.GA5138@probook-6560b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Add the frequency to the channel numbers output when running "iwpan list".
The frequencies listed are according to chapter 8.1.2 in IEEE 802.15.4-2011.
The output now looks like this (fake wpan loopback with all channels
supported):

capabilities:
	iftypes: node
	channels:
		page 0:
			[ 0] 868.3 MHz, [ 1]   906 MHz, [ 2]   908 MHz,
			[ 3]   910 MHz, [ 4]   912 MHz, [ 5]   914 MHz,
			[ 6]   916 MHz, [ 7]   918 MHz, [ 8]   920 MHz,
			[ 9]   922 MHz, [10]   924 MHz, [11]  2405 MHz,
			[12]  2410 MHz, [13]  2415 MHz, [14]  2420 MHz,
			[15]  2425 MHz, [16]  2430 MHz, [17]  2435 MHz,
			[18]  2440 MHz, [19]  2445 MHz, [20]  2450 MHz,
			[21]  2455 MHz, [22]  2460 MHz, [23]  2465 MHz,
			[24]  2470 MHz, [25]  2475 MHz, [26]  2480 MHz
		page 1:
			[ 0] 868.3 MHz, [ 1]   906 MHz, [ 2]   908 MHz,
			[ 3]   910 MHz, [ 4]   912 MHz, [ 5]   914 MHz,
			[ 6]   916 MHz, [ 7]   918 MHz, [ 8]   920 MHz,
			[ 9]   922 MHz, [10]   924 MHz
		page 2:
			[ 0] 868.3 MHz, [ 1]   906 MHz, [ 2]   908 MHz,
			[ 3]   910 MHz, [ 4]   912 MHz, [ 5]   914 MHz,
			[ 6]   916 MHz, [ 7]   918 MHz, [ 8]   920 MHz,
			[ 9]   922 MHz, [10]   924 MHz
		page 3:
			[ 0] 2412 MHz, [ 1] 2417 MHz, [ 2] 2422 MHz,
			[ 3] 2427 MHz, [ 4] 2432 MHz, [ 5] 2437 MHz,
			[ 6] 2442 MHz, [ 7] 2447 MHz, [ 8] 2452 MHz,
			[ 9] 2457 MHz, [10] 2462 MHz, [11] 2467 MHz,
			[12] 2472 MHz, [13] 2484 MHz
		page 4:
			[ 0]  499.2 MHz, [ 1] 3494.4 MHz, [ 2] 3993.6 MHz,
			[ 3] 4492.8 MHz, [ 4] 3993.6 MHz, [ 5] 6489.6 MHz,
			[ 6] 6988.8 MHz, [ 7] 6489.6 MHz, [ 8] 7488.0 MHz,
			[ 9] 7987.2 MHz, [10] 8486.4 MHz, [11] 7987.2 MHz,
			[12] 8985.6 MHz, [13] 9484.8 MHz, [14] 9984.0 MHz,
			[15] 9484.8 MHz
		page 5:
			[ 0] 780 MHz, [ 1] 782 MHz, [ 2] 784 MHz,
			[ 3] 786 MHz, [ 4] 780 MHz, [ 5] 782 MHz,
			[ 6] 784 MHz, [ 7] 786 MHz
		page 6:
			[ 0] 951.2 MHz, [ 1] 951.8 MHz, [ 2] 952.4 MHz,
			[ 3] 953.0 MHz, [ 4] 953.6 MHz, [ 5] 954.2 MHz,
			[ 6] 954.8 MHz, [ 7] 955.4 MHz, [ 8] 954.4 MHz,
			[ 9] 954.6 MHz, [10] 951.1 MHz, [11] 951.5 MHz,
			[12] 951.9 MHz, [13] 952.3 MHz, [14] 952.7 MHz,
			[15] 953.1 MHz, [16] 953.5 MHz, [17] 953.9 MHz,
			[18] 954.3 MHz, [19] 954.7 MHz, [20] 955.1 MHz,
			[21] 955.5 MHz

Signed-off-by: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
---
v1 -> v2:
	* Added comma between each channel listed.
	* Changed alignment so alignment is only within each channel page and
	  not between different channel pages, this makes for a more compact
	  list for some pages.

One can always argue if left or right alignment is the best option but I think
this is good enough for now.

 src/info.c | 141 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 138 insertions(+), 3 deletions(-)

diff --git a/src/info.c b/src/info.c
index 926a63adecce..cd6b2b74172e 100644
--- a/src/info.c
+++ b/src/info.c
@@ -23,6 +23,129 @@ static void print_minmax_handler(int min, int max)
 	printf("\b \n");
 }
 
+static void print_freq_handler(int channel_page, int channel)
+{
+	float freq = 0;
+
+	switch (channel_page) {
+	case 0:
+		if (channel == 0) {
+			freq = 868.3;
+			printf("%5.1f", freq);
+			break;
+		} else if (channel > 0 && channel < 11) {
+			freq = 906 + 2 * (channel - 1);
+		} else {
+			freq = 2405 + 5 * (channel - 11);
+		}
+		printf("%5.0f", freq);
+		break;
+	case 1:
+		if (channel == 0) {
+			freq = 868.3;
+			printf("%5.1f", freq);
+			break;
+		} else if (channel >= 1 && channel <= 10) {
+			freq = 906 + 2 * (channel - 1);
+		}
+		printf("%5.0f", freq);
+		break;
+	case 2:
+		if (channel == 0) {
+			freq = 868.3;
+			printf("%5.1f", freq);
+			break;
+		} else if (channel >= 1 && channel <= 10) {
+			freq = 906 + 2 * (channel - 1);
+		}
+		printf("%5.0f", freq);
+		break;
+	case 3:
+		if (channel >= 0 && channel <= 12) {
+			freq = 2412 + 5 * channel;
+		} else if (channel == 13) {
+			freq = 2484;
+		}
+		printf("%4.0f", freq);
+		break;
+	case 4:
+		switch (channel) {
+		case 0:
+			freq = 499.2;
+			break;
+		case 1:
+			freq = 3494.4;
+			break;
+		case 2:
+			freq = 3993.6;
+			break;
+		case 3:
+			freq = 4492.8;
+			break;
+		case 4:
+			freq = 3993.6;
+			break;
+		case 5:
+			freq = 6489.6;
+			break;
+		case 6:
+			freq = 6988.8;
+			break;
+		case 7:
+			freq = 6489.6;
+			break;
+		case 8:
+			freq = 7488.0;
+			break;
+		case 9:
+			freq = 7987.2;
+			break;
+		case 10:
+			freq = 8486.4;
+			break;
+		case 11:
+			freq = 7987.2;
+			break;
+		case 12:
+			freq = 8985.6;
+			break;
+		case 13:
+			freq = 9484.8;
+			break;
+		case 14:
+			freq = 9984.0;
+			break;
+		case 15:
+			freq = 9484.8;
+			break;
+		}
+		printf("%6.1f", freq);
+		break;
+	case 5:
+		if (channel >= 0 && channel <= 3) {
+			freq = 780 + 2 * channel;
+		} else if (channel >= 4 && channel <= 7) {
+			freq = 780 + 2 * (channel - 4);
+		}
+		printf("%3.0f", freq);
+		break;
+	case 6:
+		if (channel >= 0 && channel <= 7) {
+			freq = 951.2 + 0.6 * channel;
+		} else if (channel >= 8 && channel <= 9) {
+			freq = 954.4 + 0.2 * (channel - 8);
+		} else if (channel >= 10  && channel <= 21) {
+			freq = 951.1 + 0.4 * (channel - 10);
+		}
+
+		printf("%5.1f", freq);
+		break;
+	default:
+		printf("Unknown");
+		break;
+	}
+}
+
 static int print_phy_handler(struct nl_msg *msg, void *arg)
 {
 	struct nlattr *tb_msg[NL802154_ATTR_MAX + 1];
@@ -145,6 +268,7 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 		}
 
 		if (tb_msg[NL802154_CAP_ATTR_CHANNELS]) {
+			int counter = 0;
 			int rem_pages;
 			struct nlattr *nl_pages;
 			printf("\tchannels:\n");
@@ -152,11 +276,22 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 					    rem_pages) {
 				int rem_channels;
 				struct nlattr *nl_channels;
+				counter = 0;
 				printf("\t\tpage %d: ", nla_type(nl_pages));
-				nla_for_each_nested(nl_channels, nl_pages, rem_channels)
-					printf("%d,", nla_type(nl_channels));
+				nla_for_each_nested(nl_channels, nl_pages, rem_channels) {
+					if (counter % 3 == 0) {
+						printf("\n\t\t\t[%2d] ", nla_type(nl_channels));
+						print_freq_handler(nla_type(nl_pages), nla_type(nl_channels));
+						printf(" MHz, ");
+					} else {
+						printf("[%2d] ", nla_type(nl_channels));
+						print_freq_handler(nla_type(nl_pages), nla_type(nl_channels));
+						printf(" MHz, ");
+					}
+					counter++;
+				}
 				/*  TODO hack use sprintf here */
-				printf("\b \b\n");
+				printf("\b\b \b\n");
 			}
 		}
 
-- 
1.9.1


-- 
Christoffer Holmstedt
