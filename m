Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37005 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932299AbbCRN1T (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 18 Mar 2015 09:27:19 -0400
Received: by wixw10 with SMTP id w10so39858710wix.0
        for <linux-wpan@vger.kernel.org>; Wed, 18 Mar 2015 06:27:18 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 1/2] phy: use NL802154_CMD_SET_WPAN_PHY
Date: Wed, 18 Mar 2015 14:27:08 +0100
Message-Id: <1426685229-31900-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1426685229-31900-1-git-send-email-alex.aring@gmail.com>
References: <1426685229-31900-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch change all set commands for phy settings to
NL802154_CMD_SET_WPAN_PHY which is the new command. The decision which
setting should be set is now determined which attribute is set.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/phy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/phy.c b/src/phy.c
index 2e25013..ff38a42 100644
--- a/src/phy.c
+++ b/src/phy.c
@@ -45,7 +45,7 @@ nla_put_failure:
 	return -ENOBUFS;
 }
 COMMAND(set, channel, "<page> <channel>",
-	NL802154_CMD_SET_CHANNEL, 0, CIB_PHY, handle_channel_set, NULL);
+	NL802154_CMD_SET_WPAN_PHY, 0, CIB_PHY, handle_channel_set, NULL);
 
 static int handle_tx_power_set(struct nl802154_state *state,
 			       struct nl_cb *cb,
@@ -72,7 +72,7 @@ nla_put_failure:
 	return -ENOBUFS;
 }
 COMMAND(set, tx_power, "<dBm>",
-	NL802154_CMD_SET_TX_POWER, 0, CIB_PHY, handle_tx_power_set, NULL);
+	NL802154_CMD_SET_WPAN_PHY, 0, CIB_PHY, handle_tx_power_set, NULL);
 
 static int handle_cca_mode_set(struct nl802154_state *state,
 			       struct nl_cb *cb,
@@ -113,7 +113,7 @@ nla_put_failure:
 	return -ENOBUFS;
 }
 COMMAND(set, cca_mode, "<mode|3 <1|0>>",
-	NL802154_CMD_SET_CCA_MODE, 0, CIB_PHY, handle_cca_mode_set, NULL);
+	NL802154_CMD_SET_WPAN_PHY, 0, CIB_PHY, handle_cca_mode_set, NULL);
 
 static int handle_cca_ed_level(struct nl802154_state *state,
 			       struct nl_cb *cb,
@@ -140,4 +140,4 @@ nla_put_failure:
 	return -ENOBUFS;
 }
 COMMAND(set, cca_ed_level, "<level>",
-	NL802154_CMD_SET_CCA_ED_LEVEL, 0, CIB_PHY, handle_cca_ed_level, NULL);
+	NL802154_CMD_SET_WPAN_PHY, 0, CIB_PHY, handle_cca_ed_level, NULL);
-- 
2.3.3

