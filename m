Return-Path: <SRS0=upCO=YC=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529E6ECE58C
	for <linux-wpan@archiver.kernel.org>; Wed,  9 Oct 2019 17:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D87F20679
	for <linux-wpan@archiver.kernel.org>; Wed,  9 Oct 2019 17:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570642236;
	bh=a6QrCgvPtkiusi9ilJt4Zom9bVBDTpq53Np9aJQXGDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PHDRieKIGHqWv7pMPX9vP4bdc/ZaFVX7ReOQxHx7eqvx5LJRIOC3p6ddnugV0QVMx
	 SmshqCGIkLU7Vp4w1KvIZoC+Ngsm1xMywhQfjMI970Yq3+iGa6z3lZ5t4VPnMA0Q2u
	 rwqWxreOhsHwvPGpRgtNIhb1iC/yR/LRy0f2c66c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbfJIRYI (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:24:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732125AbfJIRYH (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 9 Oct 2019 13:24:07 -0400
Received: from sasha-vm.mshome.net (unknown [167.220.2.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA7D221920;
        Wed,  9 Oct 2019 17:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570641846;
        bh=a6QrCgvPtkiusi9ilJt4Zom9bVBDTpq53Np9aJQXGDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NN9YBSozt62eSN1cxa2QG/tYks6GvAcAasBM03FBuxyozX8KsSQN37JxJM3PI+mV5
         37k77AK+gq3f7Dm77XdAhxNMS6T1ruWSqNjo/VqHL8KkabbGD8ziU9NjL3ZUDCg000
         8NnizyrYeZFgc3SZ7we3xV0wgvaF9DPz1duh9Dp0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <sashal@kernel.org>, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 10/26] ieee802154: ca8210: prevent memory leak
Date:   Wed,  9 Oct 2019 13:05:42 -0400
Message-Id: <20191009170558.32517-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009170558.32517-1-sashal@kernel.org>
References: <20191009170558.32517-1-sashal@kernel.org>
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
index b2ff903a9cb6e..38a41651e451c 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -3151,12 +3151,12 @@ static int ca8210_probe(struct spi_device *spi_device)
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

