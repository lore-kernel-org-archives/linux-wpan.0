Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from r0.smtpout1.alwaysdata.com ([176.31.58.0]:35357 "EHLO
	r0.smtpout1.alwaysdata.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753460AbcCJSO7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Thu, 10 Mar 2016 13:14:59 -0500
From: web+oss@zopieux.com
Subject: [PATCH 3/3] mrf24j40: apply the security-enabled bit on secured outbound frames
Date: Thu, 10 Mar 2016 19:14:03 +0100
Message-Id: <1457633643-12535-3-git-send-email-web+oss@zopieux.com>
In-Reply-To: <1457633643-12535-1-git-send-email-web+oss@zopieux.com>
References: <1457633643-12535-1-git-send-email-web+oss@zopieux.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexandre Macabies <web+oss@zopieux.com>, Alexander Aring <aar@pengutronix.de>

From: Alexandre Macabies <web+oss@zopieux.com>

We set the TXNSECEN bit of register TXNCON to on when transmitting a
security-enabled frame, as described in section 3.12.2 of the MRF
datasheet.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
Reported-by: Alexandre Macabies <web+oss@zopieux.com>
Tested-by: Alexandre Macabies <web+oss@zopieux.com>
---
 drivers/net/ieee802154/mrf24j40.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 96814cf..bf11cbb 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -61,6 +61,7 @@
 #define REG_TXBCON0	0x1A
 #define REG_TXNCON	0x1B  /* Transmit Normal FIFO Control */
 #define BIT_TXNTRIG	BIT(0)
+#define BIT_TXNSECEN	BIT(1)
 #define BIT_TXNACKREQ	BIT(2)
 
 #define REG_TXG1CON	0x1C
@@ -550,6 +551,9 @@ static void write_tx_buf_complete(void *context)
 	u8 val = BIT_TXNTRIG;
 	int ret;
 
+	if (ieee802154_is_secen(fc))
+		val |= BIT_TXNSECEN;
+
 	if (ieee802154_is_ackreq(fc))
 		val |= BIT_TXNACKREQ;
 
-- 
2.7.2

