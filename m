Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:37245 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965247AbaLLLps (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Dec 2014 06:45:48 -0500
From: Stefan Schmidt <s.schmidt@samsung.com>
Subject: [PATCH bluetooth-next 1/6] ieee802154/at86rf230: Remove unneeded blank lines
Date: Fri, 12 Dec 2014 12:45:28 +0100
Message-Id: <1418384733-315-2-git-send-email-s.schmidt@samsung.com>
In-Reply-To: <1418384733-315-1-git-send-email-s.schmidt@samsung.com>
References: <1418384733-315-1-git-send-email-s.schmidt@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>

Signed-off-by: Stefan Schmidt <s.schmidt@samsung.com>
---
 drivers/net/ieee802154/at86rf230.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 1c01356..88be161 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -524,7 +524,6 @@ at86rf230_async_state_assert(void *context)
 			}
 		}
 
-
 		dev_warn(&lp->spi->dev, "unexcept state change from 0x%02x to 0x%02x. Actual state: 0x%02x\n",
 			 ctx->from_state, ctx->to_state, trx_state);
 	}
@@ -762,7 +761,6 @@ at86rf230_tx_trac_check(void *context)
 	at86rf230_tx_on(context);
 }
 
-
 static void
 at86rf230_tx_trac_status(void *context)
 {
-- 
1.9.3

