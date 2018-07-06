Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:50533 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753519AbeGFIMf (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 6 Jul 2018 04:12:35 -0400
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 1/3] ieee802154: at86rf230: switch from BUG_ON() to WARN_ON() on problem
Date: Fri,  6 Jul 2018 10:12:10 +0200
Message-Id: <20180706081212.4776-2-stefan@datenfreihafen.org>
In-Reply-To: <20180706081212.4776-1-stefan@datenfreihafen.org>
References: <20180706081212.4776-1-stefan@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: aring@mojatatu.com
Cc: linux-wpan@vger.kernel.org, Stefan Schmidt <stefan@datenfreihafen.org>

The check is valid but it does not warrant to crash the kernel. A
WARN_ON() is good enough here.
Found by checkpatch.

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
---
 drivers/net/ieee802154/at86rf230.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 77abedf0b524..7b3a381d198a 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -940,7 +940,7 @@ at86rf230_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
 static int
 at86rf230_ed(struct ieee802154_hw *hw, u8 *level)
 {
-	BUG_ON(!level);
+	WARN_ON(!level);
 	*level = 0xbe;
 	return 0;
 }
-- 
2.14.4

