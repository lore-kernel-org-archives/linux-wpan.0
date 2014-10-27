Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:61350 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbaJ0QOO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Oct 2014 12:14:14 -0400
Received: by mail-wg0-f48.google.com with SMTP id m15so4161670wgh.7
        for <linux-wpan@vger.kernel.org>; Mon, 27 Oct 2014 09:14:13 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 05/16] mac802154: rx: move receive handling into rx.c
Date: Mon, 27 Oct 2014 17:13:32 +0100
Message-Id: <1414426423-24856-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414426423-24856-1-git-send-email-alex.aring@gmail.com>
References: <1414426423-24856-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes all relevant receiving functions inclusive frame
parsing into rx file. Like mac80211 we should implement the complete
receive handling and parsing in this file.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h |   1 -
 net/mac802154/iface.c        | 186 -------------------------------------
 net/mac802154/monitor.c      |  27 ------
 net/mac802154/rx.c           | 214 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 214 insertions(+), 214 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 603509a..be2f2f6 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -131,7 +131,6 @@ void mac802154_monitor_setup(struct net_device *dev);
 netdev_tx_t
 ieee802154_monitor_start_xmit(struct sk_buff *skb, struct net_device *dev);
 
-void mac802154_wpans_rx(struct ieee802154_local *local, struct sk_buff *skb);
 void mac802154_wpan_setup(struct net_device *dev);
 netdev_tx_t
 ieee802154_subif_start_xmit(struct sk_buff *skb, struct net_device *dev);
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 311f60c..7e4bffc 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -373,189 +373,3 @@ void mac802154_wpan_setup(struct net_device *dev)
 
 	mac802154_llsec_init(&sdata->sec);
 }
