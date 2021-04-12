Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6FBC43462
	for <linux-wpan@archiver.kernel.org>; Mon, 12 Apr 2021 16:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC01661289
	for <linux-wpan@archiver.kernel.org>; Mon, 12 Apr 2021 16:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245434AbhDLQnQ (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 12 Apr 2021 12:43:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343903AbhDLQgV (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 12 Apr 2021 12:36:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16723613DA;
        Mon, 12 Apr 2021 16:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618244840;
        bh=pwF+9dFds1bFPcubgGun9kjeESoaeQPe61bV6FXRelY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KAByFt6EqtAOJxa9QAaiU58RB4h+GegPDLJsYjH5loNZh6dp7RtKI298SjD7ebFeE
         M4x9BKQmTJwu+oP7Oc3GUbTkfqCWD8WWP0Fox93egLPE6ctRqdocPcSevDUa7EiDlj
         IhbuQV6Cvm+QidoJv00RggS7KKmN2SW+NTq2KkVx2LT0jfSlqBpWolvXYxaXRuZSpQ
         cSTgeVQDj9hj5knVJqY8GnLpQ/09IoSzRqL4EauLI+cfRSCbqp7LeA2SaRSZKX9OJN
         NFyuHe+x7cYfJ0+R/hdUgkGOJ/yWXRbDPO/rzFbobneDhRf7LoIB6TgEAqCC0sdC57
         rQL0AdMraSq3w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Aring <aahringo@redhat.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <sashal@kernel.org>, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 12/23] net: ieee802154: forbid monitor for add llsec dev
Date:   Mon, 12 Apr 2021 12:26:53 -0400
Message-Id: <20210412162704.315783-12-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210412162704.315783-1-sashal@kernel.org>
References: <20210412162704.315783-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

From: Alexander Aring <aahringo@redhat.com>

[ Upstream commit 5303f956b05a2886ff42890908156afaec0f95ac ]

This patch forbids to add llsec dev for monitor interfaces which we
don't support yet. Otherwise we will access llsec mib which isn't
initialized for monitors.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
Link: https://lore.kernel.org/r/20210405003054.256017-8-aahringo@redhat.com
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ieee802154/nl802154.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 65d7ca290591..45c014f65362 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -1793,6 +1793,9 @@ static int nl802154_add_llsec_dev(struct sk_buff *skb, struct genl_info *info)
 	struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
 	struct ieee802154_llsec_device dev_desc;
 
+	if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR)
+		return -EOPNOTSUPP;
+
 	if (ieee802154_llsec_parse_device(info->attrs[NL802154_ATTR_SEC_DEVICE],
 					  &dev_desc) < 0)
 		return -EINVAL;
-- 
2.30.2

