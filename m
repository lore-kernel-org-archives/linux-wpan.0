Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F58C433FE
	for <linux-wpan@archiver.kernel.org>; Wed,  5 Oct 2022 01:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiJEBsT (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 4 Oct 2022 21:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiJEBsS (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 4 Oct 2022 21:48:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79817233AD
        for <linux-wpan@vger.kernel.org>; Tue,  4 Oct 2022 18:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664934496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZT2Bh5EJ8aDTIXWP41xEUHi99QpNsHb85YXZNNPYgmw=;
        b=W37uGhZ3QrpnKuYF/bVXb7eKN9EzAjeMBa1DZs86RQvjxrqhUxF8Fw6cHeZVmH3cOkCfn7
        CSrvD1frHNaOhFK9NwoG7r/cDqiSK4QFQpa7yW5Y0du++HTQS+SSFlkHRTNgasdO8sC0ze
        Xqp5GY81q53fzjN1/CWevmEny5y2JYI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-ImFFczhCON6UZDfk9e67MQ-1; Tue, 04 Oct 2022 21:48:13 -0400
X-MC-Unique: ImFFczhCON6UZDfk9e67MQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24169800B30;
        Wed,  5 Oct 2022 01:48:13 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2877940C6EC2;
        Wed,  5 Oct 2022 01:48:09 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     penguin-kernel@i-love.sakura.ne.jp
Cc:     stefan@datenfreihafen.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        aahringo@redhat.com
Subject: [PATCH net 1/2] Revert "net/ieee802154: reject zero-sized raw_sendmsg()"
Date:   Tue,  4 Oct 2022 21:47:49 -0400
Message-Id: <20221005014750.3685555-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

This reverts commit 3a4d061c699bd3eedc80dc97a4b2a2e1af83c6f5.

There is a v2 which does return zero if zero length is given.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 net/ieee802154/socket.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index cbd0e2ac4ffe..7889e1ef7fad 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -251,9 +251,6 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		return -EOPNOTSUPP;
 	}
 
-	if (!size)
-		return -EINVAL;
-
 	lock_sock(sk);
 	if (!sk->sk_bound_dev_if)
 		dev = dev_getfirstbyhwtype(sock_net(sk), ARPHRD_IEEE802154);
-- 
2.31.1

