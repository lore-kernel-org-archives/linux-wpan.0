Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:43117 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbbCGVHV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 7 Mar 2015 16:07:21 -0500
Received: by wevl61 with SMTP id l61so1121146wev.10
        for <linux-wpan@vger.kernel.org>; Sat, 07 Mar 2015 13:07:20 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] at86rf230: init xtal_trim with zero
Date: Sat,  7 Mar 2015 22:07:07 +0100
Message-Id: <1425762427-8081-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch initialize xtal_trim value to zero. The xtal_trim property is
an optional device tree value. Currently if no xtal_trim property is
given the xtal_trim value can be contain random data, because it's a
stack variable. This patch init the xtal_trim value to zero which is
also the default value after reset for at86rf230 transceivers.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 088fa68..edf575c 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1572,7 +1572,7 @@ static int at86rf230_probe(struct spi_device *spi)
 	struct at86rf230_local *lp;
 	unsigned int status;
 	int rc, irq_type, rstn, slp_tr;
-	u8 xtal_trim;
+	u8 xtal_trim = 0;
 
 	if (!spi->irq) {
 		dev_err(&spi->dev, "no IRQ specified\n");
-- 
2.3.0

