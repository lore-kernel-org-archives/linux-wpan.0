Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD4D3A16BE
	for <linux-wpan@vger.kernel.org>; Tue, 10 Mar 2026 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773157054; cv=none; b=XoJrC9XuIcgM6OuVcoH2xgwv5tKXuhzDM3PQRaLZpESnjfSW+yktXi0Ruh09C8/ORZjKR7wJRh3JnHtcmmvyvTl00DtTj5vXFDwxg944NpERqj9uD27gSmC9/zLx4Bh7I0rMYz2x9/MpQ3kvuVuoVUfmu5z59kg+09VhbJzPMo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773157054; c=relaxed/simple;
	bh=oS9q0igtCx73pgzVz0pCz/CxGmX+bJAFamXv+sWsHx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNdRVHrrXgIAsMqs2/hao/Q55chWAieWXf8v/4qMHYNdKtcA1feOT6RYoWrmtECkos4CXnjTaGJNreiNytLiTL1OCt67oBiDBEyRdfMnUxRruWCwrhAFuqeC1NC7XBEODEiUZyoykI53hhyoANKs1o87bvz8AnzfQj0DNpWZjIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A36E23F79A;
	Tue, 10 Mar 2026 15:37:31 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F34BC3F519;
	Tue, 10 Mar 2026 15:37:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uO4WOLk6sGlKXwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 10 Mar 2026 15:37:29 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: rbm@suse.com,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jon Maloy <jmaloy@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Guillaume Nault <gnault@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Kees Cook <kees@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org (open list),
	linux-wpan@vger.kernel.org (open list:IEEE 802.15.4 SUBSYSTEM),
	dev@openvswitch.org (open list:OPENVSWITCH),
	tipc-discussion@lists.sourceforge.net (open list:TIPC NETWORK LAYER)
Subject: [PATCH 07/10 net-next v2] net: convert remaining ipv6_stub users to direct function calls
Date: Tue, 10 Mar 2026 16:34:30 +0100
Message-ID: <20260310153506.5181-8-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310153506.5181-1-fmancera@suse.de>
References: <20260310153506.5181-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[]
X-Rspamd-Queue-Id: A36E23F79A
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

As IPv6 is built-in only, the ipv6_stub infrastruture is no longer
necessary.

Convert remaining ipv6_stub users to make direct function calls. The
fallback functions introduced previously will prevent linkage errors
when CONFIG_IPV6 is disabled.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: no changes
---
 include/net/udp_tunnel.h      | 2 +-
 net/ieee802154/6lowpan/tx.c   | 2 +-
 net/mpls/af_mpls.c            | 3 +--
 net/openvswitch/actions.c     | 3 ++-
 net/sched/sch_frag.c          | 4 ++--
 net/tipc/udp_media.c          | 9 +++------
 net/xfrm/espintcp.c           | 5 +----
 net/xfrm/xfrm_nat_keepalive.c | 4 ++--
 net/xfrm/xfrm_output.c        | 3 +--
 9 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index d9c6d04bb3b5..277f1ce1c02d 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -230,7 +230,7 @@ static inline void udp_tunnel_encap_enable(struct sock *sk)
 
 #if IS_ENABLED(CONFIG_IPV6)
 	if (READ_ONCE(sk->sk_family) == PF_INET6)
-		ipv6_stub->udpv6_encap_enable();
+		udpv6_encap_enable();
 #endif
 	udp_encap_enable();
 }
diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index 0c07662b44c0..69ec02386aaa 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -59,7 +59,7 @@ int lowpan_header_create(struct sk_buff *skb, struct net_device *ldev,
 	} else {
 		__le16 short_addr = cpu_to_le16(IEEE802154_ADDR_SHORT_UNSPEC);
 
-		n = neigh_lookup(&nd_tbl, &hdr->daddr, ldev);
+		n = neigh_lookup(ipv6_get_nd_tbl(), &hdr->daddr, ldev);
 		if (n) {
 			llneigh = lowpan_802154_neigh(neighbour_priv(n));
 			read_lock_bh(&n->lock);
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index ae85a7654b1f..8b4c0b7d55a2 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -24,7 +24,6 @@
 #if IS_ENABLED(CONFIG_IPV6)
 #include <net/ipv6.h>
 #endif
-#include <net/ipv6_stubs.h>
 #include <net/rtnh.h>
 #include "internal.h"
 
@@ -642,7 +641,7 @@ static struct net_device *inet6_fib_lookup_dev(struct net *net,
 
 	memset(&fl6, 0, sizeof(fl6));
 	memcpy(&fl6.daddr, addr, sizeof(struct in6_addr));
-	dst = ipv6_stub->ipv6_dst_lookup_flow(net, NULL, &fl6, NULL);
+	dst = ip6_dst_lookup_flow(net, NULL, &fl6, NULL);
 	if (IS_ERR(dst))
 		return ERR_CAST(dst);
 
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 792ca44a461d..140388a18ae0 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -21,6 +21,7 @@
 #include <net/ip.h>
 #include <net/ipv6.h>
 #include <net/ip6_fib.h>
+#include <net/ip6_route.h>
 #include <net/checksum.h>
 #include <net/dsfield.h>
 #include <net/mpls.h>
@@ -810,7 +811,7 @@ static void ovs_fragment(struct net *net, struct vport *vport,
 		skb_dst_set_noref(skb, &ovs_rt.dst);
 		IP6CB(skb)->frag_max_size = mru;
 
-		ipv6_stub->ipv6_fragment(net, skb->sk, skb, ovs_vport_output);
+		ip6_fragment(net, skb->sk, skb, ovs_vport_output);
 		refdst_drop(orig_dst);
 	} else {
 		WARN_ONCE(1, "Failed fragment ->%s: eth=%04x, MRU=%d, MTU=%d.",
diff --git a/net/sched/sch_frag.c b/net/sched/sch_frag.c
index d1d87dce7f3f..75ee52750919 100644
--- a/net/sched/sch_frag.c
+++ b/net/sched/sch_frag.c
@@ -6,6 +6,7 @@
 #include <net/dst.h>
 #include <net/ip.h>
 #include <net/ip6_fib.h>
+#include <net/ip6_route.h>
 
 struct sch_frag_data {
 	unsigned long dst;
@@ -127,8 +128,7 @@ static int sch_fragment(struct net *net, struct sk_buff *skb,
 		skb_dst_set_noref(skb, &sch_frag_rt.dst);
 		IP6CB(skb)->frag_max_size = mru;
 
-		ret = ipv6_stub->ipv6_fragment(net, skb->sk, skb,
-					       sch_frag_xmit);
+		ret = ip6_fragment(net, skb->sk, skb, sch_frag_xmit);
 		local_unlock_nested_bh(&sch_frag_data_storage.bh_lock);
 		refdst_drop(orig_dst);
 	} else {
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 2b8e385d1e51..2c66b356025a 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -44,7 +44,6 @@
 #include <net/sock.h>
 #include <net/ip.h>
 #include <net/udp_tunnel.h>
-#include <net/ipv6_stubs.h>
 #include <linux/tipc_netlink.h>
 #include "core.h"
 #include "addr.h"
@@ -207,9 +206,8 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 				.saddr = src->ipv6,
 				.flowi6_proto = IPPROTO_UDP
 			};
-			ndst = ipv6_stub->ipv6_dst_lookup_flow(net,
-							       ub->ubsock->sk,
-							       &fl6, NULL);
+			ndst = ip6_dst_lookup_flow(net, ub->ubsock->sk,
+						   &fl6, NULL);
 			if (IS_ERR(ndst)) {
 				err = PTR_ERR(ndst);
 				goto tx_error;
@@ -418,8 +416,7 @@ static int enable_mcast(struct udp_bearer *ub, struct udp_media_addr *remote)
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
 		lock_sock(sk);
-		err = ipv6_stub->ipv6_sock_mc_join(sk, ub->ifindex,
-						   &remote->ipv6);
+		err = ipv6_sock_mc_join(sk, ub->ifindex, &remote->ipv6);
 		release_sock(sk);
 #endif
 	}
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index 998832419097..a2756186e13a 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -7,9 +7,6 @@
 #include <linux/skmsg.h>
 #include <net/inet_common.h>
 #include <trace/events/sock.h>
-#if IS_ENABLED(CONFIG_IPV6)
-#include <net/ipv6_stubs.h>
-#endif
 #include <net/hotdata.h>
 
 static void handle_nonesp(struct espintcp_ctx *ctx, struct sk_buff *skb,
@@ -43,7 +40,7 @@ static void handle_esp(struct sk_buff *skb, struct sock *sk)
 	local_bh_disable();
 #if IS_ENABLED(CONFIG_IPV6)
 	if (sk->sk_family == AF_INET6)
-		ipv6_stub->xfrm6_rcv_encap(skb, IPPROTO_ESP, 0, TCP_ENCAP_ESPINTCP);
+		xfrm6_rcv_encap(skb, IPPROTO_ESP, 0, TCP_ENCAP_ESPINTCP);
 	else
 #endif
 		xfrm4_rcv_encap(skb, IPPROTO_ESP, 0, TCP_ENCAP_ESPINTCP);
diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepalive.c
index ebf95d48e86c..d47f2ed8005c 100644
--- a/net/xfrm/xfrm_nat_keepalive.c
+++ b/net/xfrm/xfrm_nat_keepalive.c
@@ -98,14 +98,14 @@ static int nat_keepalive_send_ipv6(struct sk_buff *skb,
 	local_lock_nested_bh(&nat_keepalive_sk_ipv6.bh_lock);
 	sk = this_cpu_read(nat_keepalive_sk_ipv6.sock);
 	sock_net_set(sk, net);
-	dst = ipv6_stub->ipv6_dst_lookup_flow(net, sk, &fl6, NULL);
+	dst = ip6_dst_lookup_flow(net, sk, &fl6, NULL);
 	if (IS_ERR(dst)) {
 		local_unlock_nested_bh(&nat_keepalive_sk_ipv6.bh_lock);
 		return PTR_ERR(dst);
 	}
 
 	skb_dst_set(skb, dst);
-	err = ipv6_stub->ip6_xmit(sk, skb, &fl6, skb->mark, NULL, 0, 0);
+	err = ip6_xmit(sk, skb, &fl6, skb->mark, NULL, 0, 0);
 	sock_net_set(sk, &init_net);
 	local_unlock_nested_bh(&nat_keepalive_sk_ipv6.bh_lock);
 	return err;
diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index 54222fcbd7fd..a9652b422f51 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -20,7 +20,6 @@
 
 #if IS_ENABLED(CONFIG_IPV6)
 #include <net/ip6_route.h>
-#include <net/ipv6_stubs.h>
 #endif
 
 #include "xfrm_inout.h"
@@ -900,7 +899,7 @@ int xfrm6_tunnel_check_size(struct sk_buff *skb)
 		skb->protocol = htons(ETH_P_IPV6);
 
 		if (xfrm6_local_dontfrag(sk))
-			ipv6_stub->xfrm6_local_rxpmtu(skb, mtu);
+			xfrm6_local_rxpmtu(skb, mtu);
 		else if (sk)
 			xfrm_local_error(skb, mtu);
 		else
-- 
2.53.0

