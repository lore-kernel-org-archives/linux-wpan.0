Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDBBC43461
	for <linux-wpan@archiver.kernel.org>; Mon, 12 Apr 2021 16:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EDA461042
	for <linux-wpan@archiver.kernel.org>; Mon, 12 Apr 2021 16:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245460AbhDLQnX (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 12 Apr 2021 12:43:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343991AbhDLQga (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 12 Apr 2021 12:36:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7AF7613DF;
        Mon, 12 Apr 2021 16:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618244848;
        bh=45e6Hh0CKmkAgKn0MXMaj47zj9JvuHtACDklel0VDuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cm8jR0btHLqmlc2/pA8J5Jrt2VcxGOpxx0Ame1I8R/uu25A9yEfLjFzCVFiEa9Rw/
         zFVJpzv4oSjHOmxJdCxavO5YElmAt0xPFIVHQ5ac2mFrD8U7KcUfi87t7gAEoNoRTz
         xfkz8ImYJWCrxEB4RkgudTOc3Jpj1WVJXFpevctati6xhB1vuCa4lGLLLE9iZiDJPP
         Mjk+w3L53BANPMvZf2sWoTVoCcHVHcJSUqViBdd3/NONDX+q9qXjHl46uCSytM7Kkj
         hxIClgunT0WpqkLrDE1e9na9xFboWBitkouZXS6kJjmFHc9WUh+LsJYCp3Apaf2euW
         Y6/xi/7OFz9FQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Aring <aahringo@redhat.com>,
        syzbot+cde43a581a8e5f317bc2@syzkaller.appspotmail.com,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <sashal@kernel.org>, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 18/23] net: ieee802154: stop dump llsec params for monitors
Date:   Mon, 12 Apr 2021 12:26:59 -0400
Message-Id: <20210412162704.315783-18-sashal@kernel.org>
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
index 2fad9f40acac..706d6d9aa4b9 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -851,8 +851,13 @@ nl802154_send_iface(struct sk_buff *msg, u32 portid, u32 seq, int flags,
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

