Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:54016 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbaJYS7m (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 25 Oct 2014 14:59:42 -0400
Received: by mail-la0-f44.google.com with SMTP id hs14so4093493lab.31
        for <linux-wpan@vger.kernel.org>; Sat, 25 Oct 2014 11:59:41 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 1/7] mac802154: move ieee802154_dev.c to main.c
Date: Sat, 25 Oct 2014 09:40:59 +0200
Message-Id: <1414222865-1692-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414222865-1692-1-git-send-email-alex.aring@gmail.com>
References: <1414222865-1692-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

The ieee802154_dev functionality contains various function for
allocation and registration of an ieee802154_dev. This is equal to the
net/mac80211/main.c file. This patch rename the ieee802154_dev.c to
main.c to have the same behaviour.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/Makefile                     | 2 +-
 net/mac802154/{ieee802154_dev.c => main.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename net/mac802154/{ieee802154_dev.c => main.c} (100%)

diff --git a/net/mac802154/Makefile b/net/mac802154/Makefile
index 9723d6f..1ecbc47 100644
--- a/net/mac802154/Makefile
+++ b/net/mac802154/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_MAC802154)	+= mac802154.o
-mac802154-objs		:= ieee802154_dev.o rx.o tx.o mac_cmd.o mib.o \
+mac802154-objs		:= main.o rx.o tx.o mac_cmd.o mib.o \
 			   monitor.o wpan.o llsec.o
 
 ccflags-y += -D__CHECK_ENDIAN__
diff --git a/net/mac802154/ieee802154_dev.c b/net/mac802154/main.c
similarity index 100%
rename from net/mac802154/ieee802154_dev.c
rename to net/mac802154/main.c
-- 
2.1.2

