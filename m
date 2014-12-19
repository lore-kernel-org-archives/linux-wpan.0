Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:38119 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591AbaLSWqH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Dec 2014 17:46:07 -0500
Received: by mail-wi0-f177.google.com with SMTP id l15so3207465wiw.16
        for <linux-wpan@vger.kernel.org>; Fri, 19 Dec 2014 14:46:06 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 1/2] mac802154: iface: check concurrent ifaces
Date: Fri, 19 Dec 2014 23:45:58 +0100
Message-Id: <1419029159-21554-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1419029159-21554-1-git-send-email-alex.aring@gmail.com>
References: <1419029159-21554-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds a check for concurrent interfaces while calling
interface up. This avoids to have different mac parameters on one phy.
Otherwise it could be that a interface can overwrite current phy mac
settings which is set by an another interface.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/iface.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 9ae8930..61f3ff0 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -175,6 +175,79 @@ err:
 	return res;
 }
 
+static int
+ieee802154_check_mac_settings(struct ieee802154_local *local,
+			      struct wpan_dev *wpan_dev,
+			      struct wpan_dev *nwpan_dev)
+{
+	ASSERT_RTNL();
+
+	if (local->hw.flags & IEEE802154_HW_PROMISCUOUS) {
+		if (wpan_dev->promiscuous_mode != nwpan_dev->promiscuous_mode)
+			return -EBUSY;
+	}
+
+	if (local->hw.flags & IEEE802154_HW_AFILT) {
+		if (wpan_dev->pan_id != nwpan_dev->pan_id)
+			return -EBUSY;
+
+		if (wpan_dev->short_addr != nwpan_dev->short_addr)
+			return -EBUSY;
+
+		if (wpan_dev->extended_addr != nwpan_dev->extended_addr)
+			return -EBUSY;
+	}
+
+	if (local->hw.flags & IEEE802154_HW_CSMA_PARAMS) {
+		if (wpan_dev->min_be != nwpan_dev->min_be)
+			return -EBUSY;
+
+		if (wpan_dev->max_be != nwpan_dev->max_be)
+			return -EBUSY;
+
+		if (wpan_dev->csma_retries != nwpan_dev->csma_retries)
+			return -EBUSY;
+	}
+
+	if (local->hw.flags & IEEE802154_HW_FRAME_RETRIES) {
+		if (wpan_dev->frame_retries != nwpan_dev->frame_retries)
+			return -EBUSY;
+	}
+
+	if (local->hw.flags & IEEE802154_HW_LBT) {
+		if (wpan_dev->lbt != nwpan_dev->lbt)
+			return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int
+ieee802154_check_concurrent_iface(struct ieee802154_sub_if_data *sdata,
+				  enum nl802154_iftype iftype)
+{
+	struct ieee802154_local *local = sdata->local;
+	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
+	struct ieee802154_sub_if_data *nsdata;
+
+	/* we hold the RTNL here so can safely walk the list */
+	list_for_each_entry(nsdata, &local->interfaces, list) {
+		if (nsdata != sdata && ieee802154_sdata_running(nsdata)) {
+			int ret;
+
+			/* check all phy mac sublayer settings are the same.
+			 * We have only one phy, different values makes trouble.
+			 */
+			ret = ieee802154_check_mac_settings(local, wpan_dev,
+							    &nsdata->wpan_dev);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int mac802154_wpan_open(struct net_device *dev)
 {
 	int rc;
@@ -183,6 +256,10 @@ static int mac802154_wpan_open(struct net_device *dev)
 	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
 	struct wpan_phy *phy = sdata->local->phy;
 
+	rc = ieee802154_check_concurrent_iface(sdata, sdata->vif.type);
+	if (rc < 0)
+		return rc;
+
 	rc = mac802154_slave_open(dev);
 	if (rc < 0)
 		return rc;
-- 
2.2.0

