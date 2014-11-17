Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:36813 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbaKQHVZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 17 Nov 2014 02:21:25 -0500
Received: by mail-wg0-f42.google.com with SMTP id z12so5930765wgg.29
        for <linux-wpan@vger.kernel.org>; Sun, 16 Nov 2014 23:21:24 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 01/13] mac802154: remove unused prototypes
Date: Mon, 17 Nov 2014 08:20:43 +0100
Message-Id: <1416208855-8623-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1416208855-8623-1-git-send-email-alex.aring@gmail.com>
References: <1416208855-8623-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes some prototypes which are not used anymore.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index c5b2310..593339a 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -120,14 +120,10 @@ ieee802154_sdata_running(struct ieee802154_sub_if_data *sdata)
 	return test_bit(SDATA_STATE_RUNNING, &sdata->state);
 }
 
-extern struct ieee802154_reduced_mlme_ops mac802154_mlme_reduced;
 extern struct ieee802154_mlme_ops mac802154_mlme_wpan;
 
-void mac802154_monitor_setup(struct net_device *dev);
 netdev_tx_t
 ieee802154_monitor_start_xmit(struct sk_buff *skb, struct net_device *dev);
-
-void mac802154_wpan_setup(struct net_device *dev);
 netdev_tx_t
 ieee802154_subif_start_xmit(struct sk_buff *skb, struct net_device *dev);
 enum hrtimer_restart ieee802154_xmit_ifs_timer(struct hrtimer *timer);
@@ -176,8 +172,6 @@ void mac802154_unlock_table(struct net_device *dev);
 /* interface handling */
 int ieee802154_iface_init(void);
 void ieee802154_iface_exit(void);
-struct net_device *
-mac802154_add_iface(struct wpan_phy *phy, const char *name, int type);
 void ieee802154_if_remove(struct ieee802154_sub_if_data *sdata);
 struct net_device *
 ieee802154_if_add(struct ieee802154_local *local, const char *name,
-- 
2.1.3

