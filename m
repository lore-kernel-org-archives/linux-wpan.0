Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38522 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbbE0KZY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 27 May 2015 06:25:24 -0400
Received: by wizo1 with SMTP id o1so16315506wiz.1
        for <linux-wpan@vger.kernel.org>; Wed, 27 May 2015 03:25:23 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 2/3] info: fix tx power printout
Date: Wed, 27 May 2015 12:25:04 +0200
Message-Id: <1432722305-22460-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1432722305-22460-1-git-send-email-alex.aring@gmail.com>
References: <1432722305-22460-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch uses the format string "%.3g" instead "%.2g" for current
tx power value. This is the same format string like we use to printout
all supported tx power values.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/info.c b/src/info.c
index b74442d..79b101e 100644
--- a/src/info.c
+++ b/src/info.c
@@ -95,7 +95,7 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 	}
 
 	if (tb_msg[NL802154_ATTR_TX_POWER])
-		printf("tx_power: %.2g\n", MBM_TO_DBM(nla_get_s32(tb_msg[NL802154_ATTR_TX_POWER])));
+		printf("tx_power: %.3g\n", MBM_TO_DBM(nla_get_s32(tb_msg[NL802154_ATTR_TX_POWER])));
 
 	if (tb_msg[NL802154_ATTR_WPAN_PHY_CAPS]) {
 		struct nlattr *tb_caps[NL802154_CAP_ATTR_MAX + 1];
-- 
2.4.1

