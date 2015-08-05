Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37260 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbbHELDA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 5 Aug 2015 07:03:00 -0400
Received: by wibhh20 with SMTP id hh20so18504988wib.0
        for <linux-wpan@vger.kernel.org>; Wed, 05 Aug 2015 04:02:59 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFCv4 bluetooth-next 3/6] at86rf230: use aret mode if ackreq is set while xmit
Date: Wed,  5 Aug 2015 13:03:19 +0200
Message-Id: <1438772602-9877-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1438772602-9877-1-git-send-email-alex.aring@gmail.com>
References: <1438772602-9877-1-git-send-email-alex.aring@gmail.com>
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

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index d0d5bf6..06f7eaa 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -99,7 +99,6 @@ struct at86rf230_local {
 
 	bool tx_aret;
 	unsigned long cal_timeout;
-	s8 max_frame_retries;
 	bool is_tx;
 	bool is_tx_from_off;
 	u8 tx_retry;
@@ -902,10 +901,14 @@ at86rf230_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
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
@@ -1269,9 +1272,6 @@ at86rf230_set_frame_retries(struct ieee802154_hw *hw, s8 retries)
 	struct at86rf230_local *lp = hw->priv;
 	int rc = 0;
 
-	lp->tx_aret = retries >= 0;
-	lp->max_frame_retries = retries;
-
 	if (retries >= 0)
 		rc = at86rf230_write_subreg(lp, SR_MAX_FRAME_RETRIES, retries);
 
-- 
2.5.0

