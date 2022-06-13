Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAFACCA47B
	for <linux-wpan@archiver.kernel.org>; Mon, 13 Jun 2022 04:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbiFMEiu (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 13 Jun 2022 00:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbiFMEhy (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 13 Jun 2022 00:37:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74860DEAB
        for <linux-wpan@vger.kernel.org>; Sun, 12 Jun 2022 21:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655095071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pFK8VgmfKhb8+ilAV4dF73pOZWBIxqI+j0j5EzbPtiU=;
        b=HOGVzuYBe2jFsUJBU4S4iuU8znD3US1qD/DFg5W5VrV2sNgMn/U22mXY3pxNPMGcWQ3x4V
        Onp1EFZWeldE7c6ilTbAJhAaVXXr78hJXpCI56X28pW9x7tylnc0Ee+xi1NDZaRVnns7JK
        jGsnpYT6HmeYxppawx43/eWg6lppc1E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-JExgUTjtPuuzTQm2rQu0EQ-1; Mon, 13 Jun 2022 00:37:46 -0400
X-MC-Unique: JExgUTjtPuuzTQm2rQu0EQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B288811E75;
        Mon, 13 Jun 2022 04:37:46 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1393D492CA2;
        Mon, 13 Jun 2022 04:37:46 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     stefan@datenfreihafen.org
Cc:     linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        miquel.raynal@bootlin.com, aahringo@redhat.com
Subject: [PATCHv2 wpan-next 1/2] mac802154: util: fix release queue handling
Date:   Mon, 13 Jun 2022 00:37:34 -0400
Message-Id: <20220613043735.1039895-2-aahringo@redhat.com>
In-Reply-To: <20220613043735.1039895-1-aahringo@redhat.com>
References: <20220613043735.1039895-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

The semantic of atomic_dec_and_test() is to return true if zero is
reached and we need call ieee802154_wake_queue() when zero is reached.

Fixes: 20a19d1df3e4 ("net: mac802154: Bring the ability to hold the transmit queue")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 net/mac802154/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac802154/util.c b/net/mac802154/util.c
index 60eb7bd3bfc1..60f6c0f10641 100644
--- a/net/mac802154/util.c
+++ b/net/mac802154/util.c
@@ -79,7 +79,7 @@ void ieee802154_release_queue(struct ieee802154_local *local)
 	unsigned long flags;
 
 	spin_lock_irqsave(&local->phy->queue_lock, flags);
-	if (!atomic_dec_and_test(&local->phy->hold_txs))
+	if (atomic_dec_and_test(&local->phy->hold_txs))
 		ieee802154_wake_queue(&local->hw);
 	spin_unlock_irqrestore(&local->phy->queue_lock, flags);
 }
-- 
2.31.1

