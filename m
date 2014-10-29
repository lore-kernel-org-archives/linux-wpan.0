Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:43119 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756101AbaJ2Ufw (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 16:35:52 -0400
Received: by mail-wi0-f178.google.com with SMTP id q5so5671710wiv.5
        for <linux-wpan@vger.kernel.org>; Wed, 29 Oct 2014 13:35:51 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 03/17] mac802154: add IEEE802154_HW_ARET hw flag
Date: Wed, 29 Oct 2014 21:34:30 +0100
Message-Id: <1414614884-20243-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
References: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a new IEEE802154_HW_ARET hardware flag for indicating
that the transceiver supports ARET handling. Also remove the
IEEE802154_HW_FRAME_RETRIES from IEEE802154_HW_CSMA flag. Frame retries
handling is part of ARET.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 2 +-
 include/net/mac802154.h            | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index b83ad0b..0054588 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1387,7 +1387,7 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 
 	lp->hw->extra_tx_headroom = 0;
 	lp->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AACK |
-			 IEEE802154_HW_TXPOWER | IEEE802154_HW_CSMA;
+			IEEE802154_HW_TXPOWER | IEEE802154_HW_ARET;
 
 	switch (part) {
 	case 2:
diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index fe14957..c5d7938 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -94,7 +94,10 @@ struct ieee802154_hw {
 /* This groups the most common CSMA support fields into one. */
 #define IEEE802154_HW_CSMA		(IEEE802154_HW_CCA_MODE | \
 					 IEEE802154_HW_CCA_ED_LEVEL | \
-					 IEEE802154_HW_CSMA_PARAMS | \
+					 IEEE802154_HW_CSMA_PARAMS)
+
+/* This groups the most common ARET support fields into one. */
+#define IEEE802154_HW_ARET		(IEEE802154_HW_CSMA | \
 					 IEEE802154_HW_FRAME_RETRIES)
 
 /* struct ieee802154_ops - callbacks from mac802154 to the driver
-- 
2.1.2

