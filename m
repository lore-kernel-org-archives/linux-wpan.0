Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1787DC433E0
	for <linux-wpan@archiver.kernel.org>; Sun, 21 Feb 2021 17:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E104B64DEC
	for <linux-wpan@archiver.kernel.org>; Sun, 21 Feb 2021 17:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhBURpF (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 21 Feb 2021 12:45:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35403 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230048AbhBURpD (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Sun, 21 Feb 2021 12:45:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613929417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kC1IciXwSgqh1cf2oV26qX3+nmiu8X6Q9+wLyd6B43g=;
        b=W4p3EwvJ/+0ifeDamnMlx3pgJNosFwguSsSyP71578kOezt6MARar+ZyIUdAFbvi4FgBxz
        KAe8IGWVqbKQaDMfMOL2Yp/lx70/F3DfTDS+Cfv9rFARTSpkViVZaucHBZ/FP6W7esJmwH
        4WLlhLwSMawi4cR+2qXEdwUY8wNkW3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-bDCVZ6gpPv6woaX7x1ZsQQ-1; Sun, 21 Feb 2021 12:43:35 -0500
X-MC-Unique: bDCVZ6gpPv6woaX7x1ZsQQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F9C818449E9;
        Sun, 21 Feb 2021 17:43:34 +0000 (UTC)
Received: from carbon.redhat.com (ovpn-112-235.rdu2.redhat.com [10.10.112.235])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB89C19CB0;
        Sun, 21 Feb 2021 17:43:33 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     stefan@datenfreihafen.org
Cc:     linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH wpan 3/4] net: ieee802154: fix nl802154 add llsec key
Date:   Sun, 21 Feb 2021 12:43:20 -0500
Message-Id: <20210221174321.14210-3-aahringo@redhat.com>
In-Reply-To: <20210221174321.14210-1-aahringo@redhat.com>
References: <20210221174321.14210-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

This patch fixes a nullpointer dereference if NL802154_ATTR_SEC_KEY is
not set by the user. If this is the case nl802154 will return -EINVAL.

Reported-by: syzbot+ce4e062c2d51977ddc50@syzkaller.appspotmail.com
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 net/ieee802154/nl802154.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 063b12cba71f..3f6d86d63923 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -1544,7 +1544,8 @@ static int nl802154_add_llsec_key(struct sk_buff *skb, struct genl_info *info)
 	struct ieee802154_llsec_key_id id = { };
 	u32 commands[NL802154_CMD_FRAME_NR_IDS / 32] = { };
 
-	if (nla_parse_nested_deprecated(attrs, NL802154_KEY_ATTR_MAX, info->attrs[NL802154_ATTR_SEC_KEY], nl802154_key_policy, info->extack))
+	if (!info->attrs[NL802154_ATTR_SEC_KEY] ||
+	    nla_parse_nested_deprecated(attrs, NL802154_KEY_ATTR_MAX, info->attrs[NL802154_ATTR_SEC_KEY], nl802154_key_policy, info->extack))
 		return -EINVAL;
 
 	if (!attrs[NL802154_KEY_ATTR_USAGE_FRAMES] ||
-- 
2.26.2

