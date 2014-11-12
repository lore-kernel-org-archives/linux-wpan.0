Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38560 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754939AbaKLCht (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Nov 2014 21:37:49 -0500
Received: by mail-wi0-f175.google.com with SMTP id ex7so3486882wid.8
        for <linux-wpan@vger.kernel.org>; Tue, 11 Nov 2014 18:37:48 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 05/18] mac802154: change module description
Date: Wed, 12 Nov 2014 03:36:52 +0100
Message-Id: <1415759825-8309-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
References: <1415759825-8309-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch changes the module description like wireless which is IEEE
802.11 "subsystem" and not "implementation".

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 24e8ca6..40a3264 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -182,5 +182,5 @@ void ieee802154_unregister_hw(struct ieee802154_hw *hw)
 }
 EXPORT_SYMBOL(ieee802154_unregister_hw);
 
-MODULE_DESCRIPTION("IEEE 802.15.4 implementation");
+MODULE_DESCRIPTION("IEEE 802.15.4 subsystem");
 MODULE_LICENSE("GPL v2");
-- 
2.1.3

