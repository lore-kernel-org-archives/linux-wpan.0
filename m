Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729722AbfDVTpY (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 22 Apr 2019 15:45:24 -0400
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 03/68] net: ieee802154: fix a potential NULL pointer dereference
Date: Mon, 22 Apr 2019 15:44:11 -0400
Message-Id: <20190422194516.11634-3-sashal@kernel.org>
In-Reply-To: <20190422194516.11634-1-sashal@kernel.org>
References: <20190422194516.11634-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Kangjie Lu <kjlu@umn.edu>, Stefan Schmidt <stefan@datenfreihafen.org>, Sasha Levin <sashal@kernel.org>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit 2795e8c251614ac0784c9d41008551109f665716 ]

In case alloc_ordered_workqueue fails, the fix releases
sources and returns -ENOMEM to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/ieee802154/adf7242.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index cd1d8faccca5..cd6b95e673a5 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -1268,6 +1268,10 @@ static int adf7242_probe(struct spi_device *spi)
 	INIT_DELAYED_WORK(&lp->work, adf7242_rx_cal_work);
 	lp->wqueue = alloc_ordered_workqueue(dev_name(&spi->dev),
 					     WQ_MEM_RECLAIM);
+	if (unlikely(!lp->wqueue)) {
+		ret = -ENOMEM;
+		goto err_hw_init;
+	}
 
 	ret = adf7242_hw_init(lp);
 	if (ret)
-- 
2.19.1
