Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35451 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932991AbbFPJH7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Jun 2015 05:07:59 -0400
Received: by wiga1 with SMTP id a1so102404944wig.0
        for <linux-wpan@vger.kernel.org>; Tue, 16 Jun 2015 02:07:57 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 2/3] at86rf230: add recommended csma backoffs settings
Date: Tue, 16 Jun 2015 11:07:43 +0200
Message-Id: <1434445664-438-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1434445664-438-1-git-send-email-alex.aring@gmail.com>
References: <1434445664-438-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds support for a new random csma backoffs settings when
going into sleep state. This is recommended according at86rf2xx
datasheets.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index b839bbd..7e30a45 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -945,10 +945,21 @@ static void
 at86rf230_stop(struct ieee802154_hw *hw)
 {
 	struct at86rf230_local *lp = hw->priv;
+	u8 csma_seed[2];
 
 	at86rf230_sync_state_change(hw->priv, STATE_FORCE_TRX_OFF);
 
 	disable_irq(lp->spi->irq);
+
+	/* It's recommended to set random new csma_seeds before sleep state.
+	 * Makes only sense in the stop callback, not doing this inside of
+	 * at86rf230_sleep, this is also used when we don't transmit afterwards
+	 * when calling start callback again.
+	 */
+	get_random_bytes(csma_seed, ARRAY_SIZE(csma_seed));
+	at86rf230_write_subreg(lp, SR_CSMA_SEED_0, csma_seed[0]);
+	at86rf230_write_subreg(lp, SR_CSMA_SEED_1, csma_seed[1]);
+
 	at86rf230_sleep(lp);
 }
 
-- 
2.4.1

