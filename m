Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:43573 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbaKIHhk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 9 Nov 2014 02:37:40 -0500
Received: by mail-wg0-f50.google.com with SMTP id z12so6484673wgg.9
        for <linux-wpan@vger.kernel.org>; Sat, 08 Nov 2014 23:37:39 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 14/15] ieee802154: fix iface dump with lowpan
Date: Sun,  9 Nov 2014 08:36:58 +0100
Message-Id: <1415518619-4370-15-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
References: <1415518619-4370-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a hacked solution for an interface dump with a running
lowpan interface. This will crash because lowpan and wpan interface use
the same arphdr. To change the arphdr will change the UAPI, this patch
checks on mtu which should on lowpan interface always different than
IEEE802154_MTU.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/nl-mac.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/ieee802154/nl-mac.c b/net/ieee802154/nl-mac.c
index 50e9863..fe77f0c 100644
--- a/net/ieee802154/nl-mac.c
+++ b/net/ieee802154/nl-mac.c
@@ -166,7 +166,10 @@ static struct net_device *ieee802154_nl_get_dev(struct genl_info *info)
 	if (!dev)
 		return NULL;
 
-	if (dev->type != ARPHRD_IEEE802154) {
+	/* Check on mtu is currently a hacked solution because lowpan
+	 * and wpan have the same ARPHRD type.
+	 */
+	if (dev->type != ARPHRD_IEEE802154 || dev->mtu != IEEE802154_MTU) {
 		dev_put(dev);
 		return NULL;
 	}
@@ -448,7 +451,11 @@ int ieee802154_dump_iface(struct sk_buff *skb, struct netlink_callback *cb)
 
 	idx = 0;
 	for_each_netdev(net, dev) {
-		if (idx < s_idx || (dev->type != ARPHRD_IEEE802154))
+		/* Check on mtu is currently a hacked solution because lowpan
+		 * and wpan have the same ARPHRD type.
+		 */
+		if (idx < s_idx || dev->type != ARPHRD_IEEE802154 ||
+		    dev->mtu != IEEE802154_MTU)
 			goto cont;
 
 		if (ieee802154_nl_fill_iface(skb, NETLINK_CB(cb->skb).portid,
@@ -782,7 +789,11 @@ ieee802154_llsec_dump_table(struct sk_buff *skb, struct netlink_callback *cb,
 	int rc;
 
 	for_each_netdev(net, dev) {
-		if (idx < first_dev || dev->type != ARPHRD_IEEE802154)
+		/* Check on mtu is currently a hacked solution because lowpan
+		 * and wpan have the same ARPHRD type.
+		 */
+		if (idx < first_dev || dev->type != ARPHRD_IEEE802154 ||
+		    dev->mtu != IEEE802154_MTU)
 			goto skip;
 
 		data.ops = ieee802154_mlme_ops(dev);
-- 
2.1.3

