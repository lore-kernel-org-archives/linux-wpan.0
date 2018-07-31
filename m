Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:51765 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeGaR0G (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 31 Jul 2018 13:26:06 -0400
From: Colin King <colin.king@canonical.com>
Subject: [PATCH] net: ieee802154: 6lowpan: remove redundant pointers 'fq' and 'net'
Date: Tue, 31 Jul 2018 16:45:07 +0100
Message-Id: <20180731154507.5247-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, "David S . Miller" <davem@davemloft.net>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointers fq and net are being assigned but are never used hence they
are redundant and can be removed.

Cleans up clang warnings:
warning: variable 'fq' set but not used [-Wunused-but-set-variable]
warning: variable 'net' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/ieee802154/6lowpan/reassembly.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index ec7a5da56129..e7857a8ac86d 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -40,9 +40,6 @@ static int lowpan_frag_reasm(struct lowpan_frag_queue *fq,
 static void lowpan_frag_init(struct inet_frag_queue *q, const void *a)
 {
 	const struct frag_lowpan_compare_key *key = a;
-	struct lowpan_frag_queue *fq;
-
-	fq = container_of(q, struct lowpan_frag_queue, q);
 
 	BUILD_BUG_ON(sizeof(*key) > sizeof(q->key));
 	memcpy(&q->key, key, sizeof(*key));
@@ -52,10 +49,8 @@ static void lowpan_frag_expire(struct timer_list *t)
 {
 	struct inet_frag_queue *frag = from_timer(frag, t, timer);
 	struct frag_queue *fq;
-	struct net *net;
 
 	fq = container_of(frag, struct frag_queue, q);
-	net = container_of(fq->q.net, struct net, ieee802154_lowpan.frags);
 
 	spin_lock(&fq->q.lock);
 
-- 
2.17.1

