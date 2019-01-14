Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:49365 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfANPsi (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 14 Jan 2019 10:48:38 -0500
From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ieee802154: mcr20a: fix indentation, remove tabs
Date: Mon, 14 Jan 2019 15:48:34 +0000
Message-Id: <20190114154834.18693-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, "David S . Miller" <davem@davemloft.net>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The are a couple of statments that are one level too deep, fix this by
removing tabs.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ieee802154/mcr20a.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
index 44de81e5f140..c589f5ae75bb 100644
--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -905,9 +905,9 @@ mcr20a_irq_clean_complete(void *context)
 		}
 		break;
 	case (DAR_IRQSTS1_RXIRQ | DAR_IRQSTS1_SEQIRQ):
-			/* rx is starting */
-			dev_dbg(printdev(lp), "RX is starting\n");
-			mcr20a_handle_rx(lp);
+		/* rx is starting */
+		dev_dbg(printdev(lp), "RX is starting\n");
+		mcr20a_handle_rx(lp);
 		break;
 	case (DAR_IRQSTS1_RXIRQ | DAR_IRQSTS1_TXIRQ | DAR_IRQSTS1_SEQIRQ):
 		if (lp->is_tx) {
-- 
2.19.1
