Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:41561 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbaLaSji (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 31 Dec 2014 13:39:38 -0500
Received: by mail-wg0-f52.google.com with SMTP id x12so22253303wgg.25
        for <linux-wpan@vger.kernel.org>; Wed, 31 Dec 2014 10:39:36 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/6] ieee802154: handle socket functionality as module
Date: Wed, 31 Dec 2014 19:39:08 +0100
Message-Id: <1420051153-8673-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1420051153-8673-1-git-send-email-alex.aring@gmail.com>
References: <1420051153-8673-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch makes the ieee802154 socket handling as module. Currently
this is part of ieee802154 module. It pointed out that ieee802154 module
has also two module_init/module_exit functions. One inside of core.c and
the other in af_ieee802154.c. This patch will also solve this issue by
handle the af_802154 as separate module.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/Kconfig  | 9 +++++++++
 net/ieee802154/Makefile | 3 ++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/ieee802154/Kconfig b/net/ieee802154/Kconfig
index c0d4154..98a190d 100644
--- a/net/ieee802154/Kconfig
+++ b/net/ieee802154/Kconfig
@@ -10,6 +10,15 @@ config IEEE802154
 	  Say Y here to compile LR-WPAN support into the kernel or say M to
 	  compile it as modules.
 
+config IEEE802154_SOCKET
+	tristate "IEEE 802.15.4 socket interface"
+	depends on IEEE802154
+	default y
+	---help---
+	  Socket interface for IEEE 802.15.4. Contains DGRAM sockets interface
+	  for 802.15.4 dataframes. Also RAW socket interface to build MAC
+	  header from userspace.
+
 config IEEE802154_6LOWPAN
 	tristate "6lowpan support over IEEE 802.15.4"
 	depends on IEEE802154 && 6LOWPAN
diff --git a/net/ieee802154/Makefile b/net/ieee802154/Makefile
index 9f6970f..53612d1 100644
--- a/net/ieee802154/Makefile
+++ b/net/ieee802154/Makefile
@@ -1,4 +1,5 @@
-obj-$(CONFIG_IEEE802154) += ieee802154.o af_802154.o
+obj-$(CONFIG_IEEE802154) += ieee802154.o
+obj-$(CONFIG_IEEE802154_SOCKET) += af_802154.o
 obj-$(CONFIG_IEEE802154_6LOWPAN) += ieee802154_6lowpan.o
 
 ieee802154_6lowpan-y := 6lowpan_rtnl.o reassembly.o
-- 
2.2.0

