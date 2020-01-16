Return-Path: <SRS0=3TlL=3F=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597F2C33CB6
	for <linux-wpan@archiver.kernel.org>; Thu, 16 Jan 2020 17:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DFD2073A
	for <linux-wpan@archiver.kernel.org>; Thu, 16 Jan 2020 17:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579197194;
	bh=UXa8m6DU4r8Aux3+ktngeVRdN4MC9pFpVAeuu6a93bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oJdITNc35QSP1wTtMHf3CizfzkkoUvFUnDLR6RrrDak+LV4DZfnPRz7Fd5eqf+L6w
	 z2bJIczCksBzs166ALc7DowGd9RCeJRlkmAUO3sc3WhVy/QFUOXHQuDeYzxAEBtaNH
	 C5L+2lRiJSQH7Up1VbNy/fz3ONpp9PJX192eR8JU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406089AbgAPRpJ (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:45:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:36650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406083AbgAPRpI (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 16 Jan 2020 12:45:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA07C24773;
        Thu, 16 Jan 2020 17:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196707;
        bh=UXa8m6DU4r8Aux3+ktngeVRdN4MC9pFpVAeuu6a93bo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FyTXd74eQomhb1X+h1rQrJJlNXkfKCCppJDskBEFHjZlO4Sco3yRDyTOhlh5Gy9SW
         YTodSFMh4OeexXJxo/Mz19IfE5ALnU2Sae175Qpva0I6E1cBmSHcm+zPBo8j03Xa+y
         q3CxZhF+KT/z33VlFvF7zHAC917uzEOH85c9QpD0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 098/174] inet: frags: call inet_frags_fini() after unregister_pernet_subsys()
Date:   Thu, 16 Jan 2020 12:41:35 -0500
Message-Id: <20200116174251.24326-98-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116174251.24326-1-sashal@kernel.org>
References: <20200116174251.24326-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit ae7352d384a552d8c799c242e74a934809990a71 ]

Both IPv6 and 6lowpan are calling inet_frags_fini() too soon.

inet_frags_fini() is dismantling a kmem_cache, that might be needed
later when unregister_pernet_subsys() eventually has to remove
frags queues from hash tables and free them.

This fixes potential use-after-free, and is a prereq for the following patch.

Fixes: d4ad4d22e7ac ("inet: frags: use kmem_cache for inet_frag_queue")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ieee802154/6lowpan/reassembly.c | 2 +-
 net/ipv6/reassembly.c               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index 6183730d38db..e728dae467c3 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -634,7 +634,7 @@ int __init lowpan_net_frag_init(void)
 
 void lowpan_net_frag_exit(void)
 {
-	inet_frags_fini(&lowpan_frags);
 	lowpan_frags_sysctl_unregister();
 	unregister_pernet_subsys(&lowpan_frags_ops);
+	inet_frags_fini(&lowpan_frags);
 }
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index ec917f58d105..17e9ed2edb86 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -774,8 +774,8 @@ int __init ipv6_frag_init(void)
 
 void ipv6_frag_exit(void)
 {
-	inet_frags_fini(&ip6_frags);
 	ip6_frags_sysctl_unregister();
 	unregister_pernet_subsys(&ip6_frags_ops);
 	inet6_del_protocol(&frag_protocol, IPPROTO_FRAGMENT);
+	inet_frags_fini(&ip6_frags);
 }
-- 
2.20.1

