Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:41671 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbbFHNEU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 8 Jun 2015 09:04:20 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH bluetooth-next] ieee802154/mrf24j40: make sure we do not override return values
Date: Mon,  8 Jun 2015 15:04:11 +0200
Message-Id: <1433768651-5458-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Alan Ott <alan@signal11.us>, Stefan Schmidt <stefan@osg.samsung.com>

If we run into an error during rx we set the the error code in ret, but override
it afterwards. Using a different variable for the extra case avoids this
situation.

CID: 1226982, 1226983
Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
Cc: Alan Ott <alan@signal11.us>
---
 drivers/net/ieee802154/mrf24j40.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 99c7676..0b9b2ae 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -533,6 +533,7 @@ static int mrf24j40_handle_rx(struct mrf24j40 *devrec)
 	u8 lqi = 0;
 	u8 val;
 	int ret = 0;
+	int ret2 = 0;
 	struct sk_buff *skb;
 
 	/* Turn off reception of packets off the air. This prevents the
@@ -569,9 +570,9 @@ static int mrf24j40_handle_rx(struct mrf24j40 *devrec)
 
 out:
 	/* Turn back on reception of packets off the air. */
-	ret = read_short_reg(devrec, REG_BBREG1, &val);
-	if (ret)
-		return ret;
+	ret2 = read_short_reg(devrec, REG_BBREG1, &val);
+	if (ret2)
+		return ret2;
 	val &= ~0x4; /* Clear RXDECINV */
 	write_short_reg(devrec, REG_BBREG1, val);
 
-- 
2.1.0

