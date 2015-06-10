Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:47493 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754207AbbFJLSk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 10 Jun 2015 07:18:40 -0400
Received: from authenticated-user (unknown [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by box.christofferholmstedt.se (Postfix) with ESMTPSA id C3C53140D89
	for <linux-wpan@vger.kernel.org>; Wed, 10 Jun 2015 07:18:38 -0400 (EDT)
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: [PATCH v3 wpan-tools 1/3] info: add cca mode descriptive text to output
Date: Wed, 10 Jun 2015 13:18:07 +0200
Message-Id: <1433935089-27119-2-git-send-email-christoffer@christofferholmstedt.se>
In-Reply-To: <1433935089-27119-1-git-send-email-christoffer@christofferholmstedt.se>
References: <20150604092001.GA8027@probook-6560b>
 <1433935089-27119-1-git-send-email-christoffer@christofferholmstedt.se>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Signed-off-by: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
---
 src/info.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 63 insertions(+), 18 deletions(-)

diff --git a/src/info.c b/src/info.c
index 2434bef6a87f..364c02f718aa 100644
--- a/src/info.c
+++ b/src/info.c
@@ -146,6 +146,41 @@ static void print_freq_handler(int channel_page, int channel)
 	}
 }
 
+static char cca_mode_buf[100];
+
+const char *print_cca_mode_handler(enum nl802154_cca_modes cca_mode,
+				   enum nl802154_cca_opts cca_opt)
+{
+	switch (cca_mode) {
+	case NL802154_CCA_ENERGY:
+		return "Energy above threshold";
+	case NL802154_CCA_CARRIER:
+		return "Carrier sense only";
+	case NL802154_CCA_ENERGY_CARRIER:
+		switch (cca_opt) {
+		case NL802154_CCA_OPT_ENERGY_CARRIER_AND:
+			return "Carrier sense with energy above threshold (logical operator is 'and')";
+		case NL802154_CCA_OPT_ENERGY_CARRIER_OR:
+			return "Carrier sense with energy above threshold (logical operator is 'or')";
+		default:
+			sprintf(cca_mode_buf,
+				"Unknown CCA option (%d) for CCA mode (%d)",
+				cca_opt,
+				cca_mode);
+			return cca_mode_buf;
+		}
+	case NL802154_CCA_ALOHA:
+		return "ALOHA";
+	case NL802154_CCA_UWB_SHR:
+		return "UWB preamble sense based on the SHR of a frame";
+	case NL802154_CCA_UWB_MULTIPEXED:
+		return "UWB preamble sense based on the packet with the multiplexed preamble";
+	default:
+		sprintf(cca_mode_buf, "Unknown CCA mode (%d)", cca_mode);
+		return cca_mode_buf;
+	}
+}
+
 static const char *commands[NL802154_CMD_MAX + 1] = {
 	[NL802154_CMD_UNSPEC] = "unspec",
 	[NL802154_CMD_GET_WPAN_PHY] = "get_wpan_phy",
@@ -235,23 +270,13 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 	}
 
 	if (tb_msg[NL802154_ATTR_CCA_MODE]) {
+		enum nl802154_cca_opts cca_opt = 99;
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
+		printf("cca_mode: %s", print_cca_mode_handler(cca_mode, cca_opt));
 		printf("\n");
 	}
 
@@ -361,10 +386,30 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 			printf("\tcca_modes: ");
 			nla_for_each_nested(nl_cca_modes,
 					    tb_caps[NL802154_CAP_ATTR_CCA_MODES],
-					    rem_cca_modes)
-				printf("%d,", nla_type(nl_cca_modes));
+					    rem_cca_modes) {
+				if (nla_type(nl_cca_modes) != NL802154_CCA_ENERGY_CARRIER) {
+					printf("\n\t\t(%d) %s",
+						nla_type(nl_cca_modes),
+						print_cca_mode_handler(nla_type(nl_cca_modes), 0));
+				} else {
+					if (tb_caps[NL802154_CAP_ATTR_CCA_OPTS]) {
+						struct nlattr *nl_cca_opts;
+						int rem_cca_opts;
+
+						nla_for_each_nested(nl_cca_opts,
+								    tb_caps[NL802154_CAP_ATTR_CCA_OPTS],
+								    rem_cca_opts) {
+
+							printf("\n\t\t(%d, cca_opt: %d) %s",
+								nla_type(nl_cca_modes),
+								nla_type(nl_cca_opts),
+								print_cca_mode_handler(nla_type(nl_cca_modes), nla_type(nl_cca_opts)));
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
2.1.4

