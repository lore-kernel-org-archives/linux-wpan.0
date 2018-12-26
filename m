Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbeLZWg2 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 26 Dec 2018 17:36:28 -0500
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 19/97] ieee802154: hwsim: fix off-by-one in parse nested
Date: Wed, 26 Dec 2018 17:34:39 -0500
Message-Id: <20181226223557.149329-19-sashal@kernel.org>
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alexander Aring <aring@mojatatu.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Sasha Levin <sashal@kernel.org>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org

From: Alexander Aring <aring@mojatatu.com>

[ Upstream commit a73d4e1490913b76b292f91553b7ba08a65caa3f ]

This patch fixes a off-by-one mistake in nla_parse_nested() functions of
mac802154_hwsim driver. I had to enabled stack protector so I was able
to reproduce it.

Reference: https://github.com/linux-wpan/wpan-tools/issues/17

Signed-off-by: Alexander Aring <aring@mojatatu.com>
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.19.1
