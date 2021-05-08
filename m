Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA49C433ED
	for <linux-wpan@archiver.kernel.org>; Sat,  8 May 2021 06:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6A1E61464
	for <linux-wpan@archiver.kernel.org>; Sat,  8 May 2021 06:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbhEHG0l (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 8 May 2021 02:26:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18013 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhEHG0k (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 8 May 2021 02:26:40 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fccfz5WVBzQjFm;
        Sat,  8 May 2021 14:22:19 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 8 May 2021 14:25:27 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Jakub Kicinski" <kuba@kernel.org>,
        linux-wpan <linux-wpan@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] ieee802154: fix error return code in ieee802154_add_iface()
Date:   Sat, 8 May 2021 14:25:17 +0800
Message-ID: <20210508062517.2574-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: be51da0f3e34 ("ieee802154: Stop using NLA_PUT*().")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 net/ieee802154/nl-phy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ieee802154/nl-phy.c b/net/ieee802154/nl-phy.c
index 2cdc7e63fe17..88215b5c93aa 100644
--- a/net/ieee802154/nl-phy.c
+++ b/net/ieee802154/nl-phy.c
@@ -241,8 +241,10 @@ int ieee802154_add_iface(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (nla_put_string(msg, IEEE802154_ATTR_PHY_NAME, wpan_phy_name(phy)) ||
-	    nla_put_string(msg, IEEE802154_ATTR_DEV_NAME, dev->name))
+	    nla_put_string(msg, IEEE802154_ATTR_DEV_NAME, dev->name)) {
+		rc = -EMSGSIZE;
 		goto nla_put_failure;
+	}
 	dev_put(dev);
 
 	wpan_phy_put(phy);
-- 
2.25.1


