Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:54892 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752337AbdIVMO3 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 22 Sep 2017 08:14:29 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH 13/14] ieee802154: cc2520: switch from BUG_ON() to WARN_ON() on problem
Date: Fri, 22 Sep 2017 14:14:04 +0200
Message-Id: <20170922121405.31789-14-stefan@osg.samsung.com>
In-Reply-To: <20170922121405.31789-1-stefan@osg.samsung.com>
References: <20170922121405.31789-1-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aring@mojatatu.com>, michael.hennerich@analog.com, h.morris@cascoda.com, linuxdev@cascoda.com, varkabhadram@gmail.com, alan@signal11.us, Stefan Schmidt <stefan@osg.samsung.com>

The check is valid but it does not warrant to crash the kernel. A
WARN_ON() is good enough here.
Found by checkpatch.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 drivers/net/ieee802154/cc2520.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 735b9f5f9754..0c89d3edf901 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -517,7 +517,7 @@ cc2520_tx(struct ieee802154_hw *hw, struct sk_buff *skb)
 	}
 
 	spin_lock_irqsave(&priv->lock, flags);
-	BUG_ON(priv->is_tx);
+	WARN_ON(priv->is_tx);
 	priv->is_tx = 1;
 	spin_unlock_irqrestore(&priv->lock, flags);
 
@@ -643,9 +643,9 @@ cc2520_set_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 
 	dev_dbg(&priv->spi->dev, "trying to set channel\n");
 
-	BUG_ON(page != 0);
-	BUG_ON(channel < CC2520_MINCHANNEL);
-	BUG_ON(channel > CC2520_MAXCHANNEL);
+	WARN_ON(page != 0);
+	WARN_ON(channel < CC2520_MINCHANNEL);
+	WARN_ON(channel > CC2520_MAXCHANNEL);
 
 	ret = cc2520_write_register(priv, CC2520_FREQCTRL,
 				    11 + 5 * (channel - 11));
-- 
2.13.5

