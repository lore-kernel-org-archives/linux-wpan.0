Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33567 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388924AbeGXUhr (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 24 Jul 2018 16:37:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id r5-v6so3578989pgv.0
        for <linux-wpan@vger.kernel.org>; Tue, 24 Jul 2018 12:29:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH PATCH net-next 13/18] x25: remove blank lines at EOF
Date: Tue, 24 Jul 2018 12:29:13 -0700
Message-Id: <20180724192918.31165-14-sthemmin@microsoft.com>
In-Reply-To: <20180724192918.31165-1-sthemmin@microsoft.com>
References: <20180724192918.31165-1-sthemmin@microsoft.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: davem@davemloft.net, ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net, ralf@linux-mips.org, jreuter@yaina.de, pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de, alex.aring@gmail.com, stefan@datenfreihafen.org, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, johannes@sipsolutions.net, jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, vyasevich@gmail.com, nhorman@tuxdriver.com, marcelo.leitner@gmail.com, trond.myklebust@hammerspace.com, anna.schumaker@netapp.com, steffen.klassert@secunet.com, herbert@gondor.apana.org.au
Cc: netdev@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-hams@vger.kernel.org, ceph-devel@vger.kernel.org, linux-decnet-user@lists.sourceforge.net, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, linux-wpan@vger.kernel.org, linux-s390@vger.kernel.org, linux-wireless@vger.kernel.org, linux-rdma@vger.kernel.org, linux-sctp@vger.kernel.org, linux-nfs@vger.kernel.org, linux-x25@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, Stephen Hemminger <stephen@networkplumber.org>

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/x25/Kconfig    | 2 --
 net/x25/x25_subr.c | 1 -
 2 files changed, 3 deletions(-)

diff --git a/net/x25/Kconfig b/net/x25/Kconfig
index e2fa133f9fba..59fcb41fc5e6 100644
--- a/net/x25/Kconfig
+++ b/net/x25/Kconfig
@@ -31,5 +31,3 @@ config X25
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called x25. If unsure, say N.
-
-
diff --git a/net/x25/x25_subr.c b/net/x25/x25_subr.c
index 9c214ec681ac..743103786652 100644
--- a/net/x25/x25_subr.c
+++ b/net/x25/x25_subr.c
@@ -381,4 +381,3 @@ void x25_check_rbuf(struct sock *sk)
 		x25_stop_timer(sk);
 	}
 }
-
-- 
2.18.0

