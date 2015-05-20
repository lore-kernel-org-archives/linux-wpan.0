Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38243 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbbETH0W (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 May 2015 03:26:22 -0400
Received: by wichy4 with SMTP id hy4so49208007wic.1
        for <linux-wpan@vger.kernel.org>; Wed, 20 May 2015 00:26:20 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools] info: change dbm format string
Date: Wed, 20 May 2015 09:26:07 +0200
Message-Id: <1432106767-1509-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch changes the dbm format string to %.3g instead %.2g. The
reason is that it shows not well for a 3-digit number like "-100" is
shown as "-1e+02". A format string of %.3g will fix that.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reported-by: Craig Younkins <craig@freshtemp.com>
---
 src/info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/info.c b/src/info.c
index c749866..b74442d 100644
--- a/src/info.c
+++ b/src/info.c
@@ -163,7 +163,7 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 
 			printf("\ttx_powers: ");
 			nla_for_each_nested(nl_pwrs, tb_caps[NL802154_CAP_ATTR_TX_POWERS], rem_pwrs)
-				printf("%.2g,", MBM_TO_DBM(nla_get_s32(nl_pwrs)));
+				printf("%.3g,", MBM_TO_DBM(nla_get_s32(nl_pwrs)));
 			/* TODO */
 			printf("\b \n");
 		}
@@ -174,7 +174,7 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 
 			printf("\tcca_ed_levels: ");
 			nla_for_each_nested(nl_levels, tb_caps[NL802154_CAP_ATTR_CCA_ED_LEVELS], rem_levels)
-				printf("%.2g,", MBM_TO_DBM(nla_get_s32(nl_levels)));
+				printf("%.3g,", MBM_TO_DBM(nla_get_s32(nl_levels)));
 			/* TODO */
 			printf("\b \n");
 		}
-- 
2.3.7

