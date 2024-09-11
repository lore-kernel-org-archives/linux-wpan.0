Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CEF42AA9;
	Wed, 11 Sep 2024 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047233; cv=none; b=Yq8425BsHLr1UPXS7czqb8MhkoGcfAYtD8PcN/tfQVRvyYJznhuGiORguqtk/ucV9jtzMebnSA1+pXKIG56Wln5edL0U1KmIQHlpZ8Jxs7m/x2mLm5vPoNMwTELZtya+yvWKIHIOd4sXBOylLZLIBN8LIa0KMTwA4BL4ElIKb2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047233; c=relaxed/simple;
	bh=5D3vR9SbumnSRLGVjttIwN5yPIKi6VqQTEpR1q3MytQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C8jNdxQTumzjesUu32l0HX9vppnt/MSe0KW3CU1gTQz8LKL+04A7gE60qhZxpswTl0kh3de5fPY5UkBB7iMuFsZldw7BiXDtdQIQ8KkBLBQx5MMvUibbDwLxSAvDpqAd3OZ7nwJTfsx6yzefI57/wB8P/oZODIrkM2IL97B68/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X3b1W44KFzmV6t;
	Wed, 11 Sep 2024 17:31:43 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id BAB6F14038F;
	Wed, 11 Sep 2024 17:33:46 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 11 Sep
 2024 17:33:46 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <stefan@datenfreihafen.org>, <alex.aring@gmail.com>,
	<miquel.raynal@bootlin.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <liuxuenetmail@gmail.com>,
	<linux-wpan@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH wpan RESEND] net: ieee802154: mcr20a: Use IRQF_NO_AUTOEN flag in request_irq()
Date: Wed, 11 Sep 2024 17:42:34 +0800
Message-ID: <20240911094234.1922418-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)

disable_irq() after request_irq() still has a time gap in which
interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
disable IRQ auto-enable when request IRQ.

Fixes: 8c6ad9cc5157 ("ieee802154: Add NXP MCR20A IEEE 802.15.4 transceiver driver")
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v1 -> RESEND:
- Add Reviewed-by and Acked-by.
- Go through wpan.
---
 drivers/net/ieee802154/mcr20a.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
index 433fb5839203..020d392a98b6 100644
--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -1302,16 +1302,13 @@ mcr20a_probe(struct spi_device *spi)
 		irq_type = IRQF_TRIGGER_FALLING;
 
 	ret = devm_request_irq(&spi->dev, spi->irq, mcr20a_irq_isr,
-			       irq_type, dev_name(&spi->dev), lp);
+			       irq_type | IRQF_NO_AUTOEN, dev_name(&spi->dev), lp);
 	if (ret) {
 		dev_err(&spi->dev, "could not request_irq for mcr20a\n");
 		ret = -ENODEV;
 		goto free_dev;
 	}
 
-	/* disable_irq by default and wait for starting hardware */
-	disable_irq(spi->irq);
-
 	ret = ieee802154_register_hw(hw);
 	if (ret) {
 		dev_crit(&spi->dev, "ieee802154_register_hw failed\n");
-- 
2.34.1

