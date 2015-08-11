Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15106 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933181AbbHKCpX (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 10 Aug 2015 22:45:23 -0400
From: sdliyong@gmail.com
Subject: [PATCH v2 bluetooth-next] cc2520: set the default fifo pin value from platform data
Date: Tue, 11 Aug 2015 10:43:05 +0800
Message-Id: <1439260985-5173-1-git-send-email-sdliyong@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: varkabhadram@gmail.com, alex.aring@gmail.com, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yong Li <sdliyong@gmail.com>

From: Yong Li <sdliyong@gmail.com>

When the device tree support is disabled, the fifo_pin is uninitialized,
this patch will set the fifo_pin value based on platform data

Signed-off-by: Yong Li <sdliyong@gmail.com>
---
 drivers/net/ieee802154/cc2520.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 613dae5..c5b54a1 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -833,6 +833,7 @@ static int cc2520_get_platform_data(struct spi_device *spi,
 		if (!spi_pdata)
 			return -ENOENT;
 		*pdata = *spi_pdata;
+		priv->fifo_pin = pdata->fifo;
 		return 0;
 	}
 
-- 
2.1.0

