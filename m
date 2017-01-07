Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:57034 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939557AbdAGATL (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 6 Jan 2017 19:19:11 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH bluetooth 4/5] at86rf230: Allow slow GPIO pins for "rstn"
Date: Sat,  7 Jan 2017 01:18:56 +0100
Message-Id: <1483748337-4862-5-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1483748337-4862-1-git-send-email-stefan@osg.samsung.com>
References: <1483748337-4862-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: marcel@holtmann.org
Cc: linux-wpan@vger.kernel.org, Alexander Aring <aar@pengutronix.de>, Andrey Smirnov <andrew.smirnov@gmail.com>, Chris Healy <cphealy@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

From: Andrey Smirnov <andrew.smirnov@gmail.com>

Driver code never touches "rstn" signal in atomic context, so there's
no need to implicitly put such restriction on it by using gpio_set_value
to manipulate it. Replace gpio_set_value to gpio_set_value_cansleep to
fix that.

As a an example of where such restriction might be inconvenient,
consider a hardware design where "rstn" is connected to a pin of I2C/SPI
GPIO expander chip.

Cc: Chris Healy <cphealy@gmail.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/at86rf230.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 46d53a6..76ba7ec 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1715,9 +1715,9 @@ static int at86rf230_probe(struct spi_device *spi)
 	/* Reset */
 	if (gpio_is_valid(rstn)) {
 		udelay(1);
-		gpio_set_value(rstn, 0);
+		gpio_set_value_cansleep(rstn, 0);
 		udelay(1);
-		gpio_set_value(rstn, 1);
+		gpio_set_value_cansleep(rstn, 1);
 		usleep_range(120, 240);
 	}
 
-- 
2.5.5

