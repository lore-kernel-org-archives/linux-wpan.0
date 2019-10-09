Return-Path: <SRS0=upCO=YC=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2269AC47404
	for <linux-wpan@archiver.kernel.org>; Wed,  9 Oct 2019 17:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E387E218AC
	for <linux-wpan@archiver.kernel.org>; Wed,  9 Oct 2019 17:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570642080;
	bh=RsWxyvsNqS4MVQex/5Iit5lyMZbtGMxsHGAwjyXuaNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LN7nOy0wrpOy37ivUBY4MBMF8LWtRMFK/qQSQzW+8A3S+p4wRCcCWAF/61gdBNgMJ
	 GfXX++zRdfxf7dfsAj5IfPWyxkVD7rPFQGN3Y7S1qPdzrgqiwZDwydnY03iqgdvGul
	 kMYYD2Y85sl3BLhudKyTK2cDhJLsF3xFDTDY/BOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732317AbfJIRY0 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:24:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732311AbfJIRY0 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 9 Oct 2019 13:24:26 -0400
Received: from sasha-vm.mshome.net (unknown [167.220.2.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE516218AC;
        Wed,  9 Oct 2019 17:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570641866;
        bh=RsWxyvsNqS4MVQex/5Iit5lyMZbtGMxsHGAwjyXuaNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T0Y1l2YkwWsY89TOH4BTSV74p1nbEOeKVfRfntd+dJdtl4Q1YG12dO5oYyFRL+6Wk
         MzxETG4piLFybN/VC737a7GGaBa82vDcAr9QzdobAlWPv5hVbfvd5dDsagl/MnZ4wN
         quVyYy+TRpL3l3EdgrhnTb9Icik7o8is3jluBd1Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <sashal@kernel.org>, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 08/21] ieee802154: ca8210: prevent memory leak
Date:   Wed,  9 Oct 2019 13:06:01 -0400
Message-Id: <20191009170615.32750-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009170615.32750-1-sashal@kernel.org>
References: <20191009170615.32750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 6402939ec86eaf226c8b8ae00ed983936b164908 ]

In ca8210_probe the allocated pdata needs to be assigned to
spi_device->dev.platform_data before calling ca8210_get_platform_data.
Othrwise when ca8210_get_platform_data fails pdata cannot be released.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Link: https://lore.kernel.org/r/20190917224713.26371-1-navid.emamdoost@gmail.com
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ieee802154/ca8210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index dcd10dba08c72..3a58962babd41 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -3153,12 +3153,12 @@ static int ca8210_probe(struct spi_device *spi_device)
 		goto error;
 	}
 
+	priv->spi->dev.platform_data = pdata;
 	ret = ca8210_get_platform_data(priv->spi, pdata);
 	if (ret) {
 		dev_crit(&spi_device->dev, "ca8210_get_platform_data failed\n");
 		goto error;
 	}
-	priv->spi->dev.platform_data = pdata;
 
 	ret = ca8210_dev_com_init(priv);
 	if (ret) {
-- 
2.20.1

