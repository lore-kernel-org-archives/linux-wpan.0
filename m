Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:38465 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbbB0I7W (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 27 Feb 2015 03:59:22 -0500
Received: by wgha1 with SMTP id a1so18547872wgh.5
        for <linux-wpan@vger.kernel.org>; Fri, 27 Feb 2015 00:59:21 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv5 bluetooth-next 3/6] at86rf230: remove tx_timeout
Date: Fri, 27 Feb 2015 09:58:27 +0100
Message-Id: <1425027510-2672-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1425027510-2672-1-git-send-email-alex.aring@gmail.com>
References: <1425027510-2672-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes tx_timeout handling. We used it in sync xmit
handling. Since we support async xmit handling a xmit timeout handling
isn't easy to implement and should be implemented by netdev watchdog
mechanism.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index c1323e5..6bba24d 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -46,8 +46,6 @@ struct at86rf2xx_chip_data {
 	u16 t_off_to_tx_on;
 	u16 t_frame;
 	u16 t_p_ack;
-	/* completion timeout for tx in msecs */
-	u16 t_tx_timeout;
 	int rssi_base_val;
 
 	int (*set_channel)(struct at86rf230_local *, u8, u8);
@@ -1281,7 +1279,6 @@ static struct at86rf2xx_chip_data at86rf233_data = {
 	.t_off_to_tx_on = 80,
 	.t_frame = 4096,
 	.t_p_ack = 545,
-	.t_tx_timeout = 2000,
 	.rssi_base_val = -91,
 	.set_channel = at86rf23x_set_channel,
 	.get_desense_steps = at86rf23x_get_desens_steps
@@ -1295,7 +1292,6 @@ static struct at86rf2xx_chip_data at86rf231_data = {
 	.t_off_to_tx_on = 110,
 	.t_frame = 4096,
 	.t_p_ack = 545,
-	.t_tx_timeout = 2000,
 	.rssi_base_val = -91,
 	.set_channel = at86rf23x_set_channel,
 	.get_desense_steps = at86rf23x_get_desens_steps
@@ -1309,7 +1305,6 @@ static struct at86rf2xx_chip_data at86rf212_data = {
 	.t_off_to_tx_on = 200,
 	.t_frame = 4096,
 	.t_p_ack = 545,
-	.t_tx_timeout = 2000,
 	.rssi_base_val = -100,
 	.set_channel = at86rf212_set_channel,
 	.get_desense_steps = at86rf212_get_desens_steps
-- 
2.3.0

