Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727515AbfEPLj5 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 16 May 2019 07:39:57 -0400
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 19/34] net: ieee802154: fix missing checks for regmap_update_bits
Date: Thu, 16 May 2019 07:39:16 -0400
Message-Id: <20190516113932.8348-19-sashal@kernel.org>
In-Reply-To: <20190516113932.8348-1-sashal@kernel.org>
References: <20190516113932.8348-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Kangjie Lu <kjlu@umn.edu>, Mukesh Ojha <mojha@codeaurora.org>, Stefan Schmidt <stefan@datenfreihafen.org>, Sasha Levin <sashal@kernel.org>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit 22e8860cf8f777fbf6a83f2fb7127f682a8e9de4 ]

regmap_update_bits could fail and deserves a check.

The patch adds the checks and if it fails, returns its error
code upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ieee802154/mcr20a.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
index c589f5ae75bb5..8bb53ec8d9cf2 100644
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
2.20.1
