Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02125C43462
	for <linux-wpan@archiver.kernel.org>; Mon, 12 Apr 2021 16:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D310E6134F
	for <linux-wpan@archiver.kernel.org>; Mon, 12 Apr 2021 16:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343787AbhDLQnc (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 12 Apr 2021 12:43:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244193AbhDLQhv (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 12 Apr 2021 12:37:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6030C613DC;
        Mon, 12 Apr 2021 16:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618244874;
        bh=lhtX/OPV2ZQfXFQ3AlnVnaqsm6+ABCZQ2nSHmsSLkIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oLyF1tGU/UhEX51Dyh3sfZN/q/jGDEEHIvKtn+2cVSmynJLSsjUX6Uhu/FCx+MTYL
         OT85H9YTZICyoww5sI5mi6orlXP2C3ahK1+4W0EQ9ov2nKm6ZDi1zQ+ft7GZA0qzz/
         5ou15KiSh13q7BnnIo0ehtuMBlrZrS9cOdIETcMsJv8R4slvitoyZWLh9dNTih5xpl
         fNJBicKHlnRfA4Wr8OawbVLXL4NZN6qnrg/KbMx8B8OR2z+f5Mp0Xvs1AjOeQmdcjD
         jWe5t8CqbOcgEeahoDWw/9mEb/FbBByVFVRHTU5QRSsU5Cjouz+beP6MZIUwbClz3/
         3PJqCX79VccgQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Aring <aahringo@redhat.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <sashal@kernel.org>, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 13/23] net: ieee802154: stop dump llsec devkeys for monitors
Date:   Mon, 12 Apr 2021 12:27:26 -0400
Message-Id: <20210412162736.316026-13-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210412162736.316026-1-sashal@kernel.org>
References: <20210412162736.316026-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

From: Alexander Aring <aahringo@redhat.com>

[ Upstream commit 080d1a57a94d93e70f84b7a360baa351388c574f ]

This patch stops dumping llsec devkeys for monitors which we don't support
yet. Otherwise we will access llsec mib which isn't initialized for
monitors.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
Link: https://lore.kernel.org/r/20210405003054.256017-10-aahringo@redhat.com
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ieee802154/nl802154.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 8d22b1a68835..db45cb0d20b2 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -1831,6 +1831,11 @@ nl802154_dump_llsec_devkey(struct sk_buff *skb, struct netlink_callback *cb)
 	if (err)
 		return err;
 
+	if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR) {
+		err = skb->len;
+		goto out_err;
+	}
+
 	if (!wpan_dev->netdev) {
 		err = -EINVAL;
 		goto out_err;
-- 
2.30.2

