Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1705C433F5
	for <linux-wpan@archiver.kernel.org>; Fri, 12 Nov 2021 03:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 725D260F4A
	for <linux-wpan@archiver.kernel.org>; Fri, 12 Nov 2021 03:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhKLDMY (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 11 Nov 2021 22:12:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41407 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234519AbhKLDMX (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 11 Nov 2021 22:12:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636686573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cbFf9Y4tfnJWIhVRV32+TdEo+eOJtRq0/nlJWQrVoKs=;
        b=MdjdCdO1w/f+l8ML+0SaQbgFgsZ8X3kOta2slUHKMrnrqHDu2TuB9lYs7wxIbMNfmKksLN
        BzAn+OWsI+ncm9KrW5Fzr3viPLx3apA1GPjs7Cc38C7UDQ9qbYCHoQ1OtMkp+SgUMgtJmD
        Jz0A4X5S1lbu1oQQQ8G/4VyCDmBFS/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-8nK3_GGjMnCvdz58Gbpk0A-1; Thu, 11 Nov 2021 22:09:29 -0500
X-MC-Unique: 8nK3_GGjMnCvdz58Gbpk0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69E1A15720;
        Fri, 12 Nov 2021 03:09:28 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E63125D6D7;
        Fri, 12 Nov 2021 03:09:24 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     mudongliangabcd@gmail.com
Cc:     stefan@datenfreihafen.org, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, aahringo@redhat.com
Subject: [PATCH wpan] net: ieee802154: handle iftypes as u32
Date:   Thu, 11 Nov 2021 22:09:16 -0500
Message-Id: <20211112030916.685793-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

This patch fixes an issue that an u32 netlink value is handled as a
signed enum value which doesn't fit into the range of u32 netlink type.
If it's handled as -1 value some BIT() evaluation ends in a
shift-out-of-bounds issue. To solve the issue we set the to u32 max which
is s32 "-1" value to keep backwards compatibility and let the followed enum
values start counting at 0. This brings the compiler to never handle the
enum as signed and a check if the value is above NL802154_IFTYPE_MAX should
filter -1 out.

Fixes: f3ea5e44231a ("ieee802154: add new interface command")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 include/net/nl802154.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/net/nl802154.h b/include/net/nl802154.h
index ddcee128f5d9..145acb8f2509 100644
--- a/include/net/nl802154.h
+++ b/include/net/nl802154.h
@@ -19,6 +19,8 @@
  *
  */
 
+#include <linux/types.h>
+
 #define NL802154_GENL_NAME "nl802154"
 
 enum nl802154_commands {
@@ -150,10 +152,9 @@ enum nl802154_attrs {
 };
 
 enum nl802154_iftype {
-	/* for backwards compatibility TODO */
-	NL802154_IFTYPE_UNSPEC = -1,
+	NL802154_IFTYPE_UNSPEC = (~(__u32)0),
 
-	NL802154_IFTYPE_NODE,
+	NL802154_IFTYPE_NODE = 0,
 	NL802154_IFTYPE_MONITOR,
 	NL802154_IFTYPE_COORD,
 
-- 
2.27.0

