Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36220 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753412AbcDKJE2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 11 Apr 2016 05:04:28 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH bluetooth-next 03/11] nl802154: avoid address change while running lowpan
Date: Mon, 11 Apr 2016 11:04:16 +0200
Message-Id: <1460365464-12435-4-git-send-email-aar@pengutronix.de>
In-Reply-To: <1460365464-12435-1-git-send-email-aar@pengutronix.de>
References: <1460365464-12435-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, Alexander Aring <aar@pengutronix.de>

The generation of autoconfigured IPv6 link-local addresses starts with a
notification on interface up.

To handle autoconfiguration according to RFC 4944 requires pan id and
short address to generate an autoconfigured link-local address. This
patch will avoid changing of these link-layer address configuration
while lowpan interface is up.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
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
2.8.0

