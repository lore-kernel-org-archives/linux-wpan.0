Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:37251 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965247AbaLLLpu (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Dec 2014 06:45:50 -0500
From: Stefan Schmidt <s.schmidt@samsung.com>
Subject: [PATCH bluetooth-next 3/6] ieee802154/at86rf230: Fix typo unkown -> unknown
Date: Fri, 12 Dec 2014 12:45:30 +0100
Message-Id: <1418384733-315-4-git-send-email-s.schmidt@samsung.com>
In-Reply-To: <1418384733-315-1-git-send-email-s.schmidt@samsung.com>
References: <1418384733-315-1-git-send-email-s.schmidt@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>

Signed-off-by: Stefan Schmidt <s.schmidt@samsung.com>
---
 drivers/net/ieee802154/at86rf230.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 069c20f..2c338a4 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1446,7 +1446,7 @@ at86rf230_detect_device(struct at86rf230_local *lp)
 		lp->hw->phy->symbol_duration = 16;
 		break;
 	default:
-		chip = "unkown";
+		chip = "unknown";
 		rc = -ENOTSUPP;
 		break;
 	}
-- 
1.9.3

