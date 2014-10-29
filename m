Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:39075 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756798AbaJ2UgJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 16:36:09 -0400
Received: by mail-wg0-f46.google.com with SMTP id x13so2783343wgg.33
        for <linux-wpan@vger.kernel.org>; Wed, 29 Oct 2014 13:36:08 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 17/17] mac802154: add basic support for monitor
Date: Wed, 29 Oct 2014 21:34:44 +0100
Message-Id: <1414614884-20243-18-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
References: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds basic support for monitor mode. Also change the open
call that we set the transceiver mac setting on an interface up. Futher
patches will add a better handling while interface up an interface.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_i.h |  1 +
 net/mac802154/iface.c        | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 7cebc98..1086a9d 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -84,6 +84,7 @@ struct ieee802154_sub_if_data {
 	__le16 pan_id;
 	__le16 short_addr;
 	__le64 extended_addr;
+	bool promisuous_mode;
 
 	struct ieee802154_mac_params mac_params;
 
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index c0bf5f9..f7a6f83 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -196,6 +196,12 @@ static int mac802154_wpan_open(struct net_device *dev)
 
 	mutex_lock(&phy->pib_lock);
 
+	if (local->hw.flags & IEEE802154_HW_PROMISCUOUS) {
+		rc = drv_set_promiscuous_mode(local, sdata->promisuous_mode);
+		if (rc < 0)
+			goto out;
+	}
+
 	if (local->hw.flags & IEEE802154_HW_TXPOWER) {
 		rc = drv_set_tx_power(local, sdata->mac_params.transmit_power);
 		if (rc < 0)
@@ -382,7 +388,7 @@ static const struct net_device_ops mac802154_wpan_ops = {
 };
 
 static const struct net_device_ops mac802154_monitor_ops = {
-	.ndo_open		= mac802154_slave_open,
+	.ndo_open		= mac802154_wpan_open,
 	.ndo_stop		= mac802154_slave_close,
 	.ndo_start_xmit		= ieee802154_monitor_start_xmit,
 };
@@ -434,6 +440,8 @@ void mac802154_wpan_setup(struct net_device *dev)
 	sdata->pan_id = cpu_to_le16(IEEE802154_PANID_BROADCAST);
 	sdata->short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
 
+	sdata->promisuous_mode = false;
+
 	mac802154_llsec_init(&sdata->sec);
 }
 
@@ -453,4 +461,6 @@ void mac802154_monitor_setup(struct net_device *dev)
 
 	sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	sdata->type = IEEE802154_DEV_MONITOR;
+
+	sdata->promisuous_mode = true;
 }
-- 
2.1.2

