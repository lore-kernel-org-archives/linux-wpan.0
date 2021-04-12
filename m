Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2067C43461
	for <linux-wpan@archiver.kernel.org>; Mon, 12 Apr 2021 16:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA2416101B
	for <linux-wpan@archiver.kernel.org>; Mon, 12 Apr 2021 16:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244175AbhDLQgy (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 12 Apr 2021 12:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245052AbhDLQd4 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 12 Apr 2021 12:33:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DAE5613BF;
        Mon, 12 Apr 2021 16:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618244804;
        bh=cipkI2R4wewVzpszPx2BUvIZojTZ/k31RMG6xNHv1G0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MZddKRpurAy7sxgWK5q2Izp8/K406lNx+fENbduUqvlJNHhi7guRSHo38QaHdYnNO
         5dLv9Ca96M7FQG0WtcbK0qgiEDVxU1+MdQkXg8wvTRUcHnsXfRM/3WgSaWO3ZIGkJU
         U9wYimbC+dcG98wAHqXMt/FKGRWlPcJopHf7VrC29udCqH8NkSZEOg8T2Jyl1sPqTr
         ycqBtjlFP+bbSvtKFFZYcW8zIX1b2aLqK2/kajZ8ONn/hk5zAJ/6+235zXRXFAyNwY
         TrqlNOnGeayo5IlCD5/8A5nvJPsIfIHkyB3ubp3Qo8R256mbQpZdX7ufI/SG2wglAw
         cuYakVtAtCNiw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Aring <aahringo@redhat.com>,
        syzbot+8b6719da8a04beeafcc3@syzkaller.appspotmail.com,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <sashal@kernel.org>, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 10/25] net: ieee802154: forbid monitor for set llsec params
Date:   Mon, 12 Apr 2021 12:26:15 -0400
Message-Id: <20210412162630.315526-10-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210412162630.315526-1-sashal@kernel.org>
References: <20210412162630.315526-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

From: Alexander Aring <aahringo@redhat.com>

[ Upstream commit 88c17855ac4291fb462e13a86b7516773b6c932e ]

This patch forbids to set llsec params for monitor interfaces which we
don't support yet.

Reported-by: syzbot+8b6719da8a04beeafcc3@syzkaller.appspotmail.com
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Link: https://lore.kernel.org/r/20210405003054.256017-3-aahringo@redhat.com
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ieee802154/nl802154.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 99f6c254ea77..e07624fd8b3b 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -1402,6 +1402,9 @@ static int nl802154_set_llsec_params(struct sk_buff *skb,
 	u32 changed = 0;
 	int ret;
 
+	if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR)
+		return -EOPNOTSUPP;
+
 	if (info->attrs[NL802154_ATTR_SEC_ENABLED]) {
 		u8 enabled;
 
-- 
2.30.2

