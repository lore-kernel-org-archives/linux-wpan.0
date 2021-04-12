Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6678BC433ED
	for <linux-wpan@archiver.kernel.org>; Mon, 12 Apr 2021 16:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4619D61288
	for <linux-wpan@archiver.kernel.org>; Mon, 12 Apr 2021 16:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245215AbhDLQcX (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 12 Apr 2021 12:32:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245099AbhDLQ3f (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 12 Apr 2021 12:29:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1A0D613A4;
        Mon, 12 Apr 2021 16:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618244737;
        bh=6sXssgNGIZQQU5yBT3xymXxq3nxlc7UkHwqlieFbOdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W2uJ4lsMXCLZpRq4wSiYFA7EjCFxyIKvrRqyy7Y1Mc40y2sZD9HzS4weKJM+5hJGR
         NbWJj7CKfxrdmFcMLrR+2Olh4Au3u4z8wvH41hXrxw06hBQvK+sv4sQo0zkAspgx1r
         TBfejnF2GCZ8GOXmMTNXHS3W6yuHF6V4Ez6tPNhWiaeI0DIsNUme07Z/mHmkh6h+vt
         pRb7X0+62yPiP/fPueT3WMAyiiiy8crT8v/OYgjwjoFmVjPt1Q+5tz3ZSQ7e65xEhC
         e7zh68tTaJw+wR2cFCzyyleQKQwQTuDOM89GQnhMsfGpXU0MC6q7M9sEUo/YyZ+w5V
         HKjnsJveBCDYQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Aring <aahringo@redhat.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <sashal@kernel.org>, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 28/39] net: ieee802154: forbid monitor for del llsec devkey
Date:   Mon, 12 Apr 2021 12:24:50 -0400
Message-Id: <20210412162502.314854-28-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210412162502.314854-1-sashal@kernel.org>
References: <20210412162502.314854-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

From: Alexander Aring <aahringo@redhat.com>

[ Upstream commit 6fb8045319ef172dc88a8142e7f8b58c7608137e ]

This patch forbids to del llsec devkey for monitor interfaces which we
don't support yet. Otherwise we will access llsec mib which isn't
initialized for monitors.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
Link: https://lore.kernel.org/r/20210405003054.256017-12-aahringo@redhat.com
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ieee802154/nl802154.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 6ab746517f13..39740c1fbebf 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -1965,6 +1965,9 @@ static int nl802154_del_llsec_devkey(struct sk_buff *skb, struct genl_info *info
 	struct ieee802154_llsec_device_key key;
 	__le64 extended_addr;
 
+	if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR)
+		return -EOPNOTSUPP;
+
 	if (!info->attrs[NL802154_ATTR_SEC_DEVKEY] ||
 	    nla_parse_nested_deprecated(attrs, NL802154_DEVKEY_ATTR_MAX, info->attrs[NL802154_ATTR_SEC_DEVKEY], nl802154_devkey_policy, info->extack))
 		return -EINVAL;
-- 
2.30.2

