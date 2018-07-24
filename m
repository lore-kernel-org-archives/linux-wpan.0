Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44134 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388819AbeGXUhc (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 24 Jul 2018 16:37:32 -0400
Received: by mail-pl0-f68.google.com with SMTP id m16-v6so2194007pls.11
        for <linux-wpan@vger.kernel.org>; Tue, 24 Jul 2018 12:29:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH PATCH net-next 05/18] mpls: remove trailing whitepace
Date: Tue, 24 Jul 2018 12:29:05 -0700
Message-Id: <20180724192918.31165-6-sthemmin@microsoft.com>
In-Reply-To: <20180724192918.31165-1-sthemmin@microsoft.com>
References: <20180724192918.31165-1-sthemmin@microsoft.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: davem@davemloft.net, ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net, ralf@linux-mips.org, jreuter@yaina.de, pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de, alex.aring@gmail.com, stefan@datenfreihafen.org, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, johannes@sipsolutions.net, jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, vyasevich@gmail.com, nhorman@tuxdriver.com, marcelo.leitner@gmail.com, trond.myklebust@hammerspace.com, anna.schumaker@netapp.com, steffen.klassert@secunet.com, herbert@gondor.apana.org.au
Cc: netdev@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-hams@vger.kernel.org, ceph-devel@vger.kernel.org, linux-decnet-user@lists.sourceforge.net, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, linux-wpan@vger.kernel.org, linux-s390@vger.kernel.org, linux-wireless@vger.kernel.org, linux-rdma@vger.kernel.org, linux-sctp@vger.kernel.org, linux-nfs@vger.kernel.org, linux-x25@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, Stephen Hemminger <stephen@networkplumber.org>

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/mpls/mpls_iptunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mpls/mpls_iptunnel.c b/net/mpls/mpls_iptunnel.c
index 6e558a419f60..94f53a9b7d1a 100644
--- a/net/mpls/mpls_iptunnel.c
+++ b/net/mpls/mpls_iptunnel.c
@@ -224,7 +224,7 @@ static int mpls_fill_encap_info(struct sk_buff *skb,
 				struct lwtunnel_state *lwtstate)
 {
 	struct mpls_iptunnel_encap *tun_encap_info;
-	
+
 	tun_encap_info = mpls_lwtunnel_encap(lwtstate);
 
 	if (nla_put_labels(skb, MPLS_IPTUNNEL_DST, tun_encap_info->labels,
-- 
2.18.0

