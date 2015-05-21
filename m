Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:38203 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755170AbbEUO6W (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 21 May 2015 10:58:22 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH bluetooth-next 3/3] ieee802154/atusb: Set default ed level to 0xbe like the rest of these drivers
Date: Thu, 21 May 2015 16:51:37 +0200
Message-Id: <1432219897-29528-4-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1432219897-29528-1-git-send-email-stefan@osg.samsung.com>
References: <1432219897-29528-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>, Stefan Schmidt <stefan@osg.samsung.com>

From: Stefan Schmidt <s.schmidt@samsung.com>

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/atusb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index eef1d8a..1e18774 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -365,8 +365,8 @@ static int atusb_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 
 static int atusb_ed(struct ieee802154_hw *hw, u8 *level)
 {
-	/* @@@ not used by the stack yet */
-	*level = 0;
+	BUG_ON(!level);
+	*level = 0xbe;
 	return 0;
 }
 
-- 
2.1.0

