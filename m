Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:65146 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762AbaJGIjq (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Oct 2014 04:39:46 -0400
Received: by mail-wi0-f180.google.com with SMTP id em10so7077142wid.13
        for <linux-wpan@vger.kernel.org>; Tue, 07 Oct 2014 01:39:45 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/9] at86rf230: fix errno on tx timeout handling
Date: Tue,  7 Oct 2014 10:38:25 +0200
Message-Id: <1412671113-26675-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1412671113-26675-1-git-send-email-alex.aring@gmail.com>
References: <1412671113-26675-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: m.olbrich@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

The rc variable is zero if we get a timeout. Instead of pass the rc
variable to the async error handling function which try to recover the
phy, we use a static -ETIMEOUT errno.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index c9d2a75..6857038 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -995,7 +995,7 @@ at86rf230_xmit(struct ieee802154_dev *dev, struct sk_buff *skb)
 	rc = wait_for_completion_interruptible_timeout(&lp->tx_complete,
 						       msecs_to_jiffies(lp->data->t_tx_timeout));
 	if (!rc) {
-		at86rf230_async_error(lp, ctx, rc);
+		at86rf230_async_error(lp, ctx, -ETIMEDOUT);
 		return -ETIMEDOUT;
 	}
 
-- 
2.1.2

