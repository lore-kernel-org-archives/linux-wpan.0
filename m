Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268D7C001B1
	for <linux-wpan@archiver.kernel.org>; Thu, 29 Jun 2023 19:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjF2TGB (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 29 Jun 2023 15:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbjF2TEr (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 29 Jun 2023 15:04:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBA54227;
        Thu, 29 Jun 2023 12:02:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2941B61600;
        Thu, 29 Jun 2023 19:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9DEC433C0;
        Thu, 29 Jun 2023 19:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688065328;
        bh=ZBPDjQTOm9nfTKy8pCEe02sdJ5H5tTrv77pYuNH3HnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=peqewKITAUOETW8PP5dmprk4OAB/q/YM/RbZE+oSjw3ks15fKe+1cNF9CI+OOT5z3
         e2nMcp4PGN59CcqGkG6qX/riosbVdUTGP5paFoGJ/8QRD5fUDOABL2vSOs3hZJIpXJ
         rljmmGB9mxrLuZyROHGThK4bGYejNcUvW3lwPPJi8+1yRIh4hLpK9AYNg6UfB0wibs
         nyc3MtAJZ5lnQrHqaxytN67bYFp+NivAdn/HduXlJj7r9r1rQ9IfbQ5WSyYNtq2JYq
         LQeCVyWPbk9VellvKh/yAzlgK34oogyL8Yl+soo8KHgx5YWcThWVnJY3nVlmwc60z4
         EpySJLjO/GVjQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, michael.hennerich@analog.com,
        alex.aring@gmail.com, stefan@datenfreihafen.org,
        miquel.raynal@bootlin.com, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/4] ieee802154/adf7242: Add MODULE_FIRMWARE macro
Date:   Thu, 29 Jun 2023 15:02:02 -0400
Message-Id: <20230629190206.908243-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190206.908243-1-sashal@kernel.org>
References: <20230629190206.908243-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.185
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
index 07adbeec19787..7140573eca72b 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -1351,3 +1351,5 @@ module_spi_driver(adf7242_driver);
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("ADF7242 IEEE802.15.4 Transceiver Driver");
 MODULE_LICENSE("GPL");
+
+MODULE_FIRMWARE(FIRMWARE);
-- 
2.39.2

