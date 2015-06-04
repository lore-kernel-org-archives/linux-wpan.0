Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:46355 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753325AbbFDJUz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Jun 2015 05:20:55 -0400
Received: from authenticated-user (unknown [127.0.0.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by box.christofferholmstedt.se (Postfix) with ESMTPSA id 7BBA4140D8C
	for <linux-wpan@vger.kernel.org>; Thu,  4 Jun 2015 05:20:53 -0400 (EDT)
Date: Thu, 4 Jun 2015 11:20:42 +0200
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: [PATCH wpan-tools 1/2] info: add cca mode descriptive text to output
Message-ID: <20150604092036.GA8041@probook-6560b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Signed-off-by: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
---
 src/info.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 62 insertions(+), 18 deletions(-)

diff --git a/src/info.c b/src/info.c
index 2434bef6a87f..d2e88febd20c 100644
--- a/src/info.c
+++ b/src/info.c
@@ -146,6 +146,41 @@ static void print_freq_handler(int channel_page, int channel)
 	}
 }
 
+static void print_cca_mode_handler(enum nl802154_cca_modes cca_mode,
+				   enum nl802154_cca_opts cca_opt)
+{
+	switch (cca_mode) {
+	case NL802154_CCA_ENERGY:
+		printf("energy above threshold");
+		break;
+	case NL802154_CCA_CARRIER:
+		printf("carrier sense only");
+		break;
+	case NL802154_CCA_ENERGY_CARRIER:
+		printf("carrier sense with energy above threshold");
+		switch (cca_opt) {
+		case NL802154_CCA_OPT_ENERGY_CARRIER_AND:
+			printf(" (logical operator is 'and')");
+			break;
+		case NL802154_CCA_OPT_ENERGY_CARRIER_OR:
+			printf(" (logical operator is 'or')");
+			break;
+		default:
+			printf(" (logical operator is unknown)");
+		}
+		break;
+	case NL802154_CCA_ALOHA:
+		printf("ALOHA");
+		break;
+	case NL802154_CCA_UWB_SHR:
+		printf("UWB preamble sense based on the SHR of a frame");
+		break;
+	case NL802154_CCA_UWB_MULTIPEXED:
+		printf("UWB preamble sense based on the packet with the multiplexed preamble");
+		break;
+	}
+}
+
 static const char *commands[NL802154_CMD_MAX + 1] = {
 	[NL802154_CMD_UNSPEC] = "unspec",
 	[NL802154_CMD_GET_WPAN_PHY] = "get_wpan_phy",
@@ -235,23 +270,14 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 	}
 
 	if (tb_msg[NL802154_ATTR_CCA_MODE]) {
+		enum nl802154_cca_opts cca_opt;
+		if (tb_msg[NL802154_ATTR_CCA_OPT])
+			cca_opt = nla_get_u32(tb_msg[NL802154_ATTR_CCA_OPT]);
+
 		cca_mode = nla_get_u32(tb_msg[NL802154_ATTR_CCA_MODE]);
-		printf("cca_mode: %d", cca_mode);
-		if (cca_mode == NL802154_CCA_ENERGY_CARRIER) {
-			enum nl802154_cca_opts cca_opt;
 
-			cca_opt = nla_get_u32(tb_msg[NL802154_ATTR_CCA_OPT]);
-			switch (cca_opt) {
-			case NL802154_CCA_OPT_ENERGY_CARRIER_AND:
-				printf(" logical and ");
-				break;
-			case NL802154_CCA_OPT_ENERGY_CARRIER_OR:
-				printf(" logical or ");
-				break;
-			default:
-				printf(" logical op mode unkown ");
-			}
-		}
+		printf("cca_mode: %d, ", cca_mode);
+		print_cca_mode_handler(cca_mode, cca_opt);
 		printf("\n");
 	}
 
@@ -361,10 +387,28 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 			printf("\tcca_modes: ");
 			nla_for_each_nested(nl_cca_modes,
 					    tb_caps[NL802154_CAP_ATTR_CCA_MODES],
-					    rem_cca_modes)
-				printf("%d,", nla_type(nl_cca_modes));
+					    rem_cca_modes) {
+				if (nla_type(nl_cca_modes) != NL802154_CCA_ENERGY_CARRIER) {
+					printf("\n\t\t(%d) ", nla_type(nl_cca_modes));
+					print_cca_mode_handler(nla_type(nl_cca_modes), 0);
+				} else {
+					if (tb_caps[NL802154_CAP_ATTR_CCA_OPTS]) {
+						struct nlattr *nl_cca_opts;
+						int rem_cca_opts;
+
+						nla_for_each_nested(nl_cca_opts,
+								    tb_caps[NL802154_CAP_ATTR_CCA_OPTS],
+								    rem_cca_opts) {
+							printf("\n\t\t(%d, ", nla_type(nl_cca_modes));
+							printf("cca_opt: %d) ", nla_type(nl_cca_opts));
+							print_cca_mode_handler(nla_type(nl_cca_modes),
+										nla_type(nl_cca_opts));
+						}
+					}
+				}
+			}
 			/* TODO */
-			printf("\b \n");
+			printf("\n");
 		}
 
 		if (tb_caps[NL802154_CAP_ATTR_CCA_OPTS]) {
-- 
1.9.1


-- 
Christoffer Holmstedt