-
-static int mac802154_process_data(struct net_device *dev, struct sk_buff *skb)
-{
-	return netif_receive_skb(skb);
-}
-
-static int
-mac802154_subif_frame(struct ieee802154_sub_if_data *sdata, struct sk_buff *skb,
-		      const struct ieee802154_hdr *hdr)
-{
-	__le16 span, sshort;
-	int rc;
-
-	pr_debug("getting packet via slave interface %s\n", sdata->dev->name);
-
-	spin_lock_bh(&sdata->mib_lock);
-
-	span = sdata->pan_id;
-	sshort = sdata->short_addr;
-
-	switch (mac_cb(skb)->dest.mode) {
-	case IEEE802154_ADDR_NONE:
-		if (mac_cb(skb)->dest.mode != IEEE802154_ADDR_NONE)
-			/* FIXME: check if we are PAN coordinator */
-			skb->pkt_type = PACKET_OTHERHOST;
-		else
-			/* ACK comes with both addresses empty */
-			skb->pkt_type = PACKET_HOST;
-		break;
-	case IEEE802154_ADDR_LONG:
-		if (mac_cb(skb)->dest.pan_id != span &&
-		    mac_cb(skb)->dest.pan_id != cpu_to_le16(IEEE802154_PANID_BROADCAST))
-			skb->pkt_type = PACKET_OTHERHOST;
-		else if (mac_cb(skb)->dest.extended_addr == sdata->extended_addr)
-			skb->pkt_type = PACKET_HOST;
-		else
-			skb->pkt_type = PACKET_OTHERHOST;
-		break;
-	case IEEE802154_ADDR_SHORT:
-		if (mac_cb(skb)->dest.pan_id != span &&
-		    mac_cb(skb)->dest.pan_id != cpu_to_le16(IEEE802154_PANID_BROADCAST))
-			skb->pkt_type = PACKET_OTHERHOST;
-		else if (mac_cb(skb)->dest.short_addr == sshort)
-			skb->pkt_type = PACKET_HOST;
-		else if (mac_cb(skb)->dest.short_addr ==
-			  cpu_to_le16(IEEE802154_ADDR_BROADCAST))
-			skb->pkt_type = PACKET_BROADCAST;
-		else
-			skb->pkt_type = PACKET_OTHERHOST;
-		break;
-	default:
-		spin_unlock_bh(&sdata->mib_lock);
-		pr_debug("invalid dest mode\n");
-		kfree_skb(skb);
-		return NET_RX_DROP;
-	}
-
-	spin_unlock_bh(&sdata->mib_lock);
-
-	skb->dev = sdata->dev;
-
-	rc = mac802154_llsec_decrypt(&sdata->sec, skb);
-	if (rc) {
-		pr_debug("decryption failed: %i\n", rc);
-		goto fail;
-	}
-
-	sdata->dev->stats.rx_packets++;
-	sdata->dev->stats.rx_bytes += skb->len;
-
-	switch (mac_cb(skb)->type) {
-	case IEEE802154_FC_TYPE_DATA:
-		return mac802154_process_data(sdata->dev, skb);
-	default:
-		pr_warn("ieee802154: bad frame received (type = %d)\n",
-			mac_cb(skb)->type);
-		goto fail;
-	}
-
-fail:
-	kfree_skb(skb);
-	return NET_RX_DROP;
-}
-
-static void mac802154_print_addr(const char *name,
-				 const struct ieee802154_addr *addr)
-{
-	if (addr->mode == IEEE802154_ADDR_NONE)
-		pr_debug("%s not present\n", name);
-
-	pr_debug("%s PAN ID: %04x\n", name, le16_to_cpu(addr->pan_id));
-	if (addr->mode == IEEE802154_ADDR_SHORT) {
-		pr_debug("%s is short: %04x\n", name,
-			 le16_to_cpu(addr->short_addr));
-	} else {
-		u64 hw = swab64((__force u64) addr->extended_addr);
-
-		pr_debug("%s is hardware: %8phC\n", name, &hw);
-	}
-}
-
-static int mac802154_parse_frame_start(struct sk_buff *skb,
-				       struct ieee802154_hdr *hdr)
-{
-	int hlen;
-	struct ieee802154_mac_cb *cb = mac_cb_init(skb);
-
-	hlen = ieee802154_hdr_pull(skb, hdr);
-	if (hlen < 0)
-		return -EINVAL;
-
-	skb->mac_len = hlen;
-
-	pr_debug("fc: %04x dsn: %02x\n", le16_to_cpup((__le16 *)&hdr->fc),
-		 hdr->seq);
-
-	cb->type = hdr->fc.type;
-	cb->ackreq = hdr->fc.ack_request;
-	cb->secen = hdr->fc.security_enabled;
-
-	mac802154_print_addr("destination", &hdr->dest);
-	mac802154_print_addr("source", &hdr->source);
-
-	cb->source = hdr->source;
-	cb->dest = hdr->dest;
-
-	if (hdr->fc.security_enabled) {
-		u64 key;
-
-		pr_debug("seclevel %i\n", hdr->sec.level);
-
-		switch (hdr->sec.key_id_mode) {
-		case IEEE802154_SCF_KEY_IMPLICIT:
-			pr_debug("implicit key\n");
-			break;
-
-		case IEEE802154_SCF_KEY_INDEX:
-			pr_debug("key %02x\n", hdr->sec.key_id);
-			break;
-
-		case IEEE802154_SCF_KEY_SHORT_INDEX:
-			pr_debug("key %04x:%04x %02x\n",
-				 le32_to_cpu(hdr->sec.short_src) >> 16,
-				 le32_to_cpu(hdr->sec.short_src) & 0xffff,
-				 hdr->sec.key_id);
-			break;
-
-		case IEEE802154_SCF_KEY_HW_INDEX:
-			key = swab64((__force u64) hdr->sec.extended_src);
-			pr_debug("key source %8phC %02x\n", &key,
-				 hdr->sec.key_id);
-			break;
-		}
-	}
-
-	return 0;
-}
-
-void mac802154_wpans_rx(struct ieee802154_local *local, struct sk_buff *skb)
-{
-	int ret;
-	struct ieee802154_sub_if_data *sdata;
-	struct ieee802154_hdr hdr;
-
-	ret = mac802154_parse_frame_start(skb, &hdr);
-	if (ret) {
-		pr_debug("got invalid frame\n");
-		kfree_skb(skb);
-		return;
-	}
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
-		if (sdata->type != IEEE802154_DEV_WPAN ||
-		    !netif_running(sdata->dev))
-			continue;
-
-		mac802154_subif_frame(sdata, skb, &hdr);
-		skb = NULL;
-		break;
-	}
-	rcu_read_unlock();
-
-	if (skb)
-		kfree_skb(skb);
-}
diff --git a/net/mac802154/monitor.c b/net/mac802154/monitor.c
index 5758322..dfdedc2 100644
--- a/net/mac802154/monitor.c
+++ b/net/mac802154/monitor.c
@@ -18,9 +18,7 @@
  */
 
 #include <linux/netdevice.h>
-#include <linux/skbuff.h>
 #include <linux/if_arp.h>
-#include <linux/crc-ccitt.h>
 #include <linux/ieee802154.h>
 
 #include <net/mac802154.h>
