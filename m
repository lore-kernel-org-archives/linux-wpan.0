Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from r0.smtpout1.alwaysdata.com ([176.31.58.0]:56641 "EHLO
	r0.smtpout1.alwaysdata.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933074AbcDLQxl (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 12 Apr 2016 12:53:41 -0400
From: Alexandre Macabies <web+oss@zopieux.com>
Subject: [PATCH v3 3/3] mrf24j40: apply the security-enabled bit on secured outbound frames
Date: Tue, 12 Apr 2016 18:53:02 +0200
Message-Id: <1460479982-4955-3-git-send-email-web+oss@zopieux.com>
In-Reply-To: <1460479982-4955-1-git-send-email-web+oss@zopieux.com>
References: <1457988374-31220-1-git-send-email-web+oss@zopieux.com>
 <1460479982-4955-1-git-send-email-web+oss@zopieux.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: marcel@holtmann.org, Alexandre Macabies <web+oss@zopieux.com>, Alexander Aring <aar@pengutronix.de>

We set the TXNSECEN bit of register TXNCON to on when transmitting a
security-enabled frame, as described in section 3.12.2 of the MRF
datasheet.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
Signed-off-by: Alexandre Macabies <web+oss@zopieux.com>
Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Acked-by: Alan Ott <alan@signal11.us>
---
 drivers/net/ieee802154/mrf24j40.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index adc67be..f446db8 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -61,6 +61,7 @@
 #define REG_TXBCON0	0x1A
 #define REG_TXNCON	0x1B  /* Transmit Normal FIFO Control */
 #define BIT_TXNTRIG	BIT(0)
+#define BIT_TXNSECEN	BIT(1)
 #define BIT_TXNACKREQ	BIT(2)
 
 #define REG_TXG1CON	0x1C
@@ -551,6 +552,9 @@ static void write_tx_buf_complete(void *context)
 	u8 val = BIT_TXNTRIG;
 	int ret;
 
+	if (ieee802154_is_secen(fc))
+		val |= BIT_TXNSECEN;
+
 	if (ieee802154_is_ackreq(fc))
 		val |= BIT_TXNACKREQ;
 
-- 
2.7.3

