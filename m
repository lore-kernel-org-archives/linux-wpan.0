Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-he1eur01on0132.outbound.protection.outlook.com ([104.47.0.132]:61722
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755327AbeCSLpo (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 19 Mar 2018 07:45:44 -0400
Subject: [PATCH net-next 1/2] net: Convert lowpan_frags_ops
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Date: Mon, 19 Mar 2018 14:45:37 +0300
Message-ID: <152145993742.26348.7771294840455450666.stgit@localhost.localdomain>
In-Reply-To: <152145973147.26348.4080298027358158796.stgit@localhost.localdomain>
References: <152145973147.26348.4080298027358158796.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: alex.aring@gmail.com, stefan@osg.samsung.com, davem@davemloft.net, pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de, yoshfuji@linux-ipv6.org, brouer@redhat.com, keescook@chromium.org, ktkhai@virtuozzo.com, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org

These pernet_operations register and unregister sysctl.
Also, there is inet_frags_exit_net() called in exit method,
which has to be safe after a560002437d3 "net: Fix hlist
corruptions in inet_evict_bucket()".

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 net/ieee802154/6lowpan/reassembly.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index 85bf86ad6b18..a9ccb1322f69 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -603,6 +603,7 @@ static void __net_exit lowpan_frags_exit_net(struct net *net)
 static struct pernet_operations lowpan_frags_ops = {
 	.init = lowpan_frags_init_net,
 	.exit = lowpan_frags_exit_net,
+	.async = true,
 };
 
 int __init lowpan_net_frag_init(void)

