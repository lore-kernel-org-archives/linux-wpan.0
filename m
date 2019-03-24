Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:40914 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbfCXXTE (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 24 Mar 2019 19:19:04 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 0AECA6A5
        for <linux-wpan@vger.kernel.org>; Sun, 24 Mar 2019 23:19:03 +0000 (UTC)
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hXLx69waBPYp for <linux-wpan@vger.kernel.org>;
        Sun, 24 Mar 2019 18:19:02 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id CB86760F
        for <linux-wpan@vger.kernel.org>; Sun, 24 Mar 2019 18:19:02 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id b16so6586636iot.5
        for <linux-wpan@vger.kernel.org>; Sun, 24 Mar 2019 16:19:02 -0700 (PDT)
From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH] net: ieee802154: fix missing checks for regmap_update_bits
Date: Sun, 24 Mar 2019 18:18:56 -0500
Message-Id: <20190324231856.2664-1-kjlu@umn.edu>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Xue Liu <liuxuenetmail@gmail.com>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, "David S. Miller" <davem@davemloft.net>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

regmap_update_bits could fail and deserves a check.

The patch adds the checks and if it fails, returns its error
code upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ieee802154/mcr20a.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
index c589f5ae75bb..8bb53ec8d9cf 100644
--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -533,6 +533,8 @@ mcr20a_start(struct ieee802154_hw *hw)
 	dev_dbg(printdev(lp), "no slotted operation\n");
 	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
 				 DAR_PHY_CTRL1_SLOTTED, 0x0);
+	if (ret < 0)
+		return ret;
 
 	/* enable irq */
 	enable_irq(lp->spi->irq);
@@ -540,11 +542,15 @@ mcr20a_start(struct ieee802154_hw *hw)
 	/* Unmask SEQ interrupt */
 	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL2,
 				 DAR_PHY_CTRL2_SEQMSK, 0x0);
+	if (ret < 0)
+		return ret;
 
 	/* Start the RX sequence */
 	dev_dbg(printdev(lp), "start the RX sequence\n");
 	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
 				 DAR_PHY_CTRL1_XCVSEQ_MASK, MCR20A_XCVSEQ_RX);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
-- 
2.17.1
