Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from host.76.145.23.62.rev.coltfrance.com ([62.23.145.76]:53666 "EHLO
	proxy.6wind.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932089AbcDVPl5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 22 Apr 2016 11:41:57 -0400
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net-next 6/9] libnl: nla_put_msecs(): align on a 64-bit area
Date: Fri, 22 Apr 2016 17:31:21 +0200
Message-Id: <1461339084-3849-7-git-send-email-nicolas.dichtel@6wind.com>
In-Reply-To: <1461339084-3849-1-git-send-email-nicolas.dichtel@6wind.com>
References: <1461339084-3849-1-git-send-email-nicolas.dichtel@6wind.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, aar@pengutronix.de, pablo@netfilter.org, kaber@trash.net, kadlec@blackhole.kfki.hu, pshelar@nicira.com, kuznet@ms2.inr.ac.ru, jmorris@namei.org, yoshfuji@linux-ipv6.org, netfilter-devel@vger.kernel.org, dev@openvswitch.org, steffen.klassert@secunet.com, herbert@gondor.apana.org.au, bsingharora@gmail.com, Nicolas Dichtel <nicolas.dichtel@6wind.com>

nla_data() is now aligned on a 64-bit area.

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 include/net/netlink.h            | 11 +++++++----
 include/uapi/linux/l2tp.h        |  1 +
 include/uapi/linux/neighbour.h   |  2 ++
 include/uapi/linux/tcp_metrics.h |  1 +
 net/core/neighbour.c             | 19 ++++++++++---------
 net/ipv4/tcp_metrics.c           |  6 ++++--
 net/l2tp/l2tp_netlink.c          |  3 ++-
 7 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index 074215a59d19..113b483b6ee8 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -106,7 +106,8 @@
  *               padattr)		add s64 attribute to skb
  *   nla_put_string(skb, type, str)	add string attribute to skb
  *   nla_put_flag(skb, type)		add flag attribute to skb
- *   nla_put_msecs(skb, type, jiffies)	add msecs attribute to skb
+ *   nla_put_msecs(skb, type, jiffies,
+ *                 padattr)		add msecs attribute to skb
  *   nla_put_in_addr(skb, type, addr)	add IPv4 address attribute to skb
  *   nla_put_in6_addr(skb, type, addr)	add IPv6 address attribute to skb
  *
@@ -965,16 +966,18 @@ static inline int nla_put_flag(struct sk_buff *skb, int attrtype)
 }
 
 /**
- * nla_put_msecs - Add a msecs netlink attribute to a socket buffer
+ * nla_put_msecs - Add a msecs netlink attribute to a skb and align it
  * @skb: socket buffer to add attribute to
  * @attrtype: attribute type
  * @njiffies: number of jiffies to convert to msecs
+ * @padattr: attribute type for the padding
  */
 static inline int nla_put_msecs(struct sk_buff *skb, int attrtype,
-				unsigned long njiffies)
+				unsigned long njiffies, int padattr)
 {
 	u64 tmp = jiffies_to_msecs(njiffies);
-	return nla_put(skb, attrtype, sizeof(u64), &tmp);
+
+	return nla_put_64bit(skb, attrtype, sizeof(u64), &tmp, padattr);
 }
 
 /**
diff --git a/include/uapi/linux/l2tp.h b/include/uapi/linux/l2tp.h
index 347ef22a964e..3386a99e0397 100644
--- a/include/uapi/linux/l2tp.h
+++ b/include/uapi/linux/l2tp.h
@@ -126,6 +126,7 @@ enum {
 	L2TP_ATTR_IP6_DADDR,		/* struct in6_addr */
 	L2TP_ATTR_UDP_ZERO_CSUM6_TX,	/* u8 */
 	L2TP_ATTR_UDP_ZERO_CSUM6_RX,	/* u8 */
+	L2TP_ATTR_PAD,
 	__L2TP_ATTR_MAX,
 };
 
diff --git a/include/uapi/linux/neighbour.h b/include/uapi/linux/neighbour.h
index 788655bfa0f3..bd99a8d80f36 100644
--- a/include/uapi/linux/neighbour.h
+++ b/include/uapi/linux/neighbour.h
@@ -128,6 +128,7 @@ enum {
 	NDTPA_LOCKTIME,			/* u64, msecs */
 	NDTPA_QUEUE_LENBYTES,		/* u32 */
 	NDTPA_MCAST_REPROBES,		/* u32 */
+	NDTPA_PAD,
 	__NDTPA_MAX
 };
 #define NDTPA_MAX (__NDTPA_MAX - 1)
@@ -160,6 +161,7 @@ enum {
 	NDTA_PARMS,			/* nested TLV NDTPA_* */
 	NDTA_STATS,			/* struct ndt_stats, read-only */
 	NDTA_GC_INTERVAL,		/* u64, msecs */
+	NDTA_PAD,
 	__NDTA_MAX
 };
 #define NDTA_MAX (__NDTA_MAX - 1)
diff --git a/include/uapi/linux/tcp_metrics.h b/include/uapi/linux/tcp_metrics.h
index 93533926035c..80ad90d0cfc2 100644
--- a/include/uapi/linux/tcp_metrics.h
+++ b/include/uapi/linux/tcp_metrics.h
@@ -40,6 +40,7 @@ enum {
 	TCP_METRICS_ATTR_FOPEN_COOKIE,		/* binary */
 	TCP_METRICS_ATTR_SADDR_IPV4,		/* u32 */
 	TCP_METRICS_ATTR_SADDR_IPV6,		/* binary */
+	TCP_METRICS_ATTR_PAD,
 
 	__TCP_METRICS_ATTR_MAX,
 };
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index f18ae91b652e..6a395d440228 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1763,21 +1763,22 @@ static int neightbl_fill_parms(struct sk_buff *skb, struct neigh_parms *parms)
 			NEIGH_VAR(parms, MCAST_PROBES)) ||
 	    nla_put_u32(skb, NDTPA_MCAST_REPROBES,
 			NEIGH_VAR(parms, MCAST_REPROBES)) ||
