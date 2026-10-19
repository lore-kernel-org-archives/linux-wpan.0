Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB054E7800
	for <linux-wpan@vger.kernel.org>; Mon, 19 Oct 2026 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792410862; cv=none; b=jg13yUBOX+rE3vtYJhfY4famGbno20AB3bj1pqXjVtKSEjw+R6/S0BsyOX+rZ76mLMPiDPykBXPmD2bebkMfcZCmJnBnVewdXwEgKZAjlfEmPCZuKShk4hqHTw47zSwMiVzT7vQjBS8VsNuwjrG5QCv/CtQPUEfL2S+DjsuYtm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792410862; c=relaxed/simple;
	bh=dxfCj+VPnIBCFOexJn0mvdzX5Uv2UReoD8ktHs3FRwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rlO7vsaIboAysW3S1Dyou5JM1HWU0aG6U/+s8/UE1dfrjvlrKLWCV/hm8B0Dvkf9qf1AmA0HxUq4U+EX6X4hHNhjC9UVno6+pORpf+QIXrZfP2ORGAirLLeouPlIrGw8WnDeWtP8ZafyLyusn09yNvTxox60qpS6OBoZTgM1nM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NozX+69/; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NozX+69/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=HZ
	J468QwnyDM7p2YC+09IWPU9FJLSBFijO0ClA/r7RM=; b=NozX+69/f0xQ9eyM8S
	Q83RQbtON7WLr5bDwTSPyUFKdI6lTI9+NGXhw10WrKLMfzOQtGcK3zKmbf38Vk8W
	mK23JcKy6PHV9Bo9qS7zzoW0IGytHokbKJMuMwcLIK/kQ/EXWKRSg5YAOA4ggXEn
	gIIJVycjfa2RF1YOJhQAD29Ac=
Received: from LAPTOP-137NTCJO (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDnD8TkBNZqGnzMBA--.61814S2;
	Mon, 19 Oct 2026 19:54:13 +0800 (CST)
From: Jiaxin Li <18135327133@163.com>
To: linux-wpan@vger.kernel.org
Cc: Jiaxin Li <18135327133@163.com>
Subject: [PATCH] ieee802154: ca8210: validate received command lengths
Date: Mon, 19 Oct 2026 19:54:00 +0800
Message-ID: <20261019115400.459-1-18135327133@163.com>
X-Mailer: git-send-email 2.56.0.windows.2
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnD8TkBNZqGnzMBA--.61814S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Wry7WryxCF1DKw18KrW3ZFb_yoW8KF45pF
	4aya4jyry8XF1kXan7Ar48XF90v3Wkt34DuFWvgas7CasIqFy5Ga4SkFyxtrWFqFZrXayf
	CrWDJF13AFZ8AFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUjdgXUUUUU=
X-CM-SenderInfo: zpryijyvtsliitt6il2tof0z/xtbC6gWKS2rWBOX3iQAA3N

ca8210_rx_done() computes len from buf[1] but only checks the upper
bound against CA8210_SPI_BUF_SIZE.  The code then reads command bytes
that are not guaranteed to be present: buf[3] for MCPS-DATA.confirm and
buf[2] for the HWME wakeup indication.  ca8210_net_rx() similarly reads
command[26] for MCPS-DATA.indication and command[3] for
MCPS-DATA.confirm without a lower-bound check.

Add the missing per-command length checks and drop or ignore short
messages.

Signed-off-by: Jiaxin Li <18135327133@163.com>
---
 drivers/net/ieee802154/ca8210.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 01af4f9cf..b6f9affee 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -710,7 +710,7 @@ static void ca8210_rx_done(struct cas_control *cas_ctl)
 	}
 
 	ca8210_net_rx(priv->hw, buf, len);
-	if (buf[0] == SPI_MCPS_DATA_CONFIRM) {
+	if (buf[0] == SPI_MCPS_DATA_CONFIRM && len >= 4) {
 		if (buf[3] == IEEE802154_TRANSACTION_OVERFLOW) {
 			dev_info(
 				&priv->spi->dev,
@@ -730,7 +730,7 @@ static void ca8210_rx_done(struct cas_control *cas_ctl)
 			mlme_reset_wpc->priv = priv;
 			queue_work(priv->mlme_workqueue, &mlme_reset_wpc->work);
 		}
-	} else if (buf[0] == SPI_HWME_WAKEUP_INDICATION) {
+	} else if (buf[0] == SPI_HWME_WAKEUP_INDICATION && len >= 3) {
 		dev_notice(
 			&priv->spi->dev,
 			"Wakeup indication received, reason:\n"
@@ -1859,6 +1859,10 @@ static int ca8210_net_rx(struct ieee802154_hw *hw, u8 *command, size_t len)
 
 	if (command[0] == SPI_MCPS_DATA_INDICATION) {
 		/* Received data */
+		if (len < 27) {
+			dev_warn(&priv->spi->dev, "short MCPS-DATA.indication\n");
+			return -EINVAL;
+		}
 		spin_lock_irqsave(&priv->lock, flags);
 		if (command[26] == priv->last_dsn) {
 			dev_dbg(
@@ -1873,6 +1877,10 @@ static int ca8210_net_rx(struct ieee802154_hw *hw, u8 *command, size_t len)
 		spin_unlock_irqrestore(&priv->lock, flags);
 		return ca8210_skb_rx(hw, len - 2, command + 2);
 	} else if (command[0] == SPI_MCPS_DATA_CONFIRM) {
+		if (len < 4) {
+			dev_warn(&priv->spi->dev, "short MCPS-DATA.confirm\n");
+			return -EINVAL;
+		}
 		status = command[3];
 		if (priv->async_tx_pending) {
 			return ca8210_async_xmit_complete(

-- 
2.34.1

