Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:40502 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbaKETwM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 5 Nov 2014 14:52:12 -0500
Received: by mail-wg0-f52.google.com with SMTP id b13so1749233wgh.25
        for <linux-wpan@vger.kernel.org>; Wed, 05 Nov 2014 11:52:11 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 05/18] mac802154: move dev_hold out of ieee802154_if_add
Date: Wed,  5 Nov 2014 20:51:16 +0100
Message-Id: <1415217089-24919-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
References: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch moves the dev_hold call inside of nl-phy ieee802154_add_iface
function. The ieee802154_add_iface is the only one function which use the
ieee802154_if_add function and contains the corresponding dev_put call.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/nl-phy.c | 1 +
 net/mac802154/iface.c   | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/nl-phy.c b/net/ieee802154/nl-phy.c
index 5d914d3..397ca126 100644
--- a/net/ieee802154/nl-phy.c
+++ b/net/ieee802154/nl-phy.c
@@ -226,6 +226,7 @@ int ieee802154_add_iface(struct sk_buff *skb, struct genl_info *info)
 		rc = PTR_ERR(dev);
 		goto nla_put_failure;
 	}
+	dev_hold(dev);
 
 	if (info->attrs[IEEE802154_ATTR_HW_ADDR]) {
 		struct sockaddr addr;
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index fced04b..78cb381 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -501,7 +501,6 @@ ieee802154_if_add(struct ieee802154_local *local, const char *name,
 	if (err)
 		goto err_free;
 
-	dev_hold(dev); /* we return an incremented device refcount */
 	return dev;
 
 err_free:
-- 
2.1.3

