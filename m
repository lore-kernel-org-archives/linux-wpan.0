Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:35218 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932245AbbI1KhK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 28 Sep 2015 06:37:10 -0400
Received: by wicge5 with SMTP id ge5so98540783wic.0
        for <linux-wpan@vger.kernel.org>; Mon, 28 Sep 2015 03:37:09 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] ieee802154: change mtu size behaviour
Date: Mon, 28 Sep 2015 12:36:26 +0200
Message-Id: <1443436586-6698-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch changes the mtu size of 802.15.4 interfaces. The current
setting is the meaning of the maximum transport unit with mac header,
which is 127 bytes according 802.15.4. The linux meaning of the mtu size
field is the maximum payload of a mac frame. Like in ethernet, which is
1500 bytes.

We have dynamic length of mac frames in 802.15.4, this is why we assume
the minimum header length which is hard_header_len. This contains fc and
sequence fields. These can evaluated by driver layer without additional
checks. We currently don't support to set the FCS from userspace, so we
need to subtract this from mtu size as well.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/socket.c |  4 ++--
 net/mac802154/iface.c   | 12 +++++++++++-
 net/mac802154/tx.c      | 11 -----------
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index be77f21..a548be2 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -273,7 +273,7 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		goto out;
 	}
 
-	mtu = dev->mtu;
+	mtu = IEEE802154_MTU;
 	pr_debug("name = %s, mtu = %u\n", dev->name, mtu);
 
 	if (size > mtu) {
@@ -637,7 +637,7 @@ static int dgram_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		err = -ENXIO;
 		goto out;
 	}
-	mtu = dev->mtu;
+	mtu = IEEE802154_MTU;
 	pr_debug("name = %s, mtu = %u\n", dev->name, mtu);
 
 	if (size > mtu) {
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 3954bcf..7079cd3 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -547,7 +547,17 @@ static void ieee802154_if_setup(struct net_device *dev)
 	 */
 	dev->needed_tailroom	= IEEE802154_MAX_AUTH_TAG_LEN +
 				  IEEE802154_FCS_LEN;
-	dev->mtu		= IEEE802154_MTU;
+	/* The mtu size is the payload without mac header in this case.
+	 * We have a dynamic length header with a minimum header length
+	 * which is hard_header_len. In this case we let mtu to the size
+	 * of maximum payload which is IEEE802154_MTU - IEEE802154_FCS_LEN -
+	 * hard_header_len. The FCS which is set by hardware or ndo_start_xmit
+	 * and the minimum mac header which can be evaluated inside driver
+	 * layer. The rest of mac header will be part of payload if greater
+	 * than hard_header_len.
+	 */
+	dev->mtu		= IEEE802154_MTU - IEEE802154_FCS_LEN -
+				  dev->hard_header_len;
 	dev->tx_queue_len	= 300;
 	dev->flags		= IFF_NOARP | IFF_BROADCAST;
 }
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 5ee596e..66d7ecb 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -71,17 +71,6 @@ ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 	struct net_device *dev = skb->dev;
 	int ret;
 
-	/* This check is for AF_PACKET RAW socket only, which doesn't
-	 * know about the FCS which is set here or by hardware. otherwise
-	 * it should not occur in any case!
-	 *
-	 * TODO: This should be handled in AF_PACKET and return -EMSGSIZE.
-	 */
-	if (skb->len > IEEE802154_MTU - IEEE802154_FCS_LEN) {
-		netdev_warn(dev, "Frame len above MTU limit. Dropped.\n");
-		goto err_tx;
-	}
-
 	if (!(local->hw.flags & IEEE802154_HW_TX_OMIT_CKSUM)) {
 		u16 crc = crc_ccitt(0, skb->data, skb->len);
 
-- 
2.5.3

