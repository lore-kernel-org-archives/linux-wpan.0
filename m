Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6953C43381
	for <linux-wpan@archiver.kernel.org>; Sun, 28 Feb 2021 15:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EDCA64D5D
	for <linux-wpan@archiver.kernel.org>; Sun, 28 Feb 2021 15:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhB1PT5 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 28 Feb 2021 10:19:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60666 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230408AbhB1PTy (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Sun, 28 Feb 2021 10:19:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614525508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oBgnfLo+d/dBvpawLqs1HKruHJv8Tx0bnqG3j9bT2vE=;
        b=Q0b0syh9QnWwaWvnCVPqftFcShHJ5JYJ37qppyWpK6PXXFbTP32uI87BoTm1XKDCa33HcG
        +yS1gWRdgmi4o3Hhyn9b8/ir+HtKlzCGKjerqPMz3FhI2kEd2oRacB+WmEn9Q7wo0dpWNC
        CzLL+Jog66SwAZEyME/1LJJu5zMlXyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-IUULfvWeOu67abUDtmYARA-1; Sun, 28 Feb 2021 10:18:23 -0500
X-MC-Unique: IUULfvWeOu67abUDtmYARA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C719E1936B61;
        Sun, 28 Feb 2021 15:18:22 +0000 (UTC)
Received: from carbon.redhat.com (ovpn-112-225.rdu2.redhat.com [10.10.112.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 628AB5C1D5;
        Sun, 28 Feb 2021 15:18:21 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     stefan@datenfreihafen.org
Cc:     linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH wpan 01/17] net: ieee802154: make shift exponent unsigned
Date:   Sun, 28 Feb 2021 10:18:01 -0500
Message-Id: <20210228151817.95700-2-aahringo@redhat.com>
In-Reply-To: <20210228151817.95700-1-aahringo@redhat.com>
References: <20210228151817.95700-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

This patch changes the iftype type variable to unsigned that it can
never be reach a negative value.

Reported-by: syzbot+7bf7b22759195c9a21e9@syzkaller.appspotmail.com
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 net/ieee802154/nl802154.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index e9e4652cd592..3ee09f6d13b7 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -898,8 +898,8 @@ static int nl802154_get_interface(struct sk_buff *skb, struct genl_info *info)
 static int nl802154_new_interface(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg802154_registered_device *rdev = info->user_ptr[0];
-	enum nl802154_iftype type = NL802154_IFTYPE_UNSPEC;
 	__le64 extended_addr = cpu_to_le64(0x0000000000000000ULL);
+	u32 type = NL802154_IFTYPE_UNSPEC;
 
 	/* TODO avoid failing a new interface
 	 * creation due to pending removal?
-- 
2.26.2

