Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:31933 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753260AbbAEJCl (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 5 Jan 2015 04:02:41 -0500
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] at86rf230: Constify struct regmap_config
Date: Mon, 05 Jan 2015 10:02:31 +0100
Message-id: <1420448551-9443-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

The regmap_config struct may be const because it is not modified by the
driver and regmap_init() accepts pointer to const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/net/ieee802154/at86rf230.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 80632fc59756..7b051eacb7f1 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -427,7 +427,7 @@ at86rf230_reg_precious(struct device *dev, unsigned int reg)
 	}
 }
 
-static struct regmap_config at86rf230_regmap_spi_config = {
+static const struct regmap_config at86rf230_regmap_spi_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.write_flag_mask = CMD_REG | CMD_WRITE,
-- 
1.9.1

