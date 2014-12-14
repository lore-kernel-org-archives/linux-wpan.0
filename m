Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:54282 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbaLNXUs (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 14 Dec 2014 18:20:48 -0500
Received: by mail-wi0-f171.google.com with SMTP id bs8so7265271wib.4
        for <linux-wpan@vger.kernel.org>; Sun, 14 Dec 2014 15:20:47 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/5] at86rf230: make at86rf230_async_error inline
Date: Mon, 15 Dec 2014 00:20:29 +0100
Message-Id: <1418599232-6267-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1418599232-6267-1-git-send-email-alex.aring@gmail.com>
References: <1418599232-6267-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch makes the at86rf230_async_error inline. This function is
small enough to handle inline.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 4e983b3..430d3bd 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -450,7 +450,7 @@ at86rf230_async_error_recover(void *context)
 	ieee802154_wake_queue(lp->hw);
 }
 
-static void
+static inline void
 at86rf230_async_error(struct at86rf230_local *lp,
 		      struct at86rf230_state_change *ctx, int rc)
 {
-- 
2.1.3

