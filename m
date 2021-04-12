Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E912C43461
	for <linux-wpan@archiver.kernel.org>; Mon, 12 Apr 2021 16:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 432A96135D
	for <linux-wpan@archiver.kernel.org>; Mon, 12 Apr 2021 16:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243912AbhDLQac (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 12 Apr 2021 12:30:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244803AbhDLQ2u (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 12 Apr 2021 12:28:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 642A461287;
        Mon, 12 Apr 2021 16:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618244729;
        bh=tHxC6a5CetbsY9NAtC7pUJ4dm+zKe9K0KvMcAi2v7kw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TRu4TqqHt3FXgFYPWpreQONBx7niyZ0lEaal0g9QJNmgn8uMUXSXdMmdmp7BCL3A4
         +Cp1HNZEPD7mfYTsbm79KqhD0BEQ4hDUDKS3qEKeWVkLKwna1J8p6jyH4Nj1d6/QxU
         /hCg/FUrI/POHKmi621T67hHwPinSUTdn3N2LvQ8G9Y0eirNnExiYx5WduDpwPi/KU
         V5vSWDNhHIlDypRw94Utd2dF5rX3DZymhvBnDd6MtAXDsobThSVOcZeZNcBpozMK6B
         C4d3ACmArQBkB5SnhSYoRPQ8bxBbz/bHME9m5K3bVR90CWZsrWl0b8Jz1tXArVzWkg
         zK9Nvz1I5/xqw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Aring <aahringo@redhat.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <sashal@kernel.org>, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 21/39] net: ieee802154: forbid monitor for add llsec key
Date:   Mon, 12 Apr 2021 12:24:43 -0400
Message-Id: <20210412162502.314854-21-sashal@kernel.org>
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

[ Upstream commit 08470c5453339369bd3d590c4cbb0b5961cdcbb6 ]

This patch forbids to add llsec key for monitor interfaces which we
don't support yet. Otherwise we will access llsec mib which isn't
initialized for monitors.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
Link: https://lore.kernel.org/r/20210405003054.256017-5-aahringo@redhat.com
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ieee802154/nl802154.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 323d92177521..8758a805ef40 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -1568,6 +1568,9 @@ static int nl802154_add_llsec_key(struct sk_buff *skb, struct genl_info *info)
 	struct ieee802154_llsec_key_id id = { };
 	u32 commands[NL802154_CMD_FRAME_NR_IDS / 32] = { };
 
+	if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR)
+		return -EOPNOTSUPP;
+
 	if (!info->attrs[NL802154_ATTR_SEC_KEY] ||
 	    nla_parse_nested_deprecated(attrs, NL802154_KEY_ATTR_MAX, info->attrs[NL802154_ATTR_SEC_KEY], nl802154_key_policy, info->extack))
 		return -EINVAL;
-- 
2.30.2

