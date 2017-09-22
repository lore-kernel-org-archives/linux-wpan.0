Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:54883 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752323AbdIVMO1 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 22 Sep 2017 08:14:27 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH 11/14] ieee802154: cc2520: fix some kernel coding style errors
Date: Fri, 22 Sep 2017 14:14:02 +0200
Message-Id: <20170922121405.31789-12-stefan@osg.samsung.com>
In-Reply-To: <20170922121405.31789-1-stefan@osg.samsung.com>
References: <20170922121405.31789-1-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aring@mojatatu.com>, michael.hennerich@analog.com, h.morris@cascoda.com, linuxdev@cascoda.com, varkabhadram@gmail.com, alan@signal11.us, Stefan Schmidt <stefan@osg.samsung.com>

Fix some spacing and needed new line.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/cc2520.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index d50add705a79..9c1d1768a36f 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -648,7 +648,7 @@ cc2520_set_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 	BUG_ON(channel > CC2520_MAXCHANNEL);
 
 	ret = cc2520_write_register(priv, CC2520_FREQCTRL,
-				    11 + 5*(channel - 11));
+				    11 + 5 * (channel - 11));
 
 	return ret;
 }
@@ -929,6 +929,7 @@ static int cc2520_get_platform_data(struct spi_device *spi,
 
 	if (!np) {
 		struct cc2520_platform_data *spi_pdata = spi->dev.platform_data;
+
 		if (!spi_pdata)
 			return -ENOENT;
 		*pdata = *spi_pdata;
-- 
2.13.5

