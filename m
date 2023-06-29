Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E881FC001DE
	for <linux-wpan@archiver.kernel.org>; Thu, 29 Jun 2023 19:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjF2TDn (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 29 Jun 2023 15:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbjF2TCI (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 29 Jun 2023 15:02:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C5A3596;
        Thu, 29 Jun 2023 12:01:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80258615FD;
        Thu, 29 Jun 2023 19:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84788C433CC;
        Thu, 29 Jun 2023 19:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688065300;
        bh=Cl2JZtp7JTFAtrbbJEFEFkb7VgCs98txtHTIsGFO6tQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nnmuD8p2YQFfTe1sZS7MzA6AoWYngdie9FeSRP0FRc2KT5gtag1b6FwCNAutLuCib
         GudWkkYldYQ9F+9DeWqnxgQkSTFhlUIATwn/dYzmsx0fyUv/xVIKISJBoDFK6KTpRv
         xTbtRi4Rp0HD7oiRGzZ9RNZ/zTS+Z9fhnL2rw+Ig8vBrQ58NnT5731S+XhwdP/YQjD
         jPRiFYNUpyE7HVqKKoqsbLmZOms8015MFOAW43zSg+qcnIMWnzr5UPM0Y1DymDyJiD
         8sbH+bRfkkNMvDs6DpWkqqcllqI0LkteWWVw2TC192Oh3ZeLbhKRWMVwlKBh9yS5sg
         83k8iPkUGCOOw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, michael.hennerich@analog.com,
        alex.aring@gmail.com, stefan@datenfreihafen.org,
        miquel.raynal@bootlin.com, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/12] ieee802154/adf7242: Add MODULE_FIRMWARE macro
Date:   Thu, 29 Jun 2023 15:01:25 -0400
Message-Id: <20230629190134.907949-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190134.907949-1-sashal@kernel.org>
References: <20230629190134.907949-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.35
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

From: Juerg Haefliger <juerg.haefliger@canonical.com>

[ Upstream commit f593a94b530aee4c7f2511c9e48eb495dff03991 ]

The module loads firmware so add a MODULE_FIRMWARE macro to provide that
information via modinfo.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ieee802154/adf7242.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index 5cf218c674a5a..c246370cd48c6 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -1349,3 +1349,5 @@ module_spi_driver(adf7242_driver);
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("ADF7242 IEEE802.15.4 Transceiver Driver");
 MODULE_LICENSE("GPL");
+
+MODULE_FIRMWARE(FIRMWARE);
-- 
2.39.2