-	    nla_put_msecs(skb, NDTPA_REACHABLE_TIME, parms->reachable_time) ||
+	    nla_put_msecs(skb, NDTPA_REACHABLE_TIME, parms->reachable_time,
+			  NDTPA_PAD) ||
 	    nla_put_msecs(skb, NDTPA_BASE_REACHABLE_TIME,
-			  NEIGH_VAR(parms, BASE_REACHABLE_TIME)) ||
+			  NEIGH_VAR(parms, BASE_REACHABLE_TIME), NDTPA_PAD) ||
 	    nla_put_msecs(skb, NDTPA_GC_STALETIME,
-			  NEIGH_VAR(parms, GC_STALETIME)) ||
+			  NEIGH_VAR(parms, GC_STALETIME), NDTPA_PAD) ||
 	    nla_put_msecs(skb, NDTPA_DELAY_PROBE_TIME,
-			  NEIGH_VAR(parms, DELAY_PROBE_TIME)) ||
+			  NEIGH_VAR(parms, DELAY_PROBE_TIME), NDTPA_PAD) ||
 	    nla_put_msecs(skb, NDTPA_RETRANS_TIME,
-			  NEIGH_VAR(parms, RETRANS_TIME)) ||
+			  NEIGH_VAR(parms, RETRANS_TIME), NDTPA_PAD) ||
 	    nla_put_msecs(skb, NDTPA_ANYCAST_DELAY,
-			  NEIGH_VAR(parms, ANYCAST_DELAY)) ||
+			  NEIGH_VAR(parms, ANYCAST_DELAY), NDTPA_PAD) ||
 	    nla_put_msecs(skb, NDTPA_PROXY_DELAY,
-			  NEIGH_VAR(parms, PROXY_DELAY)) ||
+			  NEIGH_VAR(parms, PROXY_DELAY), NDTPA_PAD) ||
 	    nla_put_msecs(skb, NDTPA_LOCKTIME,
-			  NEIGH_VAR(parms, LOCKTIME)))
+			  NEIGH_VAR(parms, LOCKTIME), NDTPA_PAD))
 		goto nla_put_failure;
 	return nla_nest_end(skb, nest);
 
@@ -1804,7 +1805,7 @@ static int neightbl_fill_info(struct sk_buff *skb, struct neigh_table *tbl,
 	ndtmsg->ndtm_pad2   = 0;
 
 	if (nla_put_string(skb, NDTA_NAME, tbl->id) ||
-	    nla_put_msecs(skb, NDTA_GC_INTERVAL, tbl->gc_interval) ||
+	    nla_put_msecs(skb, NDTA_GC_INTERVAL, tbl->gc_interval, NDTA_PAD) ||
 	    nla_put_u32(skb, NDTA_THRESH1, tbl->gc_thresh1) ||
 	    nla_put_u32(skb, NDTA_THRESH2, tbl->gc_thresh2) ||
 	    nla_put_u32(skb, NDTA_THRESH3, tbl->gc_thresh3))
diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 7b7eec439906..b617826e2477 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -800,7 +800,8 @@ static int tcp_metrics_fill_info(struct sk_buff *msg,
 	}
 
 	if (nla_put_msecs(msg, TCP_METRICS_ATTR_AGE,
-			  jiffies - tm->tcpm_stamp) < 0)
+			  jiffies - tm->tcpm_stamp,
+			  TCP_METRICS_ATTR_PAD) < 0)
 		goto nla_put_failure;
 	if (tm->tcpm_ts_stamp) {
 		if (nla_put_s32(msg, TCP_METRICS_ATTR_TW_TS_STAMP,
@@ -864,7 +865,8 @@ static int tcp_metrics_fill_info(struct sk_buff *msg,
 		    (nla_put_u16(msg, TCP_METRICS_ATTR_FOPEN_SYN_DROPS,
 				tfom->syn_loss) < 0 ||
 		     nla_put_msecs(msg, TCP_METRICS_ATTR_FOPEN_SYN_DROP_TS,
-				jiffies - tfom->last_syn_loss) < 0))
+				jiffies - tfom->last_syn_loss,
+				TCP_METRICS_ATTR_PAD) < 0))
 			goto nla_put_failure;
 		if (tfom->cookie.len > 0 &&
 		    nla_put(msg, TCP_METRICS_ATTR_FOPEN_COOKIE,
diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index 2caaa84ce92d..24ed2e875c45 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -746,7 +746,8 @@ static int l2tp_nl_session_send(struct sk_buff *skb, u32 portid, u32 seq, int fl
 	     nla_put_u8(skb, L2TP_ATTR_USING_IPSEC, 1)) ||
 #endif
 	    (session->reorder_timeout &&
-	     nla_put_msecs(skb, L2TP_ATTR_RECV_TIMEOUT, session->reorder_timeout)))
+	     nla_put_msecs(skb, L2TP_ATTR_RECV_TIMEOUT,
+			   session->reorder_timeout, L2TP_ATTR_PAD)))
 		goto nla_put_failure;
 
 	nest = nla_nest_start(skb, L2TP_ATTR_STATS);
-- 
2.8.1

