Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:34097 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754AbbE0LmU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 27 May 2015 07:42:20 -0400
Received: by wgv5 with SMTP id 5so6978881wgv.1
        for <linux-wpan@vger.kernel.org>; Wed, 27 May 2015 04:42:17 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/2] nl802154: add support for cca ed level info
Date: Wed, 27 May 2015 13:42:09 +0200
Message-Id: <1432726930-20126-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1432726930-20126-1-git-send-email-alex.aring@gmail.com>
References: <1432726930-20126-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch adds information about the current cca ed level when the phy
is dumped over nl802154.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/nl802154.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 5c9d524..a89d9d0 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -211,6 +211,7 @@ static const struct nla_policy nl802154_policy[NL802154_ATTR_MAX+1] = {
 
 	[NL802154_ATTR_CCA_MODE] = { .type = NLA_U32, },
 	[NL802154_ATTR_CCA_OPT] = { .type = NLA_U32, },
+	[NL802154_ATTR_CCA_ED_LEVEL] = { .type = NLA_S32, },
 
 	[NL802154_ATTR_SUPPORTED_CHANNEL] = { .type = NLA_U32, },
 
@@ -421,6 +422,12 @@ static int nl802154_send_wpan_phy(struct cfg802154_registered_device *rdev,
 			goto nla_put_failure;
 	}
 
+	if (rdev->wpan_phy.flags & WPAN_PHY_FLAG_CCA_ED_LEVEL) {
+		if (nla_put_s32(msg, NL802154_ATTR_CCA_ED_LEVEL,
+				rdev->wpan_phy.cca_ed_level))
+			goto nla_put_failure;
+	}
+
 	if (nl802154_put_capabilities(msg, rdev))
 		goto nla_put_failure;
 
-- 
2.4.1

