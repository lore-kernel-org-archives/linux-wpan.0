Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:42341 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754812AbbB0I7Z (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 27 Feb 2015 03:59:25 -0500
Received: by wesw62 with SMTP id w62so18489792wes.9
        for <linux-wpan@vger.kernel.org>; Fri, 27 Feb 2015 00:59:23 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv5 bluetooth-next 4/6] at86rf230: add irqmask mode setting
Date: Fri, 27 Feb 2015 09:58:28 +0100
Message-Id: <1425027510-2672-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1425027510-2672-1-git-send-email-alex.aring@gmail.com>
References: <1425027510-2672-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Since we support at86rf233 we need to ensure that basic operation
default values are the same. This patch always sets IRQ_MASK_MODE to 0
which is after reset 1 at the at86rf233 and 0 at the at86rf231.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 6bba24d..e6dec0a 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1336,6 +1336,11 @@ static int at86rf230_hw_init(struct at86rf230_local *lp, u8 xtal_trim)
 	if (rc)
 		return rc;
 
+	/* reset values differs in at86rf231 and at86rf233 */
+	rc = at86rf230_write_subreg(lp, SR_IRQ_MASK_MODE, 0);
+	if (rc)
+		return rc;
+
 	get_random_bytes(csma_seed, ARRAY_SIZE(csma_seed));
 	rc = at86rf230_write_subreg(lp, SR_CSMA_SEED_0, csma_seed[0]);
 	if (rc)
-- 
2.3.0

