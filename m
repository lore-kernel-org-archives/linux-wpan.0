Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:37261 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966519AbaLLLpx (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Dec 2014 06:45:53 -0500
From: Stefan Schmidt <s.schmidt@samsung.com>
Subject: [PATCH bluetooth-next 6/6] ieee802154/mrf24j40: Fix alignment of parenthesis
Date: Fri, 12 Dec 2014 12:45:33 +0100
Message-Id: <1418384733-315-7-git-send-email-s.schmidt@samsung.com>
In-Reply-To: <1418384733-315-1-git-send-email-s.schmidt@samsung.com>
References: <1418384733-315-1-git-send-email-s.schmidt@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>, Alan Ott <alan@signal11.us>

CC: Alan Ott <alan@signal11.us>
Signed-off-by: Stefan Schmidt <s.schmidt@samsung.com>
---
 drivers/net/ieee802154/mrf24j40.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index ec605c9..fba2dfd 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -323,7 +323,7 @@ static int mrf24j40_read_rx_buf(struct mrf24j40 *devrec,
 
 #ifdef DEBUG
 	print_hex_dump(KERN_DEBUG, "mrf24j40 rx: ",
-		DUMP_PREFIX_OFFSET, 16, 1, data, *len, 0);
+		       DUMP_PREFIX_OFFSET, 16, 1, data, *len, 0);
 	pr_debug("mrf24j40 rx: lqi: %02hhx rssi: %02hhx\n",
 		 lqi_rssi[0], lqi_rssi[1]);
 #endif
@@ -521,7 +521,7 @@ static int mrf24j40_filter(struct ieee802154_hw *hw,
 		 */
 
 		dev_dbg(printdev(devrec), "Set Pan Coord to %s\n",
-					filt->pan_coord ? "on" : "off");
+			filt->pan_coord ? "on" : "off");
 	}
 
 	return 0;
-- 
1.9.3

