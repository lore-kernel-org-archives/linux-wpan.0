Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:46606 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbaJGIjt (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Oct 2014 04:39:49 -0400
Received: by mail-wg0-f43.google.com with SMTP id m15so8660536wgh.14
        for <linux-wpan@vger.kernel.org>; Tue, 07 Oct 2014 01:39:48 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 4/9] at86rf230: correct at86rf2xx lifs timings
Date: Tue,  7 Oct 2014 10:38:28 +0200
Message-Id: <1412671113-26675-5-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1412671113-26675-1-git-send-email-alex.aring@gmail.com>
References: <1412671113-26675-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: m.olbrich@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Symbol rate is 16 us. Lifs is 40 symbols. 16 * 40 = 640 us.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 2a25324..b26135f 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1267,7 +1267,7 @@ static struct at86rf2xx_chip_data at86rf233_data = {
 	.t_frame = 4096,
 	.t_p_ack = 545,
 	.t_sifs = 192,
-	.t_lifs = 480,
+	.t_lifs = 640,
 	.t_tx_timeout = 2000,
 	.rssi_base_val = -91,
 	.set_channel = at86rf23x_set_channel,
@@ -1283,7 +1283,7 @@ static struct at86rf2xx_chip_data at86rf231_data = {
 	.t_frame = 4096,
 	.t_p_ack = 545,
 	.t_sifs = 192,
-	.t_lifs = 480,
+	.t_lifs = 640,
 	.t_tx_timeout = 2000,
 	.rssi_base_val = -91,
 	.set_channel = at86rf23x_set_channel,
@@ -1299,7 +1299,7 @@ static struct at86rf2xx_chip_data at86rf212_data = {
 	.t_frame = 4096,
 	.t_p_ack = 545,
 	.t_sifs = 192,
-	.t_lifs = 480,
+	.t_lifs = 640,
 	.t_tx_timeout = 2000,
 	.rssi_base_val = -100,
 	.set_channel = at86rf212_set_channel,
-- 
2.1.2

