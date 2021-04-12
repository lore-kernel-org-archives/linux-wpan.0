Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BA5C433B4
	for <linux-wpan@archiver.kernel.org>; Mon, 12 Apr 2021 16:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B440B611AD
	for <linux-wpan@archiver.kernel.org>; Mon, 12 Apr 2021 16:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245096AbhDLQeA (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 12 Apr 2021 12:34:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245132AbhDLQbz (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 12 Apr 2021 12:31:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10148613A6;
        Mon, 12 Apr 2021 16:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618244777;
        bh=qgkCEU+nWLpn9PzoFx7Ncz2ZBYf6M6VMQcu98tEMbsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=irYrEKiQTc7e3LcG/fuKop+YrHISxSuuzLoEF8kJHAn9DI3CW4o9S/lis47hNZyx+
         XfCKSwTUxwb+cVEqFb2Yl55B1Op1etuIcuwMvdz/2thfSREc2ayvpwsT9G7KvOAhtk
         2O45NDdm89yYD/pzdGihMcskQnc1HcNO3xyM1PEJovGPi3DJzwTDQqhU1cEWIOsVA+
         /liTS661ntQRxR76GVLdv6rrwy13XWQzjEOddgHC5La1J7+CVJci2AgBKMagHJzfnO
         Ykg+03NsCSUVJyi6xdxLpAIeK+WGgknGtxcG+C8YGqha20ekDWS9iqU/TOIFEyYu0u
         P9UM4EMz/8k3A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Aring <aahringo@redhat.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Sasha Levin <sashal@kernel.org>, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 19/28] net: ieee802154: stop dump llsec seclevels for monitors
Date:   Mon, 12 Apr 2021 12:25:44 -0400
Message-Id: <20210412162553.315227-19-sashal@kernel.org>
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

[ Upstream commit 4c9b4f55ad1f5a4b6206ac4ea58f273126d21925 ]

This patch stops dumping llsec seclevels for monitors which we don't
support yet. Otherwise we will access llsec mib which isn't initialized
for monitors.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
Link: https://lore.kernel.org/r/20210405003054.256017-13-aahringo@redhat.com
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ieee802154/nl802154.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 07139905e63e..c47f83bd21df 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -2039,6 +2039,11 @@ nl802154_dump_llsec_seclevel(struct sk_buff *skb, struct netlink_callback *cb)
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

