Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:37253 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965247AbaLLLpv (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Dec 2014 06:45:51 -0500
From: Stefan Schmidt <s.schmidt@samsung.com>
Subject: [PATCH bluetooth-next 4/6] ieee802154/cc2520: Remove extra blank lines
Date: Fri, 12 Dec 2014 12:45:31 +0100
Message-Id: <1418384733-315-5-git-send-email-s.schmidt@samsung.com>
In-Reply-To: <1418384733-315-1-git-send-email-s.schmidt@samsung.com>
References: <1418384733-315-1-git-send-email-s.schmidt@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>, Varka Bhadram <varkabhadram@gmail.com>

CC: Varka Bhadram <varkabhadram@gmail.com>
Signed-off-by: Stefan Schmidt <s.schmidt@samsung.com>
---
 drivers/net/ieee802154/cc2520.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index f9df9fa..c2b7da3 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -513,7 +513,6 @@ err_tx:
 	return rc;
 }
 
-
 static int cc2520_rx(struct cc2520_private *priv)
 {
 	u8 len = 0, lqi = 0, bytes = 1;
@@ -947,7 +946,6 @@ static int cc2520_probe(struct spi_device *spi)
 	if (ret)
 		goto err_hw_init;
 
-
 	gpio_set_value(pdata->vreg, HIGH);
 	usleep_range(100, 150);
 
-- 
1.9.3

