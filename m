Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86F72417D1
	for <linux-wpan@vger.kernel.org>; Mon,  9 Mar 2026 02:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773022913; cv=none; b=EM6X0n/mISIp8CGrKIQEvnzpxmKhU5hxBsSGm4htKHTSK3BosMjt1OidmA7ytxqruuAaPkJvwqmBoSEeSsj/NmbOWTkM2D8xydQnJUv6j7taIzIkK4um20ypVy4fZ7Jlt/IN9cBvogY7IGVnRRlmxHGHT1bBit5y9OyfP41xZUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773022913; c=relaxed/simple;
	bh=X+cILASNeUoyVwRz+yb4TxYXH6T/6yAidmN/VKsZmmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUcgVsNA7jpWj0yvhIQRYobi8SvkmwD+H9Cb5fmDVcOHiAPWhUvB98jSVHb8i6aqk5fc4mVE8wApdTNjp5w5COG585tcXM6pd3c66Y+kdHW3A1PGMG8MQlxEhL4vkOhdhlY58jyevcHEg9QBQCY58/QlwMbjW/KBFtG7HCIwjY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gM67pza5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y0k6pKh2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gM67pza5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y0k6pKh2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gM67pza5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y0k6pKh2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gM67pza5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y0k6pKh2"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4DBF15BDFC;
	Mon,  9 Mar 2026 02:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773022910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iqvX6wCxX6v18GU6MoylFqPDV9laX1bfWlynqwj8OBs=;
	b=gM67pza5aKVMOmLL0UlbIVUOMTHPi5t3dU/cNw4wlzcHJWSyzb+FlXj1vg5I7qI3T/YUo4
	8rvkTWJwxxuhQmgSTdXq/elKhY4tjHvINCAKVW6fzNJS/BEqidW6oe0dkX5YfKf4d38srZ
	vJhsw6b+RgajUrsc0YnDOGOucmikuko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773022910;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iqvX6wCxX6v18GU6MoylFqPDV9laX1bfWlynqwj8OBs=;
	b=Y0k6pKh2n9CuOh8gPoN1OB6gj1J2L8flSExdrObqu74Nzliev7e9JXIz1miNvF2MGTs/Mo
	rN875ZtOlzBKgKAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gM67pza5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Y0k6pKh2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773022910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iqvX6wCxX6v18GU6MoylFqPDV9laX1bfWlynqwj8OBs=;
	b=gM67pza5aKVMOmLL0UlbIVUOMTHPi5t3dU/cNw4wlzcHJWSyzb+FlXj1vg5I7qI3T/YUo4
	8rvkTWJwxxuhQmgSTdXq/elKhY4tjHvINCAKVW6fzNJS/BEqidW6oe0dkX5YfKf4d38srZ
	vJhsw6b+RgajUrsc0YnDOGOucmikuko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773022910;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iqvX6wCxX6v18GU6MoylFqPDV9laX1bfWlynqwj8OBs=;
	b=Y0k6pKh2n9CuOh8gPoN1OB6gj1J2L8flSExdrObqu74Nzliev7e9JXIz1miNvF2MGTs/Mo
	rN875ZtOlzBKgKAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99F483EC6E;
	Mon,  9 Mar 2026 02:21:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2H0oIrwurmk0MgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 09 Mar 2026 02:21:48 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
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
	Stanislav Fomichev <sdf@fomichev.me>,
	Kees Cook <kees@kernel.org>,
	linux-wpan@vger.kernel.org (open list:IEEE 802.15.4 SUBSYSTEM),
	dev@openvswitch.org (open list:OPENVSWITCH),
	tipc-discussion@lists.sourceforge.net (open list:TIPC NETWORK LAYER)
Subject: [PATCH 07/10 net-next] net: convert remaining ipv6_stub users to direct function calls
Date: Mon,  9 Mar 2026 03:19:40 +0100
Message-ID: <20260309022013.5199-8-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260309022013.5199-1-fmancera@suse.de>
References: <20260309022013.5199-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.de,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,datenfreihafen.org,bootlin.com,ovn.org,mojatatu.com,resnulli.us,secunet.com,gondor.apana.org.au,debian.org,fomichev.me,openvswitch.org,lists.sourceforge.net];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RLgp8mi1krmdxo5fm3wpkjeyr9)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Queue-Id: 4DBF15BDFC
X-Spam-Flag: NO
X-Spam-Score: -1.51
X-Spam-Level: 

As IPv6 is built-in only, the ipv6_stub infrastructure is no longer
necessary.

Convert remaining ipv6_stub users to make direct function calls. The
fallback functions introduced previously will prevent linkage errors
when CONFIG_IPV6 is disabled.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
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

