Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:34887 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbaJ0QO0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Oct 2014 12:14:26 -0400
Received: by mail-wg0-f51.google.com with SMTP id b13so6070193wgh.10
        for <linux-wpan@vger.kernel.org>; Mon, 27 Oct 2014 09:14:25 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 16/16] mac802154: rx: change naming convention
Date: Mon, 27 Oct 2014 17:13:43 +0100
Message-Id: <1414426423-24856-17-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414426423-24856-1-git-send-email-alex.aring@gmail.com>
References: <1414426423-24856-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch changes the naming convention of mac802154 rx file. It should
be more named like mac80211 stack. Furthermore we introduce a new frame
parsing implementation which is much similar the mac80211
implementation.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/rx.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 689bb7f..86394be 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -29,7 +29,7 @@
 
 #include "ieee802154_i.h"
 
-static int mac802154_process_data(struct net_device *dev, struct sk_buff *skb)
+static int ieee802154_deliver_skb(struct net_device *dev, struct sk_buff *skb)
 {
 	skb->ip_summed = CHECKSUM_UNNECESSARY;
 	skb->protocol = htons(ETH_P_IEEE802154);
@@ -38,8 +38,8 @@ static int mac802154_process_data(struct net_device *dev, struct sk_buff *skb)
 }
 
 static int
-mac802154_subif_frame(struct ieee802154_sub_if_data *sdata, struct sk_buff *skb,
-		      const struct ieee802154_hdr *hdr)
+ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
+		       struct sk_buff *skb, const struct ieee802154_hdr *hdr)
 {
 	__le16 span, sshort;
 	int rc;
@@ -103,7 +103,7 @@ mac802154_subif_frame(struct ieee802154_sub_if_data *sdata, struct sk_buff *skb,
 
 	switch (mac_cb(skb)->type) {
 	case IEEE802154_FC_TYPE_DATA:
-		return mac802154_process_data(sdata->dev, skb);
+		return ieee802154_deliver_skb(sdata->dev, skb);
 	default:
 		pr_warn("ieee802154: bad frame received (type = %d)\n",
 			mac_cb(skb)->type);
@@ -115,8 +115,8 @@ fail:
 	return NET_RX_DROP;
 }
 
-static void mac802154_print_addr(const char *name,
-				 const struct ieee802154_addr *addr)
+static void
+ieee802154_print_addr(const char *name, const struct ieee802154_addr *addr)
 {
 	if (addr->mode == IEEE802154_ADDR_NONE)
 		pr_debug("%s not present\n", name);
@@ -132,8 +132,8 @@ static void mac802154_print_addr(const char *name,
 	}
 }
 
-static int mac802154_parse_frame_start(struct sk_buff *skb,
-				       struct ieee802154_hdr *hdr)
+static int
+ieee802154_parse_frame_start(struct sk_buff *skb, struct ieee802154_hdr *hdr)
 {
 	int hlen;
 	struct ieee802154_mac_cb *cb = mac_cb_init(skb);
@@ -153,8 +153,8 @@ static int mac802154_parse_frame_start(struct sk_buff *skb,
 	cb->ackreq = hdr->fc.ack_request;
 	cb->secen = hdr->fc.security_enabled;
 
-	mac802154_print_addr("destination", &hdr->dest);
-	mac802154_print_addr("source", &hdr->source);
+	ieee802154_print_addr("destination", &hdr->dest);
+	ieee802154_print_addr("source", &hdr->source);
 
 	cb->source = hdr->source;
 	cb->dest = hdr->dest;
@@ -192,13 +192,14 @@ static int mac802154_parse_frame_start(struct sk_buff *skb,
 }
 
 static void
-mac802154_wpans_rx(struct ieee802154_local *local, struct sk_buff *skb)
+__ieee802154_rx_handle_packet(struct ieee802154_local *local,
+			      struct sk_buff *skb)
 {
 	int ret;
 	struct ieee802154_sub_if_data *sdata;
 	struct ieee802154_hdr hdr;
 
-	ret = mac802154_parse_frame_start(skb, &hdr);
+	ret = ieee802154_parse_frame_start(skb, &hdr);
 	if (ret) {
 		pr_debug("got invalid frame\n");
 		kfree_skb(skb);
@@ -210,7 +211,7 @@ mac802154_wpans_rx(struct ieee802154_local *local, struct sk_buff *skb)
 		    !netif_running(sdata->dev))
 			continue;
 
-		mac802154_subif_frame(sdata, skb, &hdr);
+		ieee802154_subif_frame(sdata, skb, &hdr);
 		skb = NULL;
 		break;
 	}
@@ -220,7 +221,7 @@ mac802154_wpans_rx(struct ieee802154_local *local, struct sk_buff *skb)
 }
 
 static void
-mac802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
+ieee802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
 {
 	struct sk_buff *skb2;
 	struct ieee802154_sub_if_data *sdata;
@@ -271,8 +272,8 @@ void ieee802154_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
 
 	rcu_read_lock();
 
-	mac802154_monitors_rx(local, skb);
-	mac802154_wpans_rx(local, skb);
+	ieee802154_monitors_rx(local, skb);
+	__ieee802154_rx_handle_packet(local, skb);
 
 	rcu_read_unlock();
 
-- 
2.1.2

