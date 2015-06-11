Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:47775 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752497AbbFKMZt (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Thu, 11 Jun 2015 08:25:49 -0400
Received: from authenticated-user (unknown [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by box.christofferholmstedt.se (Postfix) with ESMTPSA id 32592143B8D
	for <linux-wpan@vger.kernel.org>; Thu, 11 Jun 2015 08:25:44 -0400 (EDT)
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: [PATCH v6 wpan-tools] info: update CCA mode and CCA options output
Date: Thu, 11 Jun 2015 14:25:38 +0200
Message-Id: <1434025538-11583-1-git-send-email-christoffer@christofferholmstedt.se>
In-Reply-To: <20150611101416.GC972@omega>
References: <20150611101416.GC972@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Instead of printing out CCA mode and CCA options in integers descriptive
text is now printed to the user when "iwpan list" is run.

Signed-off-by: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
---

Changes v5 -> v6:
* Reverted v2 changes. The CCA mode and CCA option value as integer is now
included in the descriptive text as well.
* Reverted v5 changes. The print_cca_mode_handler now returns the buffered
value as well.

Changes v4 -> v5:
* Changed print_cca_mode_handler to only alter cca_mode_buf instead of
returning strings.

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


 src/info.c | 113 ++++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 75 insertions(+), 38 deletions(-)

diff --git a/src/info.c b/src/info.c
index 2434bef6a87f..fd75fa092ce7 100644
--- a/src/info.c
+++ b/src/info.c
@@ -146,6 +146,52 @@ static void print_freq_handler(int channel_page, int channel)
 	}
 }
 
+static char cca_mode_buf[100];
+
+const char *print_cca_mode_handler(enum nl802154_cca_modes cca_mode,
+				   enum nl802154_cca_opts cca_opt)
+{
+	switch (cca_mode) {
+	case NL802154_CCA_ENERGY:
+		sprintf(cca_mode_buf,"(%d) %s", cca_mode, "Energy above threshold");
+		break;
+	case NL802154_CCA_CARRIER:
+		sprintf(cca_mode_buf,"(%d) %s", cca_mode, "Carrier sense only");
+		break;
+	case NL802154_CCA_ENERGY_CARRIER:
+		switch (cca_opt) {
+		case NL802154_CCA_OPT_ENERGY_CARRIER_AND:
+			sprintf(cca_mode_buf, "(%d, cca_opt: %d) %s", cca_mode, cca_opt,
+				"Carrier sense with energy above threshold (logical operator is 'and')");
+			break;
+		case NL802154_CCA_OPT_ENERGY_CARRIER_OR:
+			sprintf(cca_mode_buf, "(%d, cca_opt: %d) %s", cca_mode, cca_opt,
+				"Carrier sense with energy above threshold (logical operator is 'or')");
+			break;
+		default:
+			sprintf(cca_mode_buf, "Unknown CCA option (%d) for CCA mode (%d)",
+				cca_opt, cca_mode);
+			break;
+		}
+		break;
+	case NL802154_CCA_ALOHA:
+		sprintf(cca_mode_buf,"(%d) %s", cca_mode, "ALOHA");
+		break;
+	case NL802154_CCA_UWB_SHR:
+		sprintf(cca_mode_buf,"(%d) %s", cca_mode,
+			"UWB preamble sense based on the SHR of a frame");
+		break;
+	case NL802154_CCA_UWB_MULTIPLEXED:
+		sprintf(cca_mode_buf,"(%d) %s", cca_mode,
+			"UWB preamble sense based on the packet with the multiplexed preamble");
+		break;
+	default:
+		sprintf(cca_mode_buf, "Unknown CCA mode (%d)", cca_mode);
+		break;
+	}
+	return cca_mode_buf;
+}
+
 static const char *commands[NL802154_CMD_MAX + 1] = {
 	[NL802154_CMD_UNSPEC] = "unspec",
 	[NL802154_CMD_GET_WPAN_PHY] = "get_wpan_phy",
@@ -235,23 +281,13 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
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
 
@@ -361,33 +397,34 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 			printf("\tcca_modes: ");
 			nla_for_each_nested(nl_cca_modes,
 					    tb_caps[NL802154_CAP_ATTR_CCA_MODES],
-					    rem_cca_modes)
-				printf("%d,", nla_type(nl_cca_modes));
-			/* TODO */
-			printf("\b \n");
-		}
+					    rem_cca_modes) {
+				/* Loop through all CCA options only if it is a
+				 * CCA mode that takes CCA options into
+				 * consideration.
+				 */
+				if (tb_caps[NL802154_CAP_ATTR_CCA_OPTS] &&
+				    nla_type(nl_cca_modes) == NL802154_CCA_ENERGY_CARRIER) {
+					struct nlattr *nl_cca_opts;
+					int rem_cca_opts;
+
+					nla_for_each_nested(nl_cca_opts,
+								tb_caps[NL802154_CAP_ATTR_CCA_OPTS],
+								rem_cca_opts) {
+						printf("\n\t\t%s",
+							print_cca_mode_handler(
+								nla_type(nl_cca_modes),
+								nla_type(nl_cca_opts)));
+					}
+				} else {
+					printf("\n\t\t%s",
+						print_cca_mode_handler(
+							nla_type(nl_cca_modes),
+							NL802154_CCA_OPT_ATTR_MAX));
 
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
 				}
 			}
 			/* TODO */
-			printf("\b \n");
+			printf("\n");
 		}
 
 		if (tb_caps[NL802154_CAP_ATTR_MIN_MINBE] &&
-- 
2.1.4

