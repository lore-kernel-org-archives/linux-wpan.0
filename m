Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:35009 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475AbbE0KZZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 27 May 2015 06:25:25 -0400
Received: by wgme6 with SMTP id e6so5312216wgm.2
        for <linux-wpan@vger.kernel.org>; Wed, 27 May 2015 03:25:24 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 3/3] info: add support for cca ed level info
Date: Wed, 27 May 2015 12:25:05 +0200
Message-Id: <1432722305-22460-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1432722305-22460-1-git-send-email-alex.aring@gmail.com>
References: <1432722305-22460-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for dumping the current cca ed level value.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/info.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/info.c b/src/info.c
index 79b101e..e8f5dda 100644
--- a/src/info.c
+++ b/src/info.c
@@ -94,6 +94,9 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 		printf("\n");
 	}
 
+	if (tb_msg[NL802154_ATTR_CCA_ED_LEVEL])
+		printf("cca_ed_level: %.3g\n", MBM_TO_DBM(nla_get_s32(tb_msg[NL802154_ATTR_CCA_ED_LEVEL])));
+
 	if (tb_msg[NL802154_ATTR_TX_POWER])
 		printf("tx_power: %.3g\n", MBM_TO_DBM(nla_get_s32(tb_msg[NL802154_ATTR_TX_POWER])));
 
-- 
2.4.1

