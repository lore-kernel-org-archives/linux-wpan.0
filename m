Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it1-f173.google.com ([209.85.166.173]:56319 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeK3JtF (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 30 Nov 2018 04:49:05 -0500
Received: by mail-it1-f173.google.com with SMTP id o19so6306533itg.5
        for <linux-wpan@vger.kernel.org>; Thu, 29 Nov 2018 14:42:01 -0800 (PST)
From: Alexander Aring <aring@mojatatu.com>
Subject: [PATCHv2 wpan] ieee802154: hwsim: fix off-by-one in parse nested
Date: Thu, 29 Nov 2018 17:41:54 -0500
Message-Id: <20181129224154.7525-1-aring@mojatatu.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@datenfreihafen.org
Cc: linux-wpan@vger.kernel.org, Alexander Aring <aring@mojatatu.com>

This patch fixes a off-by-one mistake in nla_parse_nested() functions of
mac802154_hwsim driver. I had to enabled stack protector so I was able
to reproduce it.

Reference: https://github.com/linux-wpan/wpan-tools/issues/17

Signed-off-by: Alexander Aring <aring@mojatatu.com>
---
 drivers/net/ieee802154/mac802154_hwsim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index bf70ab892e69..624bff4d3636 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -500,7 +500,7 @@ static int hwsim_del_edge_nl(struct sk_buff *msg, struct genl_info *info)
 	    !info->attrs[MAC802154_HWSIM_ATTR_RADIO_EDGE])
 		return -EINVAL;
 
-	if (nla_parse_nested(edge_attrs, MAC802154_HWSIM_EDGE_ATTR_MAX + 1,
+	if (nla_parse_nested(edge_attrs, MAC802154_HWSIM_EDGE_ATTR_MAX,
 			     info->attrs[MAC802154_HWSIM_ATTR_RADIO_EDGE],
 			     hwsim_edge_policy, NULL))
 		return -EINVAL;
@@ -550,7 +550,7 @@ static int hwsim_set_edge_lqi(struct sk_buff *msg, struct genl_info *info)
 	    !info->attrs[MAC802154_HWSIM_ATTR_RADIO_EDGE])
 		return -EINVAL;
 
-	if (nla_parse_nested(edge_attrs, MAC802154_HWSIM_EDGE_ATTR_MAX + 1,
+	if (nla_parse_nested(edge_attrs, MAC802154_HWSIM_EDGE_ATTR_MAX,
 			     info->attrs[MAC802154_HWSIM_ATTR_RADIO_EDGE],
 			     hwsim_edge_policy, NULL))
 		return -EINVAL;
-- 
2.11.0
