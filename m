Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:52610 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbbEYMik (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 25 May 2015 08:38:40 -0400
Date: Mon, 25 May 2015 15:38:39 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCHv2 bluetooth-next 4/6] ieee802154: Remove 802.15.4/6LoWPAN
 checks for interface MTU.
Message-ID: <20150525123839.GM11340@wantstofly.org>
References: <cover.1432535597.git.buytenh@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1432535597.git.buytenh@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

In the past, 802.15.4 interfaces and 6LoWPAN interfaces used the
same dev->type (ARPHRD_IEEE802154), and 802.15.4 interfaces were
distinguished from 6LoWPAN interfaces by their differing dev->mtu.

6LoWPAN interfaces have their own ARPHRD type now, so there is no
longer any need to check dev->mtu to distinguish 802.15.4 devices
from 6LoWPAN devices.

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
Acked-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/nl-mac.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/net/ieee802154/nl-mac.c b/net/ieee802154/nl-mac.c
index ada58a8..3503c38 100644
--- a/net/ieee802154/nl-mac.c
+++ b/net/ieee802154/nl-mac.c
@@ -168,10 +168,7 @@ static struct net_device *ieee802154_nl_get_dev(struct genl_info *info)
 	if (!dev)
 		return NULL;
 
-	/* Check on mtu is currently a hacked solution because lowpan
-	 * and wpan have the same ARPHRD type.
-	 */
-	if (dev->type != ARPHRD_IEEE802154 || dev->mtu != IEEE802154_MTU) {
+	if (dev->type != ARPHRD_IEEE802154) {
 		dev_put(dev);
 		return NULL;
 	}
@@ -455,11 +452,7 @@ int ieee802154_dump_iface(struct sk_buff *skb, struct netlink_callback *cb)
 
 	idx = 0;
 	for_each_netdev(net, dev) {
-		/* Check on mtu is currently a hacked solution because lowpan
-		 * and wpan have the same ARPHRD type.
-		 */
-		if (idx < s_idx || dev->type != ARPHRD_IEEE802154 ||
-		    dev->mtu != IEEE802154_MTU)
+		if (idx < s_idx || dev->type != ARPHRD_IEEE802154)
 			goto cont;
 
 		if (ieee802154_nl_fill_iface(skb, NETLINK_CB(cb->skb).portid,
@@ -789,11 +782,7 @@ ieee802154_llsec_dump_table(struct sk_buff *skb, struct netlink_callback *cb,
 	int rc;
 
 	for_each_netdev(net, dev) {
-		/* Check on mtu is currently a hacked solution because lowpan
-		 * and wpan have the same ARPHRD type.
-		 */
-		if (idx < first_dev || dev->type != ARPHRD_IEEE802154 ||
-		    dev->mtu != IEEE802154_MTU)
+		if (idx < first_dev || dev->type != ARPHRD_IEEE802154)
 			goto skip;
 
 		data.ops = ieee802154_mlme_ops(dev);
-- 
2.1.0

