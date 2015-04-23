Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:36419 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030231AbbDWQsa (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Apr 2015 12:48:30 -0400
Received: by wizk4 with SMTP id k4so223260547wiz.1
        for <linux-wpan@vger.kernel.org>; Thu, 23 Apr 2015 09:48:29 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 01/15] nl802154: cleanup invalid argument handling
Date: Thu, 23 Apr 2015 18:47:40 +0200
Message-Id: <1429807674-24849-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1429807674-24849-1-git-send-email-alex.aring@gmail.com>
References: <1429807674-24849-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, phoebe.buckheister@itwm.fraunhofer.de, Alexander Aring <alex.aring@gmail.com>

This patch cleanups the -EINVAL cases by combining them in one
condition.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/nl802154.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index a4daf91..9de427d 100644
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

