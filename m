Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05507C07E99
	for <linux-wpan@archiver.kernel.org>; Mon, 12 Jul 2021 12:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4EBC60D07
	for <linux-wpan@archiver.kernel.org>; Mon, 12 Jul 2021 12:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhGLMRj (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 12 Jul 2021 08:17:39 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:53964
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230074AbhGLMRh (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 12 Jul 2021 08:17:37 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 5174B405AE;
        Mon, 12 Jul 2021 12:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626092081;
        bh=9cd7SB+YDylOyt5Q5dBTF8mzwTTXz59sqh18sE/UjxM=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=siSb/6wSXYwWx+DNORGB6EzQlm7CHMJFGVlLZNSB05IJkhUNQhl/VaepdhWdi0u7X
         SIeKZP1dWfcSa+LuFRtWFNz40UMNjioQoGJe9Y5nAT40qp5bgEvqjAfjlA1MJjRgSW
         92a7aGdOqs/aU0yDuJYB9T3Z3EaUbsFZvWNOLUdvGHK44UScXBK1UFHKSvisxDczLn
         sp3T2G4Vb6tw5SkMh9oocoZMduXmS1VQwZbNVdLay2/kxdAyVGX5k8rnqP9YeL6cqw
         GV0iwaXi0msLt1PtoEnn9Gv75RqGozxf5JnSzSiKw9/HKdRr53tuZZYcLyDrJRe3OW
         3Hrm6BaTEIYvg==
From:   Colin King <colin.king@canonical.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stefan Schmidt <stefan@osg.samsung.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 6lowpan: iphc: Fix an off-by-one check of array index
Date:   Mon, 12 Jul 2021 13:14:40 +0100
Message-Id: <20210712121440.17860-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The bounds check of id is off-by-one and the comparison should
be >= rather >. Currently the WARN_ON_ONCE check does not stop
the out of range indexing of &ldev->ctx.table[id] so also add
a return path if the bounds are out of range.

Addresses-Coverity: ("Illegal address computation").
Fixes: 5609c185f24d ("6lowpan: iphc: add support for stateful compression")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/6lowpan/debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/6lowpan/debugfs.c b/net/6lowpan/debugfs.c
index 1c140af06d52..600b9563bfc5 100644
--- a/net/6lowpan/debugfs.c
+++ b/net/6lowpan/debugfs.c
@@ -170,7 +170,8 @@ static void lowpan_dev_debugfs_ctx_init(struct net_device *dev,
 	struct dentry *root;
 	char buf[32];
 
-	WARN_ON_ONCE(id > LOWPAN_IPHC_CTX_TABLE_SIZE);
+	if (WARN_ON_ONCE(id >= LOWPAN_IPHC_CTX_TABLE_SIZE))
+		return;
 
 	sprintf(buf, "%d", id);
 
-- 
2.31.1

