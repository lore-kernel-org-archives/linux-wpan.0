Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:45235 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbbETN2Q (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 May 2015 09:28:16 -0400
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH atubs-fw 2/4] atusb/fw: Use RX_AACK_ON instead of RX_ON in the firmware.
Date: Wed, 20 May 2015 15:18:12 +0200
Message-Id: <1432127894-4760-3-git-send-email-stefan@datenfreihafen.org>
In-Reply-To: <1432127894-4760-1-git-send-email-stefan@datenfreihafen.org>
References: <1432127894-4760-1-git-send-email-stefan@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, werner@almesberger.net, Stefan Schmidt <stefan@datenfreihafen.org>

This allows to run the device in ARET networks as we handle the needed
automated ACK in hardware.

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
---
 atusb/fw/mac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/atusb/fw/mac.c b/atusb/fw/mac.c
index 2344b99..08ed00a 100644
--- a/atusb/fw/mac.c
+++ b/atusb/fw/mac.c
@@ -182,7 +182,7 @@ bool mac_rx(int on)
 	if (on) {
 		mac_irq = handle_irq;
 		reg_read(REG_IRQ_STATUS);
-		change_state(TRX_CMD_RX_ON);
+		change_state(TRX_CMD_RX_AACK_ON);
 	} else {
 		mac_irq = NULL;
 		change_state(TRX_CMD_FORCE_TRX_OFF);
@@ -232,9 +232,9 @@ static void do_tx(void *user)
 
 	/*
 	 * Wait until we reach BUSY_TX, so that we command the transition to
-	 * RX_ON which will be executed upon TX completion.
+	 * RX_AACK_ON which will be executed upon TX completion.
 	 */
-	change_state(TRX_CMD_RX_ON);
+	change_state(TRX_CMD_RX_AACK_ON);
 }
 
 
-- 
2.1.0

