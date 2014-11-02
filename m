Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:57263 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbaKBDTT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 1 Nov 2014 23:19:19 -0400
Received: by mail-wi0-f178.google.com with SMTP id q5so3944006wiv.17
        for <linux-wpan@vger.kernel.org>; Sat, 01 Nov 2014 20:19:18 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 08/16] ieee802154: don't allow to change addr while netif_running
Date: Sun,  2 Nov 2014 04:18:39 +0100
Message-Id: <1414898327-20759-9-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
References: <1414898327-20759-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch changes the actual behaviour for setting address attributes.
We should not change addresses while netif_running is true. Furthermore
when netif_running is running the address attributes becomes read only
and we can remove locking mechanism in receive and transmit hothpaths
of 802.15.4 subsystem.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/nl-mac.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/ieee802154/nl-mac.c b/net/ieee802154/nl-mac.c
index abd0f31..cc2919d 100644
--- a/net/ieee802154/nl-mac.c
+++ b/net/ieee802154/nl-mac.c
@@ -477,7 +477,7 @@ int ieee802154_start_req(struct sk_buff *skb, struct genl_info *info)
 	u8 channel, bcn_ord, sf_ord;
 	u8 page;
 	int pan_coord, blx, coord_realign;
-	int ret = -EOPNOTSUPP;
+	int ret = -EBUSY;
 
 	if (!info->attrs[IEEE802154_ATTR_COORD_PAN_ID] ||
 	    !info->attrs[IEEE802154_ATTR_COORD_SHORT_ADDR] ||
@@ -493,9 +493,15 @@ int ieee802154_start_req(struct sk_buff *skb, struct genl_info *info)
 	dev = ieee802154_nl_get_dev(info);
 	if (!dev)
 		return -ENODEV;
-	if (!ieee802154_mlme_ops(dev)->start_req)
+
+	if (netif_running(dev))
 		goto out;
 
+	if (!ieee802154_mlme_ops(dev)->start_req) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
 	addr.mode = IEEE802154_ADDR_SHORT;
 	addr.short_addr = nla_get_shortaddr(
 			info->attrs[IEEE802154_ATTR_COORD_SHORT_ADDR]);
-- 
2.1.3

