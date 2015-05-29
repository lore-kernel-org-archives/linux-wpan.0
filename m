Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:45286 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753782AbbE2MYa (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Fri, 29 May 2015 08:24:30 -0400
Received: from authenticated-user (unknown [127.0.0.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by box.christofferholmstedt.se (Postfix) with ESMTPSA id EE439140D7F
	for <linux-wpan@vger.kernel.org>; Fri, 29 May 2015 08:16:14 -0400 (EDT)
Date: Fri, 29 May 2015 12:16:03 +0000
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: [RFC wpan-tools] info: add frequency output to channel listing
Message-ID: <20150529121556.GA7422@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Add the frequency to the channel numbers output when
running "iwpan list". The output now looks like this:

	supported channels:
		page 0:
			[11] 2405 MHz
			[12] 2410 MHz
			[13] 2415 MHz
			[14] 2420 MHz
			[15] 2425 MHz
			[16] 2430 MHz
			[17] 2435 MHz
			[18] 2440 MHz
			[19] 2445 MHz
			[20] 2450 MHz
			[21] 2455 MHz
			[22] 2460 MHz
			[23] 2465 MHz
			[24] 2470 MHz
			[25] 2475 MHz
			[26] 2480 MHz
	current_page: 0
	current_channel: 13 (2415 MHz)

Signed-off-by: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
---
Just added implementation for channel page 0 but wanted to know if I'm on the
right track here. Any feedback concerning visual output and implementation
is appreciated.

 src/info.c |   43 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/src/info.c b/src/info.c
index e8f5dda8da94..86e4dc4e4a14 100644
--- a/src/info.c
+++ b/src/info.c
@@ -23,6 +23,33 @@ static void print_minmax_handler(int min, int max)
 	printf("\b \n");
 }
 
+static void print_freq(int page, int channel)
+{
+	float freq = 0;
+
+	switch (page) {
+	case 0:
+		if (channel == 0) {
+			freq = 868.3;
+			printf("%.1f", freq);
+			break;
+		}
+		else if (channel > 0 && channel < 11) {
+			freq = 906 + 2 * (channel - 1);
+		}
+		else {
+			freq = 2405 + 5 * (channel - 11);
+		}
+		printf("%.0f", freq);
+		break;
+	default:
+		/* Unknown page */
+		break;
+	}
+
+
+}
+
 static int print_phy_handler(struct nl_msg *msg, void *arg)
 {
 	struct nlattr *tb_msg[NL802154_ATTR_MAX + 1];
@@ -54,10 +81,14 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 				    rem_page) {
 			channel = nla_get_u32(nl_page);
 			if (channel) {
-				printf("\tpage %d: ", page, channel);
+				printf("\tpage %d:", page, channel);
 				for (i = 0; i <= 31; i++) {
 					if (channel & 0x1)
-						printf("%d,", i);
+					{
+						printf("\n\t\t[%d] ", i);
+						print_freq(page, i);
+						printf(" MHz ");
+					}
 					channel >>= 1;
 				}
 				/* TODO hack use sprintf here */
@@ -71,7 +102,13 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 		printf("current_page: %d\n", nla_get_u8(tb_msg[NL802154_ATTR_PAGE]));
 
 	if (tb_msg[NL802154_ATTR_CHANNEL])
-		printf("current_channel: %d\n", nla_get_u8(tb_msg[NL802154_ATTR_CHANNEL]));
+	{
+		unsigned char curr_channel;
+		curr_channel = nla_get_u8(tb_msg[NL802154_ATTR_CHANNEL]);
+		printf("current_channel: %d (", curr_channel);
+		print_freq(nla_get_u8(tb_msg[NL802154_ATTR_PAGE]), curr_channel);
+		printf(" MHz)\n");
+	}
 
 	if (tb_msg[NL802154_ATTR_CCA_MODE]) {
 		cca_mode = nla_get_u32(tb_msg[NL802154_ATTR_CCA_MODE]);
-- 
1.7.10.4


-- 
Christoffer Holmstedt
