Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:35538 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbaJ0Lni (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Oct 2014 07:43:38 -0400
Received: by mail-la0-f54.google.com with SMTP id gm9so5676440lab.27
        for <linux-wpan@vger.kernel.org>; Mon, 27 Oct 2014 04:43:37 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 02/16] ieee802154: drivers: use dev_alloc_skb
Date: Mon, 27 Oct 2014 12:42:55 +0100
Message-Id: <1414410189-20092-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414410189-20092-1-git-send-email-alex.aring@gmail.com>
References: <1414410189-20092-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Alan Ott <alan@signal11.us>

This patch change the allocation of skb inside the ieee802154 driver
layer to dev_alloc_skb. This changes also the gfp mask to GFP_ATOMIC
which is needed for upcomming change that the receiving is done by a
tasklet and not a workqueue anymore.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Cc: Alan Ott <alan@signal11.us>
---
 drivers/net/ieee802154/at86rf230.c | 2 +-
 drivers/net/ieee802154/cc2520.c    | 2 +-
 drivers/net/ieee802154/mrf24j40.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 0669783..e4fbcaa 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -811,7 +811,7 @@ at86rf230_rx(struct at86rf230_local *lp,
 	memcpy(rx_local_buf, data, len);
 	enable_irq(lp->spi->irq);
 
-	skb = alloc_skb(IEEE802154_MTU, GFP_ATOMIC);
+	skb = dev_alloc_skb(IEEE802154_MTU);
 	if (!skb) {
 		dev_vdbg(&lp->spi->dev, "failed to allocate sk_buff\n");
 		return;
diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index f6f07f4..a31b5b6 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -524,7 +524,7 @@ static int cc2520_rx(struct cc2520_private *priv)
 	if (len < 2 || len > IEEE802154_MTU)
 		return -EINVAL;
 
-	skb = alloc_skb(len, GFP_KERNEL);
+	skb = dev_alloc_skb(len);
 	if (!skb)
 		return -ENOMEM;
 
diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index 3d775af..7abb237 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -544,7 +544,7 @@ static int mrf24j40_handle_rx(struct mrf24j40 *devrec)
 	val |= 4; /* SET RXDECINV */
 	write_short_reg(devrec, REG_BBREG1, val);
 
-	skb = alloc_skb(len, GFP_KERNEL);
+	skb = dev_alloc_skb(len);
 	if (!skb) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.1.2

