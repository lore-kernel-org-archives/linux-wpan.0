Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4287C433F5
	for <linux-wpan@archiver.kernel.org>; Wed,  5 Oct 2022 01:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJEBsS (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 4 Oct 2022 21:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJEBsR (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 4 Oct 2022 21:48:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF6226121
        for <linux-wpan@vger.kernel.org>; Tue,  4 Oct 2022 18:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664934495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fA4NI5w4MRfF3Pfqdy/1Bs+SMuIf9yBrH8E+yyq8iQE=;
        b=RkssJrtuQNLwDO3y1FVZdU3T+9OapuUaMHkztgJDYXq7dkVdrsGdDf3w6kwcptIbywDIam
        AWEwdfG4MYkmNd5LayEXLG1gB3ZD2dXIxdSUs4s5RE9lWMmRd8XAyI6HQQVTOnZfzbOtpi
        HQlYNNfPTZCycRNnmOWFFcPA1LxaTWc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-OlTdlDT_NYija73GS9zQyA-1; Tue, 04 Oct 2022 21:48:14 -0400
X-MC-Unique: OlTdlDT_NYija73GS9zQyA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66EEB85A59D;
        Wed,  5 Oct 2022 01:48:13 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C5DD40C6EC2;
        Wed,  5 Oct 2022 01:48:13 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     penguin-kernel@i-love.sakura.ne.jp
Cc:     stefan@datenfreihafen.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        aahringo@redhat.com
Subject: [PATCH net 2/2] net/ieee802154: don't warn zero-sized raw_sendmsg()
Date:   Tue,  4 Oct 2022 21:47:50 -0400
Message-Id: <20221005014750.3685555-2-aahringo@redhat.com>
In-Reply-To: <20221005014750.3685555-1-aahringo@redhat.com>
References: <20221005014750.3685555-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

syzbot is hitting skb_assert_len() warning at __dev_queue_xmit() [1],
for PF_IEEE802154 socket's zero-sized raw_sendmsg() request is hitting
__dev_queue_xmit() with skb->len == 0.

Since PF_IEEE802154 socket's zero-sized raw_sendmsg() request was
able to return 0, don't call __dev_queue_xmit() if packet length is 0.

  ----------
  #include <sys/socket.h>
  #include <netinet/in.h>

  int main(int argc, char *argv[])
  {
    struct sockaddr_in addr = { .sin_family = AF_INET, .sin_addr.s_addr = htonl(INADDR_LOOPBACK) };
    struct iovec iov = { };
    struct msghdr hdr = { .msg_name = &addr, .msg_namelen = sizeof(addr), .msg_iov = &iov, .msg_iovlen = 1 };
    sendmsg(socket(PF_IEEE802154, SOCK_RAW, 0), &hdr, 0);
    return 0;
  }
  ----------

Note that this might be a sign that commit fd1894224407c484 ("bpf: Don't
redirect packets with invalid pkt_len") should be reverted, for
skb->len == 0 was acceptable for at least PF_IEEE802154 socket.

Link: https://syzkaller.appspot.com/bug?extid=5ea725c25d06fb9114c4 [1]
Reported-by: syzbot <syzbot+5ea725c25d06fb9114c4@syzkaller.appspotmail.com>
Fixes: fd1894224407c484 ("bpf: Don't redirect packets with invalid pkt_len")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 net/ieee802154/socket.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 7889e1ef7fad..6e55fae4c686 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -272,6 +272,10 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		err = -EMSGSIZE;
 		goto out_dev;
 	}
+	if (!size) {
+		err = 0;
+		goto out_dev;
+	}
 
 	hlen = LL_RESERVED_SPACE(dev);
 	tlen = dev->needed_tailroom;
-- 
2.31.1

