Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-db5eur01on0104.outbound.protection.outlook.com ([104.47.2.104]:45378
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755327AbeCSLpx (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 19 Mar 2018 07:45:53 -0400
Subject: [PATCH net-next 2/2] net: Convert nf_ct_net_ops
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Date: Mon, 19 Mar 2018 14:45:46 +0300
Message-ID: <152145994646.26348.3106975491506950180.stgit@localhost.localdomain>
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
 net/ipv6/netfilter/nf_conntrack_reasm.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index b84ce3e6d728..34136fe80ed5 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -646,6 +646,7 @@ static void nf_ct_net_exit(struct net *net)
 static struct pernet_operations nf_ct_net_ops = {
 	.init = nf_ct_net_init,
 	.exit = nf_ct_net_exit,
+	.async = true,
 };
 
 int nf_ct_frag6_init(void)

