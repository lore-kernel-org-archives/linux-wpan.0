Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:58150 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755351AbaLWKa4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Dec 2014 05:30:56 -0500
Received: by mail-wg0-f46.google.com with SMTP id x13so8734921wgg.33
        for <linux-wpan@vger.kernel.org>; Tue, 23 Dec 2014 02:30:55 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 3/3] ieee802154: 6lowpan: rename to core
Date: Tue, 23 Dec 2014 11:30:11 +0100
Message-Id: <1419330611-29410-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1419330611-29410-1-git-send-email-alex.aring@gmail.com>
References: <1419330611-29410-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch renames the 6lowpan_rtnl.c file to core.c. 6lowpan_rtnl.c
contains functionality to put all 802.15.4 6LoWPAN functionality
together. This is just keeping the same name convention like af802154.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/Makefile                   | 2 +-
 net/ieee802154/6lowpan/{6lowpan_rtnl.c => core.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename net/ieee802154/6lowpan/{6lowpan_rtnl.c => core.c} (100%)

diff --git a/net/ieee802154/6lowpan/Makefile b/net/ieee802154/6lowpan/Makefile
index 7f11c13..2f1b75a 100644
--- a/net/ieee802154/6lowpan/Makefile
+++ b/net/ieee802154/6lowpan/Makefile
@@ -1,3 +1,3 @@
 obj-y += ieee802154_6lowpan.o
 
-ieee802154_6lowpan-y := 6lowpan_rtnl.o rx.o reassembly.o tx.o
+ieee802154_6lowpan-y := core.o rx.o reassembly.o tx.o
diff --git a/net/ieee802154/6lowpan/6lowpan_rtnl.c b/net/ieee802154/6lowpan/core.c
similarity index 100%
rename from net/ieee802154/6lowpan/6lowpan_rtnl.c
rename to net/ieee802154/6lowpan/core.c
-- 
2.2.0

