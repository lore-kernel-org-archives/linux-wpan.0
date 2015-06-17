Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38513 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756426AbbFQNfp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 17 Jun 2015 09:35:45 -0400
Received: by wibdq8 with SMTP id dq8so53855486wib.1
        for <linux-wpan@vger.kernel.org>; Wed, 17 Jun 2015 06:35:44 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/2] mac802154: iface: cleanup stack variable
Date: Wed, 17 Jun 2015 15:35:18 +0200
Message-Id: <1434548118-25656-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1434548118-25656-1-git-send-email-alex.aring@gmail.com>
References: <1434548118-25656-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

There is no need to init res with zero, res can be unused but then we
returning zero and not res.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/iface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index 0b0cccb..8b69824 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -189,7 +189,7 @@ static int mac802154_slave_open(struct net_device *dev)
 {
 	struct ieee802154_sub_if_data *sdata = IEEE802154_DEV_TO_SUB_IF(dev);
 	struct ieee802154_local *local = sdata->local;
-	int res = 0;
+	int res;
 
 	ASSERT_RTNL();
 
-- 
2.4.1

