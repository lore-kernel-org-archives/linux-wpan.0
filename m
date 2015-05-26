Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33816 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbbEZVLm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 26 May 2015 17:11:42 -0400
Received: by wicmc15 with SMTP id mc15so76417551wic.1
        for <linux-wpan@vger.kernel.org>; Tue, 26 May 2015 14:11:41 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] nl802154: fix cca mode wpan phy flag
Date: Tue, 26 May 2015 23:11:31 +0200
Message-Id: <1432674691-2008-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch fix the handling to call cca mode setting. If the phy isn't
flag then the driver doesn't support this setting.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Reported-by: Varka Bhadram <varkabhadram@gmail.com>
---
 net/ieee802154/nl802154.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 54f4959..212a795 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -757,7 +757,7 @@ static int nl802154_set_cca_mode(struct sk_buff *skb, struct genl_info *info)
 	struct cfg802154_registered_device *rdev = info->user_ptr[0];
 	struct wpan_phy_cca cca;
 
-	if (rdev->wpan_phy.flags & WPAN_PHY_FLAG_CCA_MODE)
+	if (!(rdev->wpan_phy.flags & WPAN_PHY_FLAG_CCA_MODE))
 		return -EOPNOTSUPP;
 
 	if (!info->attrs[NL802154_ATTR_CCA_MODE])
-- 
2.4.1

