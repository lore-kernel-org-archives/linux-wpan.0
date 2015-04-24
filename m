Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:35717 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755251AbbDXHpu (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Apr 2015 03:45:50 -0400
Received: by labbd9 with SMTP id bd9so29372618lab.2
        for <linux-wpan@vger.kernel.org>; Fri, 24 Apr 2015 00:45:48 -0700 (PDT)
From: Christoffer Holmstedt <christoffer.holmstedt@gmail.com>
Subject: [PATCH] at86rf230: Add macro for TRX STATE MASK
Date: Fri, 24 Apr 2015 09:44:49 +0200
Message-Id: <1429861489-6965-1-git-send-email-christoffer.holmstedt@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: Christoffer Holmstedt <christoffer.holmstedt@gmail.com>

Instead of using the 'magic' number of 0x1f the TRX_STATE_MASK macro is
introduced.

Signed-off-by: Christoffer Holmstedt <christoffer.holmstedt@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 38026650c038..684488acc65d 100644
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
1.9.1

