Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3292C4332F
	for <linux-wpan@archiver.kernel.org>; Mon, 21 Nov 2022 00:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiKUAWe (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 20 Nov 2022 19:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiKUAWc (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 20 Nov 2022 19:22:32 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DE4E60
        for <linux-wpan@vger.kernel.org>; Sun, 20 Nov 2022 16:22:31 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4NFp4J5ncyz9sWT;
        Mon, 21 Nov 2022 01:22:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1668990144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=C7ODrpMGf0fX5PDFmhbtmDt3sowIiWDtlKe+0QzH04c=;
        b=d2pkUgy3n/FsW6lADOiYoAwcdggC/DNmUx7sbxEPUzwjqhmxS6wKrgurzfoPOpzoooNIFz
        U0hL0lSZQMbF3PNEKui91Kj5wks+OvhznpFiZKgOzldX0WyHaDQPC8zc6sNB+Xf5PuqkhE
        xPDdiFG8HwQPWNyWuwllY+KHJYE2RJZN9OfWoTR3EruTelXQb0rDg8/wnr3hd01M/MVg4V
        aMsguMc1a4ayelZQw+LPrKLLmAuwQqMVSiOoxJ+YVNvTW6FAjJXnUgnRI8FplNYlREYvpp
        9aP5AQn4eP+D1+N759xsx7yTEWX5cWrSndKjPFmNFleu9L1M/KfSuRBGnzgWnA==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     alex.aring@gmail.com, stefan@datenfreihafen.org
Cc:     linux-wpan@vger.kernel.org, harrymorris12@gmail.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] ca8210: Fix crash by zero initializing data
Date:   Mon, 21 Nov 2022 01:22:01 +0100
Message-Id: <20221121002201.1339636-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4NFp4J5ncyz9sWT
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

The struct cas_control embeds multiple generic SPI structures and we
have to make sure these structures are initialized to default values.
This driver does not set all attributes. When using kmalloc before some
attributes were not initialized and contained random data which caused
random crashes at bootup.

Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/net/ieee802154/ca8210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 450b16ad40a4..e1a569b99e4a 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -885,7 +885,7 @@ static int ca8210_spi_transfer(
 
 	dev_dbg(&spi->dev, "%s called\n", __func__);
 
-	cas_ctl = kmalloc(sizeof(*cas_ctl), GFP_ATOMIC);
+	cas_ctl = kzalloc(sizeof(*cas_ctl), GFP_ATOMIC);
 	if (!cas_ctl)
 		return -ENOMEM;
 
-- 
2.35.1

