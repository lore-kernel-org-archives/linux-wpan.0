Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:47265 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751583AbbFIOF4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 9 Jun 2015 10:05:56 -0400
From: christoffer@christofferholmstedt.se
Subject: [PATCH v2 wpan-tools 2/2] info: remove old cca options capabilities output
Date: Tue,  9 Jun 2015 16:05:38 +0200
Message-Id: <1433858738-25445-3-git-send-email-christoffer@christofferholmstedt.se>
In-Reply-To: <1433858738-25445-1-git-send-email-christoffer@christofferholmstedt.se>
References: <20150604092001.GA8027@probook-6560b>
 <1433858738-25445-1-git-send-email-christoffer@christofferholmstedt.se>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Christoffer Holmstedt <christoffer@christofferholmstedt.se>

From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>

Signed-off-by: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
---
 src/info.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/src/info.c b/src/info.c
index 364c02f718aa..e70f33da8997 100644
--- a/src/info.c
+++ b/src/info.c
@@ -412,29 +412,6 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 			printf("\n");
 		}
 
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
-				}
-			}
-			/* TODO */
-			printf("\b \n");
-		}
-
 		if (tb_caps[NL802154_CAP_ATTR_MIN_MINBE] &&
 		    tb_caps[NL802154_CAP_ATTR_MAX_MINBE] &&
 		    tb_caps[NL802154_CAP_ATTR_MIN_MAXBE] &&
-- 
2.1.4

