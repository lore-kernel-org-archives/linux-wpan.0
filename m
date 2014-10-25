Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:61771 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbaJYTTP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 25 Oct 2014 15:19:15 -0400
Received: by mail-la0-f50.google.com with SMTP id s18so4129500lam.37
        for <linux-wpan@vger.kernel.org>; Sat, 25 Oct 2014 12:19:13 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 3/7] mac802154: move wpan.c to iface.c
Date: Sat, 25 Oct 2014 09:41:01 +0200
Message-Id: <1414222865-1692-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414222865-1692-1-git-send-email-alex.aring@gmail.com>
References: <1414222865-1692-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

The wpan.c file contains the interface handling functions now. It's similar
like the mac80211 iface.c file. This patch renames this file to iface.c to
have similar naming convention in mac802154.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/Makefile            | 2 +-
 net/mac802154/{wpan.c => iface.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename net/mac802154/{wpan.c => iface.c} (100%)

diff --git a/net/mac802154/Makefile b/net/mac802154/Makefile
index 1ecbc47..203f42d 100644
--- a/net/mac802154/Makefile
+++ b/net/mac802154/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_MAC802154)	+= mac802154.o
 mac802154-objs		:= main.o rx.o tx.o mac_cmd.o mib.o \
-			   monitor.o wpan.o llsec.o
+			   monitor.o iface.o llsec.o
 
 ccflags-y += -D__CHECK_ENDIAN__
diff --git a/net/mac802154/wpan.c b/net/mac802154/iface.c
similarity index 100%
rename from net/mac802154/wpan.c
rename to net/mac802154/iface.c
-- 
2.1.2

