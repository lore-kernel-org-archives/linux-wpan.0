Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DBBC433ED
	for <linux-wpan@archiver.kernel.org>; Mon, 12 Apr 2021 16:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24716611AD
	for <linux-wpan@archiver.kernel.org>; Mon, 12 Apr 2021 16:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245149AbhDLQeC (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 12 Apr 2021 12:34:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245139AbhDLQbz (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 12 Apr 2021 12:31:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CBC8613AD;
        Mon, 12 Apr 2021 16:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618244780;
        bh=PpqaGiOjnfLNVyvOqEIrI5mc3b+VlvEadeVSW7AucP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=quxrMqUZOk8WKPqkW6bFfWVruHz6kXdKouUaIUPwrwDOdGpiwpmFHL0zz8k2kcmQt
         HTqfuMgjiOxScGAUoFqoG0rqJa1hbgKi9Nmh/srTujKQF2l/m1UGgWrNVJ/bcx6lwc
         HTP8JaNE/fd0jOSiaEg6xAzJBwzM0IosxuBzRX4PAeJoqxB3txbkgkjdMIlss4WDMr
         yxsrEaGzG0wL76V3yY0ylPaBL2ziZafnIsvULsSRrqeq4+rDv/tELz6HpfCfq5hkuU
         3lAHNUw0vANeXlpajCrcsLWxLh/wuvUHQnk/3GgTMQzmMw5DbvZ77okjh3XFODajCi
         6VS0Wa8vOVsZA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Aring <aahringo@redhat.com>,
        syzbot+fbf4fc11a819824e027b@syzkaller.appspotmail.com,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <sashal@kernel.org>, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 21/28] net: ieee802154: forbid monitor for del llsec seclevel
Date:   Mon, 12 Apr 2021 12:25:46 -0400
Message-Id: <20210412162553.315227-21-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210412162553.315227-1-sashal@kernel.org>
References: <20210412162553.315227-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

From: Alexander Aring <aahringo@redhat.com>

[ Upstream commit 9dde130937e95b72adfae64ab21d6e7e707e2dac ]

This patch forbids to del llsec seclevel for monitor interfaces which we
don't support yet. Otherwise we will access llsec mib which isn't
initialized for monitors.

Reported-by: syzbot+fbf4fc11a819824e027b@syzkaller.appspotmail.com
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Link: https://lore.kernel.org/r/20210405003054.256017-15-aahringo@redhat.com
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ieee802154/nl802154.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 8cf71f637ead..138aa41fb6f7 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -2147,6 +2147,9 @@ static int nl802154_del_llsec_seclevel(struct sk_buff *skb,
 	struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
 	struct ieee802154_llsec_seclevel sl;
 
+	if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR)
+		return -EOPNOTSUPP;
+
 	if (!info->attrs[NL802154_ATTR_SEC_LEVEL] ||
 	    llsec_parse_seclevel(info->attrs[NL802154_ATTR_SEC_LEVEL],
 				 &sl) < 0)
-- 
2.30.2