@@ -30,31 +28,6 @@
 
 #include "ieee802154_i.h"
 
-void mac802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
-{
-	struct sk_buff *skb2;
-	struct ieee802154_sub_if_data *sdata;
-	u16 crc = crc_ccitt(0, skb->data, skb->len);
-	u8 *data;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
-		if (sdata->type != IEEE802154_DEV_MONITOR ||
-		    !netif_running(sdata->dev))
-			continue;
-
-		skb2 = skb_clone(skb, GFP_ATOMIC);
-		skb2->dev = sdata->dev;
-		skb2->pkt_type = PACKET_HOST;
-		data = skb_put(skb2, 2);
-		data[0] = crc & 0xff;
-		data[1] = crc >> 8;
-
-		netif_rx_ni(skb2);
-	}
-	rcu_read_unlock();
-}
-
 static const struct net_device_ops mac802154_monitor_ops = {
 	.ndo_open		= mac802154_slave_open,
 	.ndo_stop		= mac802154_slave_close,
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index c4df321..d8498c5 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -24,9 +24,223 @@
 
 #include <net/mac802154.h>
 #include <net/ieee802154_netdev.h>
+#include <net/rtnetlink.h>
+#include <linux/nl802154.h>
 
 #include "ieee802154_i.h"
 
+static int mac802154_process_data(struct net_device *dev, struct sk_buff *skb)
+{
+	return netif_receive_skb(skb);
+}
+
+static int
+mac802154_subif_frame(struct ieee802154_sub_if_data *sdata, struct sk_buff *skb,
+		      const struct ieee802154_hdr *hdr)
+{
+	__le16 span, sshort;
+	int rc;
+
+	pr_debug("getting packet via slave interface %s\n", sdata->dev->name);
+
+	spin_lock_bh(&sdata->mib_lock);
+
+	span = sdata->pan_id;
+	sshort = sdata->short_addr;
+
+	switch (mac_cb(skb)->dest.mode) {
+	case IEEE802154_ADDR_NONE:
+		if (mac_cb(skb)->dest.mode != IEEE802154_ADDR_NONE)
+			/* FIXME: check if we are PAN coordinator */
+			skb->pkt_type = PACKET_OTHERHOST;
+		else
+			/* ACK comes with both addresses empty */
+			skb->pkt_type = PACKET_HOST;
+		break;
+	case IEEE802154_ADDR_LONG:
+		if (mac_cb(skb)->dest.pan_id != span &&
+		    mac_cb(skb)->dest.pan_id != cpu_to_le16(IEEE802154_PANID_BROADCAST))
+			skb->pkt_type = PACKET_OTHERHOST;
+		else if (mac_cb(skb)->dest.extended_addr == sdata->extended_addr)
+			skb->pkt_type = PACKET_HOST;
+		else
+			skb->pkt_type = PACKET_OTHERHOST;
+		break;
+	case IEEE802154_ADDR_SHORT:
+		if (mac_cb(skb)->dest.pan_id != span &&
+		    mac_cb(skb)->dest.pan_id != cpu_to_le16(IEEE802154_PANID_BROADCAST))
+			skb->pkt_type = PACKET_OTHERHOST;
+		else if (mac_cb(skb)->dest.short_addr == sshort)
+			skb->pkt_type = PACKET_HOST;
+		else if (mac_cb(skb)->dest.short_addr ==
+			  cpu_to_le16(IEEE802154_ADDR_BROADCAST))
+			skb->pkt_type = PACKET_BROADCAST;
+		else
+			skb->pkt_type = PACKET_OTHERHOST;
+		break;
+	default:
+		spin_unlock_bh(&sdata->mib_lock);
+		pr_debug("invalid dest mode\n");
+		kfree_skb(skb);
+		return NET_RX_DROP;
+	}
+
+	spin_unlock_bh(&sdata->mib_lock);
+
+	skb->dev = sdata->dev;
+
+	rc = mac802154_llsec_decrypt(&sdata->sec, skb);
+	if (rc) {
+		pr_debug("decryption failed: %i\n", rc);
+		goto fail;
+	}
+
+	sdata->dev->stats.rx_packets++;
+	sdata->dev->stats.rx_bytes += skb->len;
+
+	switch (mac_cb(skb)->type) {
+	case IEEE802154_FC_TYPE_DATA:
+		return mac802154_process_data(sdata->dev, skb);
+	default:
+		pr_warn("ieee802154: bad frame received (type = %d)\n",
+			mac_cb(skb)->type);
+		goto fail;
+	}
+
+fail:
+	kfree_skb(skb);
+	return NET_RX_DROP;
+}
+
+static void mac802154_print_addr(const char *name,
+				 const struct ieee802154_addr *addr)
+{
+	if (addr->mode == IEEE802154_ADDR_NONE)
+		pr_debug("%s not present\n", name);
+
+	pr_debug("%s PAN ID: %04x\n", name, le16_to_cpu(addr->pan_id));
+	if (addr->mode == IEEE802154_ADDR_SHORT) {
+		pr_debug("%s is short: %04x\n", name,
+			 le16_to_cpu(addr->short_addr));
+	} else {
+		u64 hw = swab64((__force u64)addr->extended_addr);
+
+		pr_debug("%s is hardware: %8phC\n", name, &hw);
+	}
+}
+
+static int mac802154_parse_frame_start(struct sk_buff *skb,
+				       struct ieee802154_hdr *hdr)
+{
+	int hlen;
+	struct ieee802154_mac_cb *cb = mac_cb_init(skb);
+
+	hlen = ieee802154_hdr_pull(skb, hdr);
+	if (hlen < 0)
+		return -EINVAL;
+
+	skb->mac_len = hlen;
+
+	pr_debug("fc: %04x dsn: %02x\n", le16_to_cpup((__le16 *)&hdr->fc),
+		 hdr->seq);
+
+	cb->type = hdr->fc.type;
+	cb->ackreq = hdr->fc.ack_request;
+	cb->secen = hdr->fc.security_enabled;
+
+	mac802154_print_addr("destination", &hdr->dest);
+	mac802154_print_addr("source", &hdr->source);
+
+	cb->source = hdr->source;
+	cb->dest = hdr->dest;
+
+	if (hdr->fc.security_enabled) {
+		u64 key;
+
+		pr_debug("seclevel %i\n", hdr->sec.level);
+
+		switch (hdr->sec.key_id_mode) {
+		case IEEE802154_SCF_KEY_IMPLICIT:
+			pr_debug("implicit key\n");
+			break;
+
+		case IEEE802154_SCF_KEY_INDEX:
+			pr_debug("key %02x\n", hdr->sec.key_id);
+			break;
+
+		case IEEE802154_SCF_KEY_SHORT_INDEX:
+			pr_debug("key %04x:%04x %02x\n",
+				 le32_to_cpu(hdr->sec.short_src) >> 16,
+				 le32_to_cpu(hdr->sec.short_src) & 0xffff,
+				 hdr->sec.key_id);
+			break;
+
+		case IEEE802154_SCF_KEY_HW_INDEX:
+			key = swab64((__force u64)hdr->sec.extended_src);
+			pr_debug("key source %8phC %02x\n", &key,
+				 hdr->sec.key_id);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static void
+mac802154_wpans_rx(struct ieee802154_local *local, struct sk_buff *skb)
+{
+	int ret;
+	struct ieee802154_sub_if_data *sdata;
+	struct ieee802154_hdr hdr;
+
+	ret = mac802154_parse_frame_start(skb, &hdr);
+	if (ret) {
+		pr_debug("got invalid frame\n");
+		kfree_skb(skb);
+		return;
+	}
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
+		if (sdata->type != IEEE802154_DEV_WPAN ||
+		    !netif_running(sdata->dev))
+			continue;
+
+		mac802154_subif_frame(sdata, skb, &hdr);
+		skb = NULL;
+		break;
+	}
+	rcu_read_unlock();
+
+	if (skb)
+		kfree_skb(skb);
+}
+
+void mac802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
+{
+	struct sk_buff *skb2;
+	struct ieee802154_sub_if_data *sdata;
+	u16 crc = crc_ccitt(0, skb->data, skb->len);
+	u8 *data;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
+		if (sdata->type != IEEE802154_DEV_MONITOR ||
+		    !netif_running(sdata->dev))
+			continue;
+
+		skb2 = skb_clone(skb, GFP_ATOMIC);
+		skb2->dev = sdata->dev;
+		skb2->pkt_type = PACKET_HOST;
+		data = skb_put(skb2, 2);
+		data[0] = crc & 0xff;
+		data[1] = crc >> 8;
+
+		netif_rx_ni(skb2);
+	}
+	rcu_read_unlock();
+}
+
 static void
 mac802154_subif_rx(struct ieee802154_hw *hw, struct sk_buff *skb)
 {
-- 
2.1.2

