Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:37248 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965247AbaLLLpt (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Dec 2014 06:45:49 -0500
From: Stefan Schmidt <s.schmidt@samsung.com>
Subject: [PATCH bluetooth-next 2/6] ieee802154/at86rf230: Align to opening parenthesis
Date: Fri, 12 Dec 2014 12:45:29 +0100
Message-Id: <1418384733-315-3-git-send-email-s.schmidt@samsung.com>
In-Reply-To: <1418384733-315-1-git-send-email-s.schmidt@samsung.com>
References: <1418384733-315-1-git-send-email-s.schmidt@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>

Signed-off-by: Stefan Schmidt <s.schmidt@samsung.com>
---
 drivers/net/ieee802154/at86rf230.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 88be161..069c20f 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1080,7 +1080,7 @@ at86rf230_set_hw_addr_filt(struct ieee802154_hw *hw,
 		u16 addr = le16_to_cpu(filt->short_addr);
 
 		dev_vdbg(&lp->spi->dev,
-			"at86rf230_set_hw_addr_filt called for saddr\n");
+			 "at86rf230_set_hw_addr_filt called for saddr\n");
 		__at86rf230_write(lp, RG_SHORT_ADDR_0, addr);
 		__at86rf230_write(lp, RG_SHORT_ADDR_1, addr >> 8);
 	}
@@ -1089,7 +1089,7 @@ at86rf230_set_hw_addr_filt(struct ieee802154_hw *hw,
 		u16 pan = le16_to_cpu(filt->pan_id);
 
 		dev_vdbg(&lp->spi->dev,
-			"at86rf230_set_hw_addr_filt called for pan id\n");
+			 "at86rf230_set_hw_addr_filt called for pan id\n");
 		__at86rf230_write(lp, RG_PAN_ID_0, pan);
 		__at86rf230_write(lp, RG_PAN_ID_1, pan >> 8);
 	}
@@ -1099,14 +1099,14 @@ at86rf230_set_hw_addr_filt(struct ieee802154_hw *hw,
 
 		memcpy(addr, &filt->ieee_addr, 8);
 		dev_vdbg(&lp->spi->dev,
-			"at86rf230_set_hw_addr_filt called for IEEE addr\n");
+			 "at86rf230_set_hw_addr_filt called for IEEE addr\n");
 		for (i = 0; i < 8; i++)
 			__at86rf230_write(lp, RG_IEEE_ADDR_0 + i, addr[i]);
 	}
 
 	if (changed & IEEE802154_AFILT_PANC_CHANGED) {
 		dev_vdbg(&lp->spi->dev,
-			"at86rf230_set_hw_addr_filt called for panc change\n");
+			 "at86rf230_set_hw_addr_filt called for panc change\n");
 		if (filt->pan_coord)
 			at86rf230_write_subreg(lp, SR_AACK_I_AM_COORD, 1);
 		else
-- 
1.9.3

