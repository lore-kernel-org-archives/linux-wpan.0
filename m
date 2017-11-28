Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-by2nam03on0084.outbound.protection.outlook.com ([104.47.42.84]:45760
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751239AbdK1Muk (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 28 Nov 2017 07:50:40 -0500
From: <michael.hennerich@analog.com>
Subject: [PATCH 2/5] net: ieee802154: adf7242: Fix bug if defined DEBUG
Date: Tue, 28 Nov 2017 13:53:12 +0100
Message-ID: <1511873595-29238-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1511873595-29238-1-git-send-email-michael.hennerich@analog.com>
References: <1511873595-29238-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: alex.aring@gmail.com, stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

This fixes undefined reference to struct adf7242_local *lp in
case DEBUG is defined.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/net/ieee802154/adf7242.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index 56f4ca8..a11948a 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -888,7 +888,7 @@ static const struct ieee802154_ops adf7242_ops = {
 	.set_cca_ed_level = adf7242_set_cca_ed_level,
 };
 
-static void adf7242_debug(u8 irq1)
+static void adf7242_debug(struct adf7242_local *lp, u8 irq1)
 {
 #ifdef DEBUG
 	u8 stat;
@@ -932,7 +932,7 @@ static irqreturn_t adf7242_isr(int irq, void *data)
 		dev_err(&lp->spi->dev, "%s :ERROR IRQ1 = 0x%X\n",
 			__func__, irq1);
 
-	adf7242_debug(irq1);
+	adf7242_debug(lp, irq1);
 
 	xmit = test_bit(FLAG_XMIT, &lp->flags);
 
-- 
2.7.4

