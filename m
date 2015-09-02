Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37366 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754315AbbIBMWG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 2 Sep 2015 08:22:06 -0400
Received: by wicfx3 with SMTP id fx3so17116500wic.0
        for <linux-wpan@vger.kernel.org>; Wed, 02 Sep 2015 05:22:05 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 03/16] ieee802154: 6lowpan: remove check on null
Date: Wed,  2 Sep 2015 14:21:18 +0200
Message-Id: <1441196491-25013-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1441196491-25013-1-git-send-email-alex.aring@gmail.com>
References: <1441196491-25013-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes one check on null which should be already done by
checking before for ARPHRD_IEEE802154. All ARPHRD_IEEE802154 and
ARPHRD_IEEE802154_MONITOR should have wdev->ieee802154_ptr, where
ARPHRD_IEEE802154 is currently a node interface only.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 5b418ce..3b75210 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -214,7 +214,7 @@ static int lowpan_device_event(struct notifier_block *unused,
 		 * also delete possible lowpan interfaces which belongs
 		 * to the wpan interface.
 		 */
-		if (wdev->ieee802154_ptr && wdev->ieee802154_ptr->lowpan_dev)
+		if (wdev->ieee802154_ptr->lowpan_dev)
 			lowpan_dellink(wdev->ieee802154_ptr->lowpan_dev, NULL);
 		break;
 	default:
-- 
2.5.1

