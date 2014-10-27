Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:37709 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbaJ0Lnn (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Oct 2014 07:43:43 -0400
Received: by mail-la0-f44.google.com with SMTP id hs14so5643959lab.31
        for <linux-wpan@vger.kernel.org>; Mon, 27 Oct 2014 04:43:41 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 06/16] mac802154: tx: remove monitor receive while xmit
Date: Mon, 27 Oct 2014 12:42:59 +0100
Message-Id: <1414410189-20092-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414410189-20092-1-git-send-email-alex.aring@gmail.com>
References: <1414410189-20092-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This removes the call of monitor receive funktion when any interface
type call xmit. There exist no such use case that a monitor interface
should receive the actual sending frame. One use case could be that a
wpan interface and monitor interface could be running at the same time
on one phy. Then the monitor interface receives the wpan frames also.
Furthermore we adding support for promiscous mode setting. With
promiscous mode setting we can't run a wpan and monitor interface at the
same time.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h | 1 -
 net/mac802154/rx.c           | 3 ++-
 net/mac802154/tx.c           | 2 --
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index be2f2f6..ac907d9 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -126,7 +126,6 @@ extern struct ieee802154_mlme_ops mac802154_mlme_wpan;
 int mac802154_slave_open(struct net_device *dev);
 int mac802154_slave_close(struct net_device *dev);
 
-void mac802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb);
 void mac802154_monitor_setup(struct net_device *dev);
 netdev_tx_t
 ieee802154_monitor_start_xmit(struct sk_buff *skb, struct net_device *dev);
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index d8498c5..04f3d61 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -216,7 +216,8 @@ mac802154_wpans_rx(struct ieee802154_local *local, struct sk_buff *skb)
 		kfree_skb(skb);
 }
 
-void mac802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
+static void
+mac802154_monitors_rx(struct ieee802154_local *local, struct sk_buff *skb)
 {
 	struct sk_buff *skb2;
 	struct ieee802154_sub_if_data *sdata;
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 31e51e4..e857673 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -82,8 +82,6 @@ ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
 	struct net_device *dev = skb->dev;
 	int ret;
 
-	mac802154_monitors_rx(local, skb);
-
 	if (!(local->hw.flags & IEEE802154_HW_OMIT_CKSUM)) {
 		u16 crc = crc_ccitt(0, skb->data, skb->len);
 
-- 
2.1.2

