Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:54818 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbaJYDZh (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Oct 2014 23:25:37 -0400
Received: by mail-lb0-f169.google.com with SMTP id 10so3479108lbg.28
        for <linux-wpan@vger.kernel.org>; Fri, 24 Oct 2014 20:25:35 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 2/6] ieee802154: ieee802154_dev: fix align typo
Date: Sat, 25 Oct 2014 05:25:08 +0200
Message-Id: <1414207512-10281-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414207512-10281-1-git-send-email-alex.aring@gmail.com>
References: <1414207512-10281-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch fix a typo and fix align instead allign.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/ieee802154_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac802154/ieee802154_dev.c b/net/mac802154/ieee802154_dev.c
index 6af6a24..086d4a9 100644
--- a/net/mac802154/ieee802154_dev.c
+++ b/net/mac802154/ieee802154_dev.c
@@ -263,7 +263,7 @@ ieee802154_alloc_device(size_t priv_data_len, struct ieee802154_ops *ops)
 	 * +-----------------------+
 	 *
 	 * Due to ieee802154 layer isn't aware of driver and MAC structures,
-	 * so lets allign them here.
+	 * so lets align them here.
 	 */
 
 	priv_size = ALIGN(sizeof(*priv), NETDEV_ALIGN) + priv_data_len;
-- 
2.1.2

