Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:35057 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbbDHLS7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 8 Apr 2015 07:18:59 -0400
Received: by wgyo15 with SMTP id o15so73722190wgy.2
        for <linux-wpan@vger.kernel.org>; Wed, 08 Apr 2015 04:18:58 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 2/4] ieee802154: move channels supported out of softmac
Date: Wed,  8 Apr 2015 13:18:30 +0200
Message-Id: <1428491912-14027-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1428491912-14027-1-git-send-email-alex.aring@gmail.com>
References: <1428491912-14027-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch moves the check on channels_supported out of softmac
implementation. We can and should do that earlier in nl802154
implementation.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/nl802154.c | 4 ++++
 net/mac802154/cfg.c       | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 4172e21..4ea64ef 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -628,6 +628,10 @@ static int nl802154_set_channel(struct sk_buff *skb, struct genl_info *info)
 	if (page > IEEE802154_MAX_PAGE || channel > IEEE802154_MAX_CHANNEL)
 		return -EINVAL;
 
+	/* check if phy support this setting */
+	if (!(rdev->wpan_phy.supported.channels[page] & BIT(channel)))
+		return -EINVAL;
+
 	return rdev_set_channel(rdev, page, channel);
 }
 
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index 191143a..d8bb593 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -70,10 +70,6 @@ ieee802154_set_channel(struct wpan_phy *wpan_phy, u8 page, u8 channel)
 
 	ASSERT_RTNL();
 
-	/* check if phy support this setting */
-	if (!(wpan_phy->supported.channels[page] & BIT(channel)))
-		return -EINVAL;
-
 	ret = drv_set_channel(local, page, channel);
 	if (!ret) {
 		wpan_phy->current_page = page;
-- 
2.3.5

