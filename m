Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29907C433B4
	for <linux-wpan@archiver.kernel.org>; Mon,  5 Apr 2021 00:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2B656136A
	for <linux-wpan@archiver.kernel.org>; Mon,  5 Apr 2021 00:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhDEAbe (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 4 Apr 2021 20:31:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37308 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231771AbhDEAbV (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 4 Apr 2021 20:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617582675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TFv7cz9MPusINhDBE3YU+ou8WqCyc1JOsjs+Pyb7JmY=;
        b=X0YgSKrCcwQO5aRin+FiNL6+rTjr38Cc70YzLItqQNlzHsO9x0r13mbm8dPGBOPVIvjz+s
        GcYiLUvt0QI3YFjDF3gABT5ZIlB7TSTy3sjbSTqTzS85tZFjwUiPcNoW71DlVNBAN+Frso
        omPzWOiSW6HuKYmVpc5W87vMFvrJBQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-6qe8tAtaOsuSN8vAq-kB9w-1; Sun, 04 Apr 2021 20:31:12 -0400
X-MC-Unique: 6qe8tAtaOsuSN8vAq-kB9w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B678107ACCA;
        Mon,  5 Apr 2021 00:31:11 +0000 (UTC)
Received: from carbon.redhat.com (ovpn-113-102.rdu2.redhat.com [10.10.113.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB2C037DD;
        Mon,  5 Apr 2021 00:31:10 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     stefan@datenfreihafen.org
Cc:     linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH RESEND wpan 11/15] net: ieee802154: forbid monitor for del llsec devkey
Date:   Sun,  4 Apr 2021 20:30:50 -0400
Message-Id: <20210405003054.256017-12-aahringo@redhat.com>
In-Reply-To: <20210405003054.256017-1-aahringo@redhat.com>
References: <20210405003054.256017-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

This patch forbids to del llsec devkey for monitor interfaces which we
don't support yet. Otherwise we will access llsec mib which isn't
initialized for monitors.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 net/ieee802154/nl802154.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index c3f9bff7a557..88735f03b73e 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -1949,6 +1949,9 @@ static int nl802154_del_llsec_devkey(struct sk_buff *skb, struct genl_info *info
 	struct ieee802154_llsec_device_key key;
 	__le64 extended_addr;
 
+	if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR)
+		return -EOPNOTSUPP;
+
 	if (!info->attrs[NL802154_ATTR_SEC_DEVKEY] ||
 	    nla_parse_nested_deprecated(attrs, NL802154_DEVKEY_ATTR_MAX, info->attrs[NL802154_ATTR_SEC_DEVKEY], nl802154_devkey_policy, info->extack))
 		return -EINVAL;
-- 
2.26.3

