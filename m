Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:37251 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966519AbaLLLpw (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Dec 2014 06:45:52 -0500
From: Stefan Schmidt <s.schmidt@samsung.com>
Subject: [PATCH bluetooth-next 5/6] ieee802154/mrf24j40: Fix typo begining -> beginning
Date: Fri, 12 Dec 2014 12:45:32 +0100
Message-Id: <1418384733-315-6-git-send-email-s.schmidt@samsung.com>
In-Reply-To: <1418384733-315-1-git-send-email-s.schmidt@samsung.com>
References: <1418384733-315-1-git-send-email-s.schmidt@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>, Alan Ott <alan@signal11.us>

CC: Alan Ott <alan@signal11.us>
Signed-off-by: Stefan Schmidt <s.schmidt@samsung.com>
---
 drivers/net/ieee802154/mrf24j40.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index a200fa1..ec605c9 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -289,7 +289,7 @@ static int mrf24j40_read_rx_buf(struct mrf24j40 *devrec,
 		goto out;
 
 	/* Range check the RX FIFO length, accounting for the one-byte
-	 * length field at the begining. */
+	 * length field at the beginning. */
 	if (rx_len > RX_FIFO_SIZE-1) {
 		dev_err(printdev(devrec), "Invalid length read from device. Performing short read.\n");
 		rx_len = RX_FIFO_SIZE-1;
-- 
1.9.3

