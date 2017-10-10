Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36931 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932283AbdJJPRy (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 10 Oct 2017 11:17:54 -0400
Received: by mail-wm0-f68.google.com with SMTP id r68so13358077wmr.4
        for <linux-wpan@vger.kernel.org>; Tue, 10 Oct 2017 08:17:53 -0700 (PDT)
From: Xue Liu <liuxuenetmail@gmail.com>
Subject: [PATCH] 802154:netlink - fix typo of the name of struct genl_ops
Date: Tue, 10 Oct 2017 17:17:45 +0200
Message-Id: <1507648665-14932-1-git-send-email-liuxuenetmail@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Xue Liu <liuxuenetmail@gmail.com>

Signed-off-by: Xue Liu <liuxuenetmail@gmail.com>
---
 net/ieee802154/netlink.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ieee802154/netlink.c b/net/ieee802154/netlink.c
index 6bde9e5..96636e3 100644
--- a/net/ieee802154/netlink.c
+++ b/net/ieee802154/netlink.c
@@ -89,7 +89,7 @@ int ieee802154_nl_reply(struct sk_buff *msg, struct genl_info *info)
 	return genlmsg_reply(msg, info);
 }
 
-static const struct genl_ops ieee8021154_ops[] = {
+static const struct genl_ops ieee802154_ops[] = {
 	/* see nl-phy.c */
 	IEEE802154_DUMP(IEEE802154_LIST_PHY, ieee802154_list_phy,
 			ieee802154_dump_phy),
@@ -137,8 +137,8 @@ struct genl_family nl802154_family __ro_after_init = {
 	.version	= 1,
 	.maxattr	= IEEE802154_ATTR_MAX,
 	.module		= THIS_MODULE,
-	.ops		= ieee8021154_ops,
-	.n_ops		= ARRAY_SIZE(ieee8021154_ops),
+	.ops		= ieee802154_ops,
+	.n_ops		= ARRAY_SIZE(ieee802154_ops),
 	.mcgrps		= ieee802154_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(ieee802154_mcgrps),
 };
-- 
2.7.4

