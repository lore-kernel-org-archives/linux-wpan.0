Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35579 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652AbbHFH2N (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 6 Aug 2015 03:28:13 -0400
Received: by wibxm9 with SMTP id xm9so10634359wib.0
        for <linux-wpan@vger.kernel.org>; Thu, 06 Aug 2015 00:28:12 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFCv5 bluetooth-next 3/4] at86rf230: use STATE_TX_ARET mode only
Date: Thu,  6 Aug 2015 09:28:35 +0200
Message-Id: <1438846116-4787-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1438846116-4787-1-git-send-email-alex.aring@gmail.com>
References: <1438846116-4787-1-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch changes the state change behaviour of at86rf230 to always
TX_ARET mode. According the at86rf2xx datasheets TX_ARET mode doesn't
mean to be always waiting for ack frames after transmit. The transceiver
will automatically wait for ack frames or not if the acknowledge request
bit is set. See section "TX_ARET_ON – Transmit with Automatic Frame
Retransmission and CSMA-CA Retry".

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 52 ++++++++++----------------------------
 1 file changed, 14 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index d0d5bf6..6422caa 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -97,9 +97,7 @@ struct at86rf230_local {
 
 	struct at86rf230_state_change irq;
 
-	bool tx_aret;
 	unsigned long cal_timeout;
-	s8 max_frame_retries;
 	bool is_tx;
 	bool is_tx_from_off;
 	u8 tx_retry;
@@ -651,7 +649,7 @@ at86rf230_tx_complete(void *context)
 
 	enable_irq(ctx->irq);
 
-	ieee802154_xmit_complete(lp->hw, lp->tx_skb, !lp->tx_aret);
+	ieee802154_xmit_complete(lp->hw, lp->tx_skb, false);
 }
 
 static void
@@ -760,17 +758,10 @@ at86rf230_irq_trx_end(struct at86rf230_local *lp)
 {
 	if (lp->is_tx) {
 		lp->is_tx = 0;
-
-		if (lp->tx_aret)
-			at86rf230_async_state_change(lp, &lp->irq,
-						     STATE_FORCE_TX_ON,
-						     at86rf230_tx_trac_status,
-						     true);
-		else
-			at86rf230_async_state_change(lp, &lp->irq,
-						     STATE_RX_AACK_ON,
-						     at86rf230_tx_complete,
-						     true);
+		at86rf230_async_state_change(lp, &lp->irq,
+					     STATE_FORCE_TX_ON,
+					     at86rf230_tx_trac_status,
+					     true);
 	} else {
 		at86rf230_async_read_reg(lp, RG_TRX_STATE, &lp->irq,
 					 at86rf230_rx_trac_check, true);
@@ -876,24 +867,16 @@ at86rf230_xmit_start(void *context)
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
 
-	/* In ARET mode we need to go into STATE_TX_ARET_ON after we
-	 * are in STATE_TX_ON. The pfad differs here, so we change
-	 * the complete handler.
-	 */
-	if (lp->tx_aret) {
-		if (lp->is_tx_from_off) {
-			lp->is_tx_from_off = false;
-			at86rf230_async_state_change(lp, ctx, STATE_TX_ARET_ON,
-						     at86rf230_write_frame,
-						     false);
-		} else {
-			at86rf230_async_state_change(lp, ctx, STATE_TX_ON,
-						     at86rf230_xmit_tx_on,
-						     false);
-		}
+	/* check if we change from off state */
+	if (lp->is_tx_from_off) {
+		lp->is_tx_from_off = false;
+		at86rf230_async_state_change(lp, ctx, STATE_TX_ARET_ON,
+					     at86rf230_write_frame,
+					     false);
 	} else {
 		at86rf230_async_state_change(lp, ctx, STATE_TX_ON,
-					     at86rf230_write_frame, false);
+					     at86rf230_xmit_tx_on,
+					     false);
 	}
 }
 
@@ -1267,15 +1250,8 @@ static int
 at86rf230_set_frame_retries(struct ieee802154_hw *hw, s8 retries)
 {
 	struct at86rf230_local *lp = hw->priv;
-	int rc = 0;
-
-	lp->tx_aret = retries >= 0;
-	lp->max_frame_retries = retries;
 
-	if (retries >= 0)
-		rc = at86rf230_write_subreg(lp, SR_MAX_FRAME_RETRIES, retries);
-
-	return rc;
+	return at86rf230_write_subreg(lp, SR_MAX_FRAME_RETRIES, retries);
 }
 
 static int
-- 
2.5.0

