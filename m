Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:58301 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750752AbdKHJUc (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 8 Nov 2017 04:20:32 -0500
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] 6lowpan: Combine two condition checks into one statement in
 lowpan_xmit()
Message-ID: <221426d9-d049-b304-d7c1-bdf0a788bf36@users.sourceforge.net>
Date: Wed, 8 Nov 2017 10:20:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, "David S. Miller" <davem@davemloft.net>, Johannes Berg <johannes.berg@intel.com>, Stefan Schmidt <stefan@osg.samsung.com>, Stephen Hemminger <stephen@networkplumber.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 8 Nov 2017 10:10:41 +0100

The same exception handling was used in an if branch of two
separate statements.

* Merge their condition checks into a single statement instead.

* Delete the local variable "ret" which became unnecessary
  with this refactoring.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 net/ieee802154/6lowpan/tx.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
index e6ff5128e61a..1b0757db2078 100644
--- a/net/ieee802154/6lowpan/tx.c
+++ b/net/ieee802154/6lowpan/tx.c
@@ -255,7 +255,7 @@ static int lowpan_header(struct sk_buff *skb, struct net_device *ldev,
 netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *ldev)
 {
 	struct ieee802154_hdr wpan_hdr;
-	int max_single, ret;
+	int max_single;
 	u16 dgram_size, dgram_offset;
 
 	pr_debug("package xmit\n");
@@ -269,13 +269,8 @@ netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *ldev)
 	if (!skb)
 		return NET_XMIT_DROP;
 
-	ret = lowpan_header(skb, ldev, &dgram_size, &dgram_offset);
-	if (ret < 0) {
-		kfree_skb(skb);
-		return NET_XMIT_DROP;
-	}
-
-	if (ieee802154_hdr_peek(skb, &wpan_hdr) < 0) {
+	if (lowpan_header(skb, ldev, &dgram_size, &dgram_offset) < 0 ||
+	    ieee802154_hdr_peek(skb, &wpan_hdr) < 0) {
 		kfree_skb(skb);
 		return NET_XMIT_DROP;
 	}
-- 
2.15.0


