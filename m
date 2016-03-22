Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33922 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758816AbcCVNPl (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 22 Mar 2016 09:15:41 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC bluetooth-next 03/19] nl802154: avoid address change while running lowpan
Date: Tue, 22 Mar 2016 14:14:59 +0100
Message-Id: <1458652515-7862-4-git-send-email-aar@pengutronix.de>
In-Reply-To: <1458652515-7862-1-git-send-email-aar@pengutronix.de>
References: <1458652515-7862-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, Alexander Aring <aar@pengutronix.de>

he whole generating of autoconfiguration IPv6 link-local addresses based
on a notification on interface up. These addresses are based on mac
addresses and are not changeable during interface up of IPv6 interfaces.
This patch will disallow mac address changes while a lowpan interface
for a wpan interface is up.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/ieee802154/nl802154.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 16ef0d9..5f1dc4b 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -1074,6 +1074,11 @@ static int nl802154_set_pan_id(struct sk_buff *skb, struct genl_info *info)
 	if (netif_running(dev))
 		return -EBUSY;
 
+	if (wpan_dev->lowpan_dev) {
+		if (netif_running(wpan_dev->lowpan_dev))
+			return -EBUSY;
+	}
+
 	/* don't change address fields on monitor */
 	if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR ||
 	    !info->attrs[NL802154_ATTR_PAN_ID])
@@ -1105,6 +1110,11 @@ static int nl802154_set_short_addr(struct sk_buff *skb, struct genl_info *info)
 	if (netif_running(dev))
 		return -EBUSY;
 
+	if (wpan_dev->lowpan_dev) {
+		if (netif_running(wpan_dev->lowpan_dev))
+			return -EBUSY;
+	}
+
 	/* don't change address fields on monitor */
 	if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR ||
 	    !info->attrs[NL802154_ATTR_SHORT_ADDR])
-- 
2.7.4

