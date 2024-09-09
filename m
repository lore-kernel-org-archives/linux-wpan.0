Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7751B9B55;
	Mon,  9 Sep 2024 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887329; cv=none; b=qZ3n6SJhkik6Qb9uZ54YTYHaJRbNKYixFkMCTd8ArZ4sqrpPQ+RxxO0/VzzgH8mIXpzkFhoCSpDKGhMVWno3DYhMCiv+yfXy7QiUDJBc4SDR0prLymoohqmVx9OZyxmTV6i3oyZ2075GLH3W1AsdlNZb/EGyFI1DQDcLJnL2S5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887329; c=relaxed/simple;
	bh=85C1bydy0DG7tKrDUvpOlx6igAXsB2kGyHqDRrJR3ng=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O5QKKsbJBGMectRyUiLE4EOeD8HmCbMVphsQfLr6Bs0sbxRg3KZ29ieGKy9U6D52zPPt4x7GLFIhYbFpJc0QirrtMUmY0DAUZrH2D85avzNdviVEqCuAUVngHczNRLhpGWb8yCrAJLsq9gdrd9VmiA2NqZ2ToVcEDB1bmEnTg74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4X2RwJ1V1cz1SB4D;
	Mon,  9 Sep 2024 21:08:16 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id A6F3A1A016C;
	Mon,  9 Sep 2024 21:08:43 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Sep
 2024 21:08:43 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <alex.aring@gmail.com>, <stefan@datenfreihafen.org>,
	<miquel.raynal@bootlin.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <liuxuenetmail@gmail.com>,
	<linux-wpan@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] ieee802154: Fix build error
Date: Mon, 9 Sep 2024 21:17:40 +0800
Message-ID: <20240909131740.1296608-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)

If REGMAP_SPI is m and IEEE802154_MCR20A is y,

	mcr20a.c:(.text+0x3ed6c5b): undefined reference to `__devm_regmap_init_spi'
	ld: mcr20a.c:(.text+0x3ed6cb5): undefined reference to `__devm_regmap_init_spi'

Select REGMAP_SPI for IEEE802154_MCR20A to fix it.

Fixes: 8c6ad9cc5157 ("ieee802154: Add NXP MCR20A IEEE 802.15.4 transceiver driver")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/ieee802154/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ieee802154/Kconfig b/drivers/net/ieee802154/Kconfig
index 95da876c5613..1075e24b11de 100644
--- a/drivers/net/ieee802154/Kconfig
+++ b/drivers/net/ieee802154/Kconfig
@@ -101,6 +101,7 @@ config IEEE802154_CA8210_DEBUGFS
 
 config IEEE802154_MCR20A
 	tristate "MCR20A transceiver driver"
+	select REGMAP_SPI
 	depends on IEEE802154_DRIVERS && MAC802154
 	depends on SPI
 	help
-- 
2.34.1

