Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pg1-f201.google.com ([209.85.215.201]:51025 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfBZBn4 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 25 Feb 2019 20:43:56 -0500
Received: by mail-pg1-f201.google.com with SMTP id n24so8373098pgm.17
        for <linux-wpan@vger.kernel.org>; Mon, 25 Feb 2019 17:43:55 -0800 (PST)
Date: Mon, 25 Feb 2019 17:43:46 -0800
Message-Id: <20190226014346.77719-1-posk@google.com>
Mime-Version: 1.0
Subject: [PATCH net-next] net: remove unused struct inet_frag_queue.fragments field
From: Peter Oskolkov <posk@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Peter Oskolkov <posk@posk.io>, linux-wpan@vger.kernel.org, Peter Oskolkov <posk@google.com>

Now that all users of struct inet_frag_queue have been converted
to use 'rb_fragments', remove the unused 'fragments' field.

Build with `make allyesconfig` succeeded. ip_defrag selftest passed.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 include/net/inet_frag.h                 |  4 +--
 net/ieee802154/6lowpan/reassembly.c     |  1 -
 net/ipv4/inet_fragment.c                | 44 ++++++++-----------------
 net/ipv4/ip_fragment.c                  |  2 --
 net/ipv6/netfilter/nf_conntrack_reasm.c |  1 -
 net/ipv6/reassembly.c                   |  1 -
 6 files changed, 14 insertions(+), 39 deletions(-)

diff --git a/include/net/inet_frag.h b/include/net/inet_frag.h
index b02bf737d019..378904ee9129 100644
--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -56,7 +56,6 @@ struct frag_v6_compare_key {
  * @timer: queue expiration timer
  * @lock: spinlock protecting this frag
  * @refcnt: reference count of the queue
- * @fragments: received fragments head
  * @rb_fragments: received fragments rb-tree root
  * @fragments_tail: received fragments tail
  * @last_run_head: the head of the last "run". see ip_fragment.c
@@ -77,8 +76,7 @@ struct inet_frag_queue {
 	struct timer_list	timer;
 	spinlock_t		lock;
 	refcount_t		refcnt;
-	struct sk_buff		*fragments;  /* used in 6lopwpan IPv6. */
-	struct rb_root		rb_fragments; /* Used in IPv4/IPv6. */
+	struct rb_root		rb_fragments;
 	struct sk_buff		*fragments_tail;
 	struct sk_buff		*last_run_head;
 	ktime_t			stamp;
diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index bd61633d2c32..4196bcd4105a 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -179,7 +179,6 @@ static int lowpan_frag_reasm(struct lowpan_frag_queue *fq, struct sk_buff *skb,
 
 	skb->dev = ldev;
 	skb->tstamp = fq->q.stamp;
-	fq->q.fragments = NULL;
 	fq->q.rb_fragments = RB_ROOT;
 	fq->q.fragments_tail = NULL;
 	fq->q.last_run_head = NULL;
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 9f69411251d0..737808e27f8b 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -203,7 +203,6 @@ EXPORT_SYMBOL(inet_frag_rbtree_purge);
 
 void inet_frag_destroy(struct inet_frag_queue *q)
 {
-	struct sk_buff *fp;
 	struct netns_frags *nf;
 	unsigned int sum, sum_truesize = 0;
 	struct inet_frags *f;
@@ -212,20 +211,9 @@ void inet_frag_destroy(struct inet_frag_queue *q)
 	WARN_ON(del_timer(&q->timer) != 0);
 
 	/* Release all fragment data. */
-	fp = q->fragments;
 	nf = q->net;
 	f = nf->f;
-	if (fp) {
-		do {
-			struct sk_buff *xp = fp->next;
-
-			sum_truesize += fp->truesize;
-			kfree_skb(fp);
-			fp = xp;
-		} while (fp);
-	} else {
-		sum_truesize = inet_frag_rbtree_purge(&q->rb_fragments);
-	}
+	sum_truesize = inet_frag_rbtree_purge(&q->rb_fragments);
 	sum = sum_truesize + f->qsize;
 
 	call_rcu(&q->rcu, inet_frag_destroy_rcu);
@@ -489,26 +477,20 @@ EXPORT_SYMBOL(inet_frag_reasm_finish);
 
 struct sk_buff *inet_frag_pull_head(struct inet_frag_queue *q)
 {
-	struct sk_buff *head;
+	struct sk_buff *head, *skb;
 
-	if (q->fragments) {
-		head = q->fragments;
-		q->fragments = head->next;
-	} else {
-		struct sk_buff *skb;
+	head = skb_rb_first(&q->rb_fragments);
+	if (!head)
+		return NULL;
+	skb = FRAG_CB(head)->next_frag;
+	if (skb)
+		rb_replace_node(&head->rbnode, &skb->rbnode,
+				&q->rb_fragments);
+	else
+		rb_erase(&head->rbnode, &q->rb_fragments);
+	memset(&head->rbnode, 0, sizeof(head->rbnode));
+	barrier();
 
-		head = skb_rb_first(&q->rb_fragments);
-		if (!head)
-			return NULL;
-		skb = FRAG_CB(head)->next_frag;
-		if (skb)
-			rb_replace_node(&head->rbnode, &skb->rbnode,
-					&q->rb_fragments);
-		else
-			rb_erase(&head->rbnode, &q->rb_fragments);
-		memset(&head->rbnode, 0, sizeof(head->rbnode));
-		barrier();
-	}
 	if (head == q->fragments_tail)
 		q->fragments_tail = NULL;
 
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 486ecb0aeb87..cf2b0a6a3337 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -261,7 +261,6 @@ static int ip_frag_reinit(struct ipq *qp)
 	qp->q.flags = 0;
 	qp->q.len = 0;
 	qp->q.meat = 0;
-	qp->q.fragments = NULL;
 	qp->q.rb_fragments = RB_ROOT;
 	qp->q.fragments_tail = NULL;
 	qp->q.last_run_head = NULL;
@@ -451,7 +450,6 @@ static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
 	ip_send_check(iph);
 
 	__IP_INC_STATS(net, IPSTATS_MIB_REASMOKS);
-	qp->q.fragments = NULL;
 	qp->q.rb_fragments = RB_ROOT;
 	qp->q.fragments_tail = NULL;
 	qp->q.last_run_head = NULL;
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index cb1b4772dac0..3de0e9b0a482 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -365,7 +365,6 @@ static int nf_ct_frag6_reasm(struct frag_queue *fq, struct sk_buff *skb,
 					 skb_network_header_len(skb),
 					 skb->csum);
 
-	fq->q.fragments = NULL;
 	fq->q.rb_fragments = RB_ROOT;
 	fq->q.fragments_tail = NULL;
 	fq->q.last_run_head = NULL;
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 24264d0a4b85..1a832f5e190b 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -304,7 +304,6 @@ static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *skb,
 	rcu_read_lock();
 	__IP6_INC_STATS(net, __in6_dev_get(dev), IPSTATS_MIB_REASMOKS);
 	rcu_read_unlock();
-	fq->q.fragments = NULL;
 	fq->q.rb_fragments = RB_ROOT;
 	fq->q.fragments_tail = NULL;
 	fq->q.last_run_head = NULL;
-- 
2.21.0.rc2.261.ga7da99ff1b-goog
