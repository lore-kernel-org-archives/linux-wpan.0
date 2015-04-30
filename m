Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33793 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbbD3JrU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 30 Apr 2015 05:47:20 -0400
Received: by wicmx19 with SMTP id mx19so8858601wic.1
        for <linux-wpan@vger.kernel.org>; Thu, 30 Apr 2015 02:47:19 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-next 1/2] nl802154: cleanup invalid argument handling
Date: Thu, 30 Apr 2015 11:47:11 +0200
Message-Id: <1430387232-24878-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch cleanups the -EINVAL cases by combining them in one
condition.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/nl802154.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index f3c12f6..c01f4bb 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -668,10 +668,8 @@ static int nl802154_set_pan_id(struct sk_buff *skb, struct genl_info *info)
 		return -EBUSY;
 
 	/* don't change address fields on monitor */
-	if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR)
-		return -EINVAL;
-
-	if (!info->attrs[NL802154_ATTR_PAN_ID])
+	if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR ||
+	    !info->attrs[NL802154_ATTR_PAN_ID])
 		return -EINVAL;
 
 	pan_id = nla_get_le16(info->attrs[NL802154_ATTR_PAN_ID]);
@@ -691,10 +689,8 @@ static int nl802154_set_short_addr(struct sk_buff *skb, struct genl_info *info)
 		return -EBUSY;
 
 	/* don't change address fields on monitor */
-	if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR)
-		return -EINVAL;
-
-	if (!info->attrs[NL802154_ATTR_SHORT_ADDR])
+	if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR ||
+	    !info->attrs[NL802154_ATTR_SHORT_ADDR])
 		return -EINVAL;
 
 	short_addr = nla_get_le16(info->attrs[NL802154_ATTR_SHORT_ADDR]);
-- 
2.3.6

