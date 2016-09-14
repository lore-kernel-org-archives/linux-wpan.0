Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:58362 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755632AbcINMNV (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 14 Sep 2016 08:13:21 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 2/2] info: pretty print tx powers output
Date: Wed, 14 Sep 2016 14:03:53 +0200
Message-Id: <1473854633-4391-3-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1473854633-4391-1-git-send-email-stefan@osg.samsung.com>
References: <1473854633-4391-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

Add unit, some spacing and break lines to make the output easier to understand
and read.

Fixes #7

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 src/info.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/info.c b/src/info.c
index b06093b..9261454 100644
--- a/src/info.c
+++ b/src/info.c
@@ -372,11 +372,18 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 
 		if (tb_caps[NL802154_CAP_ATTR_TX_POWERS]) {
 			int rem_pwrs;
+			int counter = 0;
 			struct nlattr *nl_pwrs;
 
 			printf("\ttx_powers: ");
-			nla_for_each_nested(nl_pwrs, tb_caps[NL802154_CAP_ATTR_TX_POWERS], rem_pwrs)
-				printf("%.3g,", MBM_TO_DBM(nla_get_s32(nl_pwrs)));
+			nla_for_each_nested(nl_pwrs, tb_caps[NL802154_CAP_ATTR_TX_POWERS], rem_pwrs) {
+				if (counter % 6 == 0) {
+					printf("\n\t\t\t%.3g dBM, ", MBM_TO_DBM(nla_get_s32(nl_pwrs)));
+				} else {
+					printf("%.3g dBM, ", MBM_TO_DBM(nla_get_s32(nl_pwrs)));
+				}
+				counter++;
+			}
 			/* TODO */
 			printf("\b \n");
 		}
-- 
2.5.5

