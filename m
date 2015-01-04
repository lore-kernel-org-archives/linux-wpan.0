Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:64519 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680AbbADQLR (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 4 Jan 2015 11:11:17 -0500
Received: by mail-we0-f173.google.com with SMTP id q58so6644193wes.32
        for <linux-wpan@vger.kernel.org>; Sun, 04 Jan 2015 08:11:16 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 5/5] ieee802154: 6lowpan: rename to core
Date: Sun,  4 Jan 2015 17:10:57 +0100
Message-Id: <1420387857-32029-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1420387857-32029-1-git-send-email-alex.aring@gmail.com>
References: <1420387857-32029-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch renames the 6lowpan_rtnl.c file to core.c. 6lowpan_rtnl.c
contains functionality to put all 802.15.4 6LoWPAN functionality
together.

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
2.2.1

