Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38197 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbbLUBQH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 20 Dec 2015 20:16:07 -0500
Received: by mail-ig0-f178.google.com with SMTP id jw2so26399600igc.1
        for <linux-wpan@vger.kernel.org>; Sun, 20 Dec 2015 17:16:07 -0800 (PST)
From: Brad Campbell <bradjc5@gmail.com>
Subject: [PATCH 1/1] ieee802154-cc2520: Check CRC
Date: Sun, 20 Dec 2015 20:15:33 -0500
Message-Id: <1450660533-38184-2-git-send-email-bradjc5@gmail.com>
In-Reply-To: <1450660533-38184-1-git-send-email-bradjc5@gmail.com>
References: <1450660533-38184-1-git-send-email-bradjc5@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>, Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: Brad Campbell <bradjc5@gmail.com>

Add checking the "CRC_OK" bit at the end of incoming packets to make
sure the cc2520 driver only passes up valid packets. Because the AUTOCRC
bit in the FRMCTRL0 register is set to 1 after init, the CC2520 handles
checking the CRC of incoming packets and sets the most significant bit
of the last byte of the incoming packet to 1 if the check passed. This
patch simply checks that bit.

Signed-off-by: Brad Campbell <bradjc5@gmail.com>
---
 drivers/net/ieee802154/cc2520.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index e65b605..b54edbf 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -450,6 +450,17 @@ cc2520_read_rxfifo(struct cc2520_private *priv, u8 *data, u8 len, u8 *lqi)
 
 	mutex_unlock(&priv->buffer_mutex);
 
+	/* If we are reading the actual packet and not just the length byte,
+	 * check that the CRC is valid.
+	 */
+	if (len > 1) {
+		/* Most significant bit of the last byte of the data buffer
+		 * is a 1 bit CRC indicator. See section 20.3.4.
+		 */
+		if (data[len - 1] >> 7 == 0)
+			return -EINVAL;
+	}
+
 	return status;
 }
 
-- 
2.6.3

