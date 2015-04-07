Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:33338 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168AbbDGLuL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Apr 2015 07:50:11 -0400
Received: by wgin8 with SMTP id n8so53227826wgi.0
        for <linux-wpan@vger.kernel.org>; Tue, 07 Apr 2015 04:50:09 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv3 bluetooth-next 4/4] ieee802154: set aret handling according to 802.15.4
Date: Tue,  7 Apr 2015 13:49:53 +0200
Message-Id: <1428407393-16005-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1428407393-16005-1-git-send-email-alex.aring@gmail.com>
References: <1428407393-16005-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

The 802.15.4 standard describes a max frame retries parameter 3 as
default. Currently this parameter affects only the transceivers which
supports automatic retransmission. This at the moment the at86rf230
driver, all other drivers which don't support setting of max frame
retries parameter we assume the 802.15.4 default now.

This change will introduce that the at86rf230 driver will go into ARET
mode (max frame retries parameter above or equal zero) per default.

If somebody experience that other nodes receives the same frame
three times repeatly, then your receiving node doesn't support AACK
handling for receiving. For all users they should set the max frame
retries parameter to "-1" which turns off the ARET mode and restore the
old behaviour.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
index 7a107b0..619a220 100644
--- a/net/ieee802154/core.c
+++ b/net/ieee802154/core.c
@@ -221,8 +221,7 @@ cfg802154_reset_mac_pib(struct wpan_dev *wpan_dev)
 	wpan_dev->min_be = 3;
 	wpan_dev->max_be = 5;
 	wpan_dev->csma_retries = 4;
-	/* for compatibility, actual default is 3 */
-	wpan_dev->frame_retries = -1;
+	wpan_dev->frame_retries = 3;
 
 	wpan_dev->pan_id = cpu_to_le16(IEEE802154_PAN_ID_BROADCAST);
 	wpan_dev->short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_BROADCAST);
-- 
2.3.5

