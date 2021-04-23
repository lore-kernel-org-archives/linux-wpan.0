Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91727C433B4
	for <linux-wpan@archiver.kernel.org>; Fri, 23 Apr 2021 04:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 680ED611C1
	for <linux-wpan@archiver.kernel.org>; Fri, 23 Apr 2021 04:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhDWESg (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 23 Apr 2021 00:18:36 -0400
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17471 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWESg (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 23 Apr 2021 00:18:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1619150551; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=ZIEV1VqcBVueTuzaxCi302mG8ZiPsAvvl6awFy+Iq6/Ey2jJ3q6aKfBUU7vkY/i7/d1VZFx8E7DYupPe/k2ZhqjswPK2Wz2Ssx9p5+gFKuw9IKrz2CWR/CYDw/bGkF4os1Huq5PhTlCrNgKVELPNIcLfNiPC71pZnNRbe6vbME4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1619150551; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=E8L6fO/gVM2h3d+1YhISXU4OnxVup+BhmSDFf9p91sI=; 
        b=M6GHt3vkKDomJWeKbwz7TMGF5F9guMCUIuYt3vPbpQrmjX65eOCFmq0DPPLYoWT1l4q4O+qS6WDxqHDFt6B79hwSK58j2EE/LsBwEBEKgOYWuQ29QqSFEPzIhgWAzgeXlZpN9Z+cxdEqhTqx72AYk6szIbFwwPVGf6w5vK/Ar1Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from gothmog.test (pool-173-66-46-118.washdc.fios.verizon.net [173.66.46.118]) by mx.zohomail.com
        with SMTPS id 1619150547870541.2296724124232; Thu, 22 Apr 2021 21:02:27 -0700 (PDT)
From:   Dan Robertson <dan@dlrobertson.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Cc:     Dan Robertson <dan@dlrobertson.com>
Subject: [PATCH 1/2] net: ieee802154: fix null deref in parse dev addr
Date:   Fri, 23 Apr 2021 00:02:13 -0400
Message-Id: <20210423040214.15438-2-dan@dlrobertson.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423040214.15438-1-dan@dlrobertson.com>
References: <20210423040214.15438-1-dan@dlrobertson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Fix a logic error that could result in a null deref if the user sets
the mode incorrectly for the given addr type.

Signed-off-by: Dan Robertson <dan@dlrobertson.com>
---
 net/ieee802154/nl802154.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 7c5a1aa5adb4..59639afb4600 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -1293,19 +1293,20 @@ ieee802154_llsec_parse_dev_addr(struct nlattr *nla,
 	if (!nla || nla_parse_nested_deprecated(attrs, NL802154_DEV_ADDR_ATTR_MAX, nla, nl802154_dev_addr_policy, NULL))
 		return -EINVAL;
 
-	if (!attrs[NL802154_DEV_ADDR_ATTR_PAN_ID] ||
-	    !attrs[NL802154_DEV_ADDR_ATTR_MODE] ||
-	    !(attrs[NL802154_DEV_ADDR_ATTR_SHORT] ||
-	      attrs[NL802154_DEV_ADDR_ATTR_EXTENDED]))
+	if (!attrs[NL802154_DEV_ADDR_ATTR_PAN_ID] || !attrs[NL802154_DEV_ADDR_ATTR_MODE])
 		return -EINVAL;
 
 	addr->pan_id = nla_get_le16(attrs[NL802154_DEV_ADDR_ATTR_PAN_ID]);
 	addr->mode = nla_get_u32(attrs[NL802154_DEV_ADDR_ATTR_MODE]);
 	switch (addr->mode) {
 	case NL802154_DEV_ADDR_SHORT:
+		if (!attrs[NL802154_DEV_ADDR_ATTR_SHORT])
+			return -EINVAL;
 		addr->short_addr = nla_get_le16(attrs[NL802154_DEV_ADDR_ATTR_SHORT]);
 		break;
 	case NL802154_DEV_ADDR_EXTENDED:
+		if (!attrs[NL802154_DEV_ADDR_ATTR_EXTENDED])
+			return -EINVAL;
 		addr->extended_addr = nla_get_le64(attrs[NL802154_DEV_ADDR_ATTR_EXTENDED]);
 		break;
 	default:
-- 
2.31.1

