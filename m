Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36319 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755056AbbG3I5L (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 30 Jul 2015 04:57:11 -0400
Received: by wicgb10 with SMTP id gb10so234032281wic.1
        for <linux-wpan@vger.kernel.org>; Thu, 30 Jul 2015 01:57:10 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFCv3 bluetooth-next 3/6] at86rf230: use aret mode if ackreq is set while xmit
Date: Thu, 30 Jul 2015 10:55:39 +0200
Message-Id: <1438246542-17633-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1438246542-17633-1-git-send-email-alex.aring@gmail.com>
References: <1438246542-17633-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch does a different aret mode handling. We will drop the
max_frame_retries "-1" value and check on the ack request bit while
xmit. If it's set we doing transmit in aret mode. If it's not set we
doing a transmit in normal tx mode.

This allows a mixed aret and non aret mode while interface is up and
doesn't depends on the max_frame_retries value inside the mib.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index f7bd9f3..8b9557f 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -99,7 +99,6 @@ struct at86rf230_local {
 
 	bool tx_aret;
 	unsigned long cal_timeout;
-	s8 max_frame_retries;
 	bool is_tx;
 	bool is_tx_from_off;
 	u8 tx_retry;
@@ -900,10 +899,14 @@ at86rf230_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 {
 	struct at86rf230_local *lp = hw->priv;
 	struct at86rf230_state_change *ctx = &lp->tx;
+	__le16 fc;
 
 	lp->tx_skb = skb;
 	lp->tx_retry = 0;
 
+	fc = ieee802154_get_fc_from_skb(skb);
+	lp->tx_aret = ieee802154_is_ackreq(fc);
+
 	/* After 5 minutes in PLL and the same frequency we run again the
 	 * calibration loops which is recommended by at86rf2xx datasheets.
 	 *
@@ -1267,9 +1270,6 @@ at86rf230_set_frame_retries(struct ieee802154_hw *hw, s8 retries)
 	struct at86rf230_local *lp = hw->priv;
 	int rc = 0;
 
-	lp->tx_aret = retries >= 0;
-	lp->max_frame_retries = retries;
-
 	if (retries >= 0)
 		rc = at86rf230_write_subreg(lp, SR_MAX_FRAME_RETRIES, retries);
 
-- 
2.5.0

