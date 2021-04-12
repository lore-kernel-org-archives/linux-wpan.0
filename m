Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CC9C433B4
	for <linux-wpan@archiver.kernel.org>; Mon, 12 Apr 2021 16:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76E0D61287
	for <linux-wpan@archiver.kernel.org>; Mon, 12 Apr 2021 16:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245140AbhDLQbz (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 12 Apr 2021 12:31:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245114AbhDLQ3i (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 12 Apr 2021 12:29:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E68C861385;
        Mon, 12 Apr 2021 16:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618244742;
        bh=K9hruNFB2SNHzSlGpoQ1TL2NIZHmho+lZR+azaSuYtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AOT3CN+3mrlRbVRHxUVWwyJBcEvYJwDU3QM3MTGb5p5B/7oV//PDf2aNd0szfGnI6
         VfePxl7ol1obt/ZSjCwfTvSTiebUFOuvA9tRYcNpNil6W2qFo8l9JpDfRIw1tvWULd
         wilCz87IDINAr4HtFmTBb+/8fqAQYL6UsgsHAQ917I5RhvX6qAQY1BWg0hTOZFyvuA
         fhkM2oNaq5RdMahBlC/qGWTZ14iq2vtBJRE3XyblELh184sOlMIUCVfw4o7WhuwpNW
         xIKI98v39mTCbCG3i9Z0C7oo+lSnoLAxmPVkDKhnHqcqnWlQ6v3dA9CI9Q6AmnIQKS
         +rMCKE+0KTs3A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Aring <aahringo@redhat.com>,
        syzbot+cde43a581a8e5f317bc2@syzkaller.appspotmail.com,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <sashal@kernel.org>, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 32/39] net: ieee802154: stop dump llsec params for monitors
Date:   Mon, 12 Apr 2021 12:24:54 -0400
Message-Id: <20210412162502.314854-32-sashal@kernel.org>
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

[ Upstream commit 1534efc7bbc1121e92c86c2dabebaf2c9dcece19 ]

This patch stops dumping llsec params for monitors which we don't support
yet. Otherwise we will access llsec mib which isn't initialized for
monitors.

Reported-by: syzbot+cde43a581a8e5f317bc2@syzkaller.appspotmail.com
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Link: https://lore.kernel.org/r/20210405003054.256017-16-aahringo@redhat.com
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ieee802154/nl802154.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index d9f05390144e..328bb9f5342e 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -836,8 +836,13 @@ nl802154_send_iface(struct sk_buff *msg, u32 portid, u32 seq, int flags,
 		goto nla_put_failure;
 
 #ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
+	if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR)
+		goto out;
+
 	if (nl802154_get_llsec_params(msg, rdev, wpan_dev) < 0)
 		goto nla_put_failure;
+
+out:
 #endif /* CONFIG_IEEE802154_NL802154_EXPERIMENTAL */
 
 	genlmsg_end(msg, hdr);
-- 
2.30.2

