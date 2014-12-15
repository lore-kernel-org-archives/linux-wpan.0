Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33693 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbaLOJ0Y (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 15 Dec 2014 04:26:24 -0500
Received: by mail-wi0-f176.google.com with SMTP id ex7so8162621wid.9
        for <linux-wpan@vger.kernel.org>; Mon, 15 Dec 2014 01:26:23 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 2/5] at86rf230: make at86rf230_async_error inline
Date: Mon, 15 Dec 2014 10:25:54 +0100
Message-Id: <1418635557-6670-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1418635557-6670-1-git-send-email-alex.aring@gmail.com>
References: <1418635557-6670-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch makes the at86rf230_async_error inline. This function is
small enough to handle inline.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reviewed-by: Stefan Schmidt <s.schmidt@samsung.com>
---
 drivers/net/ieee802154/at86rf230.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 434efc5..8ca4ef6 100644
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

