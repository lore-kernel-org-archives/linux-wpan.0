Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbeLZWgo (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 26 Dec 2018 17:36:44 -0500
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 29/97] ieee802154: ca8210: fix possible u8 overflow in ca8210_rx_done
Date: Wed, 26 Dec 2018 17:34:49 -0500
Message-Id: <20181226223557.149329-29-sashal@kernel.org>
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: YueHaibing <yuehaibing@huawei.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Sasha Levin <sashal@kernel.org>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 8e41cae64b08fe2e86a9ffb88b295c6b4b3a3322 ]

gcc warning this:

drivers/net/ieee802154/ca8210.c:730:10: warning:
 comparison is always false due to limited range of data type [-Wtype-limits]

'len' is u8 type, we get it from buf[1] adding 2, which can overflow.
This patch change the type of 'len' to unsigned int to avoid this,also fix
the gcc warning.

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ieee802154/ca8210.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 0ff5a403a8dc..b2ff903a9cb6 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -721,7 +721,7 @@ static void ca8210_mlme_reset_worker(struct work_struct *work)
 static void ca8210_rx_done(struct cas_control *cas_ctl)
 {
 	u8 *buf;
-	u8 len;
+	unsigned int len;
 	struct work_priv_container *mlme_reset_wpc;
 	struct ca8210_priv *priv = cas_ctl->priv;
 
@@ -730,7 +730,7 @@ static void ca8210_rx_done(struct cas_control *cas_ctl)
 	if (len > CA8210_SPI_BUF_SIZE) {
 		dev_crit(
 			&priv->spi->dev,
-			"Received packet len (%d) erroneously long\n",
+			"Received packet len (%u) erroneously long\n",
 			len
 		);
 		goto finish;
-- 
2.19.1
