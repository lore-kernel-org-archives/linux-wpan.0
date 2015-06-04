Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:46362 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752629AbbFDJVr (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Jun 2015 05:21:47 -0400
Received: from authenticated-user (unknown [127.0.0.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by box.christofferholmstedt.se (Postfix) with ESMTPSA id 5BE1C140D8C
	for <linux-wpan@vger.kernel.org>; Thu,  4 Jun 2015 05:21:45 -0400 (EDT)
Date: Thu, 4 Jun 2015 11:21:35 +0200
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: [PATCH wpan-tools 2/2] info: remove old cca options capabilities
 output
Message-ID: <20150604092116.GA8053@probook-6560b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Signed-off-by: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
---
 src/info.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/src/info.c b/src/info.c
index d2e88febd20c..97844e1babec 100644
--- a/src/info.c
+++ b/src/info.c
@@ -411,29 +411,6 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
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
1.9.1


-- 
Christoffer Holmstedt
