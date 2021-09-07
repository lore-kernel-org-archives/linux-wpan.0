Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BB7C433FE
	for <linux-wpan@archiver.kernel.org>; Tue,  7 Sep 2021 10:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC168610E9
	for <linux-wpan@archiver.kernel.org>; Tue,  7 Sep 2021 10:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245598AbhIGK3W (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 7 Sep 2021 06:29:22 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:58974
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245750AbhIGK3W (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Sep 2021 06:29:22 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A17E53F106;
        Tue,  7 Sep 2021 10:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631010494;
        bh=0lEHRp9RVZruXFRyj3O2UNGVIAi8zooypFTJKD7Bh+Q=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=qzUbiDogJk/qrbWcv63BZLtFTmBLBI6fqRT3d4wqf9tVB6mxDIUq/qWtVNgcX7dB+
         TaatYDD1Rw7S8CZL0jxk50ojKSTgZ3VwsYHVk53XgSjA1eLYs9hqZHwTxQfn2C5PLS
         QGPPm1Loqc9f5fxt6motPj1QsFvsbBLpvdoVkQB5WWHOr96Tb00F+MGp2nc/hD/VBa
         Yfr7xny09Ikrx3YJuZmX4wOSxgfkqxFzU7N51BNYgqBKBHbzA85LNZboNS9Xr+DeqL
         8S7ZHTVuRTMkZl7zrV5195QpLUV0IblJhdMo2vwyI0ZZMAesy345OxpjroTc/Cx71o
         GjPdWj6JOmjpg==
From:   Colin King <colin.king@canonical.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ieee802154: Remove redundant initialization of variable ret
Date:   Tue,  7 Sep 2021 11:28:14 +0100
Message-Id: <20210907102814.14169-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable ret is being initialized with a value that is never read, it
is being updated later on. The assignment is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/mac802154/iface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 1cf5ac09edcb..323d3d2d986f 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -617,7 +617,7 @@ ieee802154_if_add(struct ieee802154_local *local, const char *name,
 {
 	struct net_device *ndev = NULL;
 	struct ieee802154_sub_if_data *sdata = NULL;
-	int ret = -ENOMEM;
+	int ret;
 
 	ASSERT_RTNL();
 
-- 
2.32.0

