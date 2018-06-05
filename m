Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:52711 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752362AbeFEWFN (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 5 Jun 2018 18:05:13 -0400
Received: by mail-it0-f67.google.com with SMTP id m194-v6so5502063itg.2
        for <linux-wpan@vger.kernel.org>; Tue, 05 Jun 2018 15:05:13 -0700 (PDT)
From: Alexander Aring <aring@mojatatu.com>
Subject: [PATCH net] net: ipv6: ip6_output: alloc skb with tailroom
Date: Tue,  5 Jun 2018 18:04:04 -0400
Message-Id: <20180605220404.6425-1-aring@mojatatu.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, yoshfuji@linux-ipv6.org, david.palma@ntnu.no, rabinarayans0828@gmail.com, jhs@mojatatu.com, stefan@osg.samsung.com, linux-wpan@vger.kernel.org, kernel@mojatatu.com, Alexander Aring <aring@mojatatu.com>

This patch adds care about tailroom length for allocate a skb from ipv6
level stack. In case of 6lowpan we had the problem the skb runs into a
skb_over_panic() in some special length cases. The root was there was no
tailroom allocated for the IEEE 802.15.4 checksum, although we had
the necessary tailroom specified inside the netdev structure.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=195059
Reported-by: David Palma <david.palma@ntnu.no>
Reported-by: Rabi Narayan Sahoo <rabinarayans0828@gmail.com>
Signed-off-by: Alexander Aring <aring@mojatatu.com>
---
Hi,

nasty bug, I suppose this is the correct fix to my last question for
what dev->needed_tailroom is designed for.

I added two Reported-by here, David Palma reported this bug one year ago
and I didn't had time to investigate. Interesting is that he told this
bug doesn't occur (in case of 6lowpan 802.15.4) on 32 bit systems.
Maybe alignment is related to the question why it works on 32 bit.

Anyway, a week ago "Rabi Narayan Sahoo" reported the bug again and I
needed to investigate something "why", since I also use a 64 bit vm.

David Palma did a nice job for reproduce this bug and he (I think) lives
at least one year with it, so I put him at first.

Anyway, Rabi Narayan Sahoo was very very close to fix it and found the
right code part which I also found. I read his mail afterwards because
it was received messed on the linux-wpan mailinglist. So it's correct
to give him credits too. :-)

I hope there are no other cases where tailroom is missing.
The second one is not needed to fix my bug but I think we need it there.
Also hh_len is also used inside a skb_resever() in this function,
but this is for headroom only.

- Alex

 net/ipv6/ip6_output.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 7b6d1689087b..b4e521cfe3cf 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1262,6 +1262,7 @@ static int __ip6_append_data(struct sock *sk,
 	int exthdrlen = 0;
 	int dst_exthdrlen = 0;
 	int hh_len;
+	int t_len;
 	int copy;
 	int err;
 	int offset = 0;
@@ -1283,6 +1284,7 @@ static int __ip6_append_data(struct sock *sk,
 	orig_mtu = mtu;
 
 	hh_len = LL_RESERVED_SPACE(rt->dst.dev);
+	t_len = rt->dst.dev->needed_tailroom;
 
 	fragheaderlen = sizeof(struct ipv6hdr) + rt->rt6i_nfheader_len +
 			(opt ? opt->opt_nflen : 0);
@@ -1425,13 +1427,13 @@ static int __ip6_append_data(struct sock *sk,
 			}
 			if (transhdrlen) {
 				skb = sock_alloc_send_skb(sk,
-						alloclen + hh_len,
+						alloclen + hh_len + t_len,
 						(flags & MSG_DONTWAIT), &err);
 			} else {
 				skb = NULL;
 				if (refcount_read(&sk->sk_wmem_alloc) + wmem_alloc_delta <=
 				    2 * sk->sk_sndbuf)
-					skb = alloc_skb(alloclen + hh_len,
+					skb = alloc_skb(alloclen + hh_len + t_len,
 							sk->sk_allocation);
 				if (unlikely(!skb))
 					err = -ENOBUFS;
-- 
2.11.0

