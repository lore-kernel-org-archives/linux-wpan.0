Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6448BC433FE
	for <linux-wpan@archiver.kernel.org>; Thu, 28 Apr 2022 03:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbiD1DJR (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 27 Apr 2022 23:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241857AbiD1DJR (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 27 Apr 2022 23:09:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35A272DA80
        for <linux-wpan@vger.kernel.org>; Wed, 27 Apr 2022 20:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651115163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9TjwB1FTuGbK/nxnFw4g+yurxGpo+tp+h6ik2UYFFps=;
        b=Aw4ujdfSajvlO+i/o1LUFxTAcHBjLKuVzIc+EJyNvZEDcxRpmToiLx2P6iZ7U2/a7Nz7bc
        VyLi+nAjKEnfzVFETIeGQusXIn/3mytRiYYS/5yOm/mjW3jiHkIHqFLgdcL7yCJtSeTZiK
        qzWFQlGH5bkBwHu7JzAQ+oH0P8DjIro=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-GFvNEVLuMxaifYtn8deXBg-1; Wed, 27 Apr 2022 23:05:59 -0400
X-MC-Unique: GFvNEVLuMxaifYtn8deXBg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AB8529AA2EE;
        Thu, 28 Apr 2022 03:05:59 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 427582166B4D;
        Thu, 28 Apr 2022 03:05:59 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     jukka.rissanen@linux.intel.com
Cc:     linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
        stefan@datenfreihafen.org, torvalds@linuxfoundation.org
Subject: [PATCH bluetooth-next 3/3] net: 6lowpan: constify lowpan_nhc structures
Date:   Wed, 27 Apr 2022 23:05:34 -0400
Message-Id: <20220428030534.3220410-4-aahringo@redhat.com>
In-Reply-To: <20220428030534.3220410-1-aahringo@redhat.com>
References: <20220428030534.3220410-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

This patch constify the lowpan_nhc declarations. Since we drop the rb
node datastructure there is no need for runtime manipulation of this
structure.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 net/6lowpan/nhc.c | 16 ++++++++--------
 net/6lowpan/nhc.h |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/6lowpan/nhc.c b/net/6lowpan/nhc.c
index 019f121b2449..7b374595328d 100644
--- a/net/6lowpan/nhc.c
+++ b/net/6lowpan/nhc.c
@@ -12,12 +12,12 @@
 
 #include "nhc.h"
 
-static struct lowpan_nhc *lowpan_nexthdr_nhcs[NEXTHDR_MAX + 1];
+static const struct lowpan_nhc *lowpan_nexthdr_nhcs[NEXTHDR_MAX + 1];
 static DEFINE_SPINLOCK(lowpan_nhc_lock);
 
-static struct lowpan_nhc *lowpan_nhc_by_nhcid(struct sk_buff *skb)
+static const struct lowpan_nhc *lowpan_nhc_by_nhcid(struct sk_buff *skb)
 {
-	struct lowpan_nhc *nhc;
+	const struct lowpan_nhc *nhc;
 	int i;
 	u8 id;
 
@@ -41,7 +41,7 @@ static struct lowpan_nhc *lowpan_nhc_by_nhcid(struct sk_buff *skb)
 int lowpan_nhc_check_compression(struct sk_buff *skb,
 				 const struct ipv6hdr *hdr, u8 **hc_ptr)
 {
-	struct lowpan_nhc *nhc;
+	const struct lowpan_nhc *nhc;
 	int ret = 0;
 
 	spin_lock_bh(&lowpan_nhc_lock);
@@ -59,7 +59,7 @@ int lowpan_nhc_do_compression(struct sk_buff *skb, const struct ipv6hdr *hdr,
 			      u8 **hc_ptr)
 {
 	int ret;
-	struct lowpan_nhc *nhc;
+	const struct lowpan_nhc *nhc;
 
 	spin_lock_bh(&lowpan_nhc_lock);
 
@@ -102,7 +102,7 @@ int lowpan_nhc_do_uncompression(struct sk_buff *skb,
 				const struct net_device *dev,
 				struct ipv6hdr *hdr)
 {
-	struct lowpan_nhc *nhc;
+	const struct lowpan_nhc *nhc;
 	int ret;
 
 	spin_lock_bh(&lowpan_nhc_lock);
@@ -138,7 +138,7 @@ int lowpan_nhc_do_uncompression(struct sk_buff *skb,
 	return 0;
 }
 
-int lowpan_nhc_add(struct lowpan_nhc *nhc)
+int lowpan_nhc_add(const struct lowpan_nhc *nhc)
 {
 	int ret = 0;
 
@@ -156,7 +156,7 @@ int lowpan_nhc_add(struct lowpan_nhc *nhc)
 }
 EXPORT_SYMBOL(lowpan_nhc_add);
 
-void lowpan_nhc_del(struct lowpan_nhc *nhc)
+void lowpan_nhc_del(const struct lowpan_nhc *nhc)
 {
 	spin_lock_bh(&lowpan_nhc_lock);
 
diff --git a/net/6lowpan/nhc.h b/net/6lowpan/nhc.h
index 9df602a632bd..ab7b4977c32b 100644
--- a/net/6lowpan/nhc.h
+++ b/net/6lowpan/nhc.h
@@ -24,7 +24,7 @@
 #define LOWPAN_NHC(__nhc, _name, _nexthdr,	\
 		   _hdrlen, _id, _idmask,	\
 		   _uncompress, _compress)	\
-static struct lowpan_nhc __nhc = {		\
+static const struct lowpan_nhc __nhc = {	\
 	.name		= _name,		\
 	.nexthdr	= _nexthdr,		\
 	.nexthdrlen	= _hdrlen,		\
@@ -116,14 +116,14 @@ int lowpan_nhc_do_uncompression(struct sk_buff *skb,
  *
  * @nhc: nhc which should be add.
  */
-int lowpan_nhc_add(struct lowpan_nhc *nhc);
+int lowpan_nhc_add(const struct lowpan_nhc *nhc);
 
 /**
  * lowpan_nhc_del - delete a next header compression from framework
  *
  * @nhc: nhc which should be delete.
  */
-void lowpan_nhc_del(struct lowpan_nhc *nhc);
+void lowpan_nhc_del(const struct lowpan_nhc *nhc);
 
 /**
  * lowpan_nhc_init - adding all default nhcs
-- 
2.31.1

