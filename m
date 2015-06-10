Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:47546 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964832AbbFJNH6 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 10 Jun 2015 09:07:58 -0400
Received: from authenticated-user (unknown [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by box.christofferholmstedt.se (Postfix) with ESMTPSA id 56FEE140D69
	for <linux-wpan@vger.kernel.org>; Wed, 10 Jun 2015 09:07:56 -0400 (EDT)
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: [PATCH v4 wpan-tools] info: update CCA mode and CCA options output
Date: Wed, 10 Jun 2015 15:07:55 +0200
Message-Id: <1433941675-4629-1-git-send-email-christoffer@christofferholmstedt.se>
In-Reply-To: <20150610121712.GA6647@omega>
References: <20150610121712.GA6647@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Instead of printing out CCA mode and CCA options in integers descriptive
text is now printed to the user when "iwpan list" is run.

Signed-off-by: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
---
I think I got all the changes right now as requested.

Changes v3 -> v4:
* Sent "nl802154: fix misspelled enum" patch separately (already merged).
* Did a "fixup" of remaining two patches so it is only one now.
* Changed "random" value of 99 to NL802154_CCA_OPT_ATTR_MAX.

Changes v2 -> v3:
* Fixed misspelled enum in nl802154

Changes v1 -> v2:
* cca_mode number is removed from "current cca_mode", only text is printed as
an example:

        cca_mode: Energy above threshold
        was
        cca_mode: 1, Energy above threshold

* Changed "enum" to string mapping in print_cca_mode_handler. Instead of
printing out the strings in the function I return a tempbuf that is formatted
by the caller.

* Added default value to cca_opt when printing current cca_mode and cca_opt. It
is set to the "random" value of 99 as the enum only has 2 values, is this a
proper solution? (or should we use limits.h with MAX_INT perhaps?)


 src/info.c | 100 +++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 61 insertions(+), 39 deletions(-)

diff --git a/src/info.c b/src/info.c
index 2434bef6a87f..9b0780df0262 100644
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
+	case NL802154_CCA_UWB_MULTIPLEXED:
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
+		enum nl802154_cca_opts cca_opt = NL802154_CCA_OPT_ATTR_MAX;
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
 
@@ -361,33 +386,30 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 			printf("\tcca_modes: ");
 			nla_for_each_nested(nl_cca_modes,
 					    tb_caps[NL802154_CAP_ATTR_CCA_MODES],
-					    rem_cca_modes)
-				printf("%d,", nla_type(nl_cca_modes));
-			/* TODO */
-			printf("\b \n");
-		}
-
-		if (tb_caps[NL802154_CAP_ATTR_CCA_OPTS]) {
-			struct nlattr *nl_cca_opts;
-			int rem_cca_opts;
-
-			printf("\tcca_opts: ");
-			nla_for_each_nested(nl_cca_opts,
-					    tb_caps[NL802154_CAP_ATTR_CCA_OPTS],
-					    rem_cca_opts) {
-				printf("%d", nla_type(nl_cca_opts));
-				switch (nla_type(nl_cca_opts)) {
-				case NL802154_CCA_OPT_ENERGY_CARRIER_AND:
-				case NL802154_CCA_OPT_ENERGY_CARRIER_OR:
-					printf("(cca_mode: 3),");
-					break;
-				default:
-					printf("unkown\n");
-					break;
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
 				}
 			}
 			/* TODO */
-			printf("\b \n");
+			printf("\n");
 		}
 
 		if (tb_caps[NL802154_CAP_ATTR_MIN_MINBE] &&
-- 
2.1.4

