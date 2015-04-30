Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36187 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbbD3PqO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 30 Apr 2015 11:46:14 -0400
Received: by wizk4 with SMTP id k4so24858623wiz.1
        for <linux-wpan@vger.kernel.org>; Thu, 30 Apr 2015 08:46:13 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 05/13] at86rf230: Add macro for TRX STATE MASK
Date: Thu, 30 Apr 2015 17:44:56 +0200
Message-Id: <1430408704-21815-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1430408704-21815-1-git-send-email-alex.aring@gmail.com>
References: <1430408704-21815-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, Christoffer Holmstedt <christoffer.holmstedt@gmail.com>, Alexander Aring <alex.aring@gmail.com>

From: Christoffer Holmstedt <christoffer.holmstedt@gmail.com>

Instead of using the 'magic' number of 0x1f the TRX_STATE_MASK macro is
introduced.

Signed-off-by: Christoffer Holmstedt <christoffer.holmstedt@gmail.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 3802665..684488a 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -292,6 +292,8 @@ struct at86rf230_local {
 #define STATE_BUSY_RX_AACK_NOCLK 0x1E
 #define STATE_TRANSITION_IN_PROGRESS 0x1F
 
+#define TRX_STATE_MASK		(0x1F)
+
 #define AT86RF2XX_NUMREGS 0x3F
 
 static void
@@ -509,7 +511,7 @@ at86rf230_async_state_assert(void *context)
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
 	const u8 *buf = ctx->buf;
-	const u8 trx_state = buf[1] & 0x1f;
+	const u8 trx_state = buf[1] & TRX_STATE_MASK;
 
 	/* Assert state change */
 	if (trx_state != ctx->to_state) {
@@ -667,7 +669,7 @@ at86rf230_async_state_change_start(void *context)
 	struct at86rf230_state_change *ctx = context;
 	struct at86rf230_local *lp = ctx->lp;
 	u8 *buf = ctx->buf;
-	const u8 trx_state = buf[1] & 0x1f;
+	const u8 trx_state = buf[1] & TRX_STATE_MASK;
 	int rc;
 
 	/* Check for "possible" STATE_TRANSITION_IN_PROGRESS */
-- 
2.3.6

