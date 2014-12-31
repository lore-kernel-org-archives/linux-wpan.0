Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:49021 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbaLaSjn (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 31 Dec 2014 13:39:43 -0500
Received: by mail-wg0-f41.google.com with SMTP id y19so22366264wgg.14
        for <linux-wpan@vger.kernel.org>; Wed, 31 Dec 2014 10:39:42 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 6/6] ieee802154: handle config as menuconfig
Date: Wed, 31 Dec 2014 19:39:13 +0100
Message-Id: <1420051153-8673-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1420051153-8673-1-git-send-email-alex.aring@gmail.com>
References: <1420051153-8673-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch handles the IEEE802154 Kconfig entry as menuconfig.
Furthermore we move this entry out of "Network Options" and put it into
"Networking" where the other networking subsystems are. This requires a
menuconfig entry like all other networking subsystems.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/Kconfig | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ieee802154/Kconfig b/net/ieee802154/Kconfig
index 98a190d..9ea0af4 100644
--- a/net/ieee802154/Kconfig
+++ b/net/ieee802154/Kconfig
@@ -1,4 +1,4 @@
-config IEEE802154
+menuconfig IEEE802154
 	tristate "IEEE Std 802.15.4 Low-Rate Wireless Personal Area Networks support"
 	---help---
 	  IEEE Std 802.15.4 defines a low data rate, low power and low
@@ -10,9 +10,10 @@ config IEEE802154
 	  Say Y here to compile LR-WPAN support into the kernel or say M to
 	  compile it as modules.
 
+if IEEE802154
+
 config IEEE802154_SOCKET
 	tristate "IEEE 802.15.4 socket interface"
-	depends on IEEE802154
 	default y
 	---help---
 	  Socket interface for IEEE 802.15.4. Contains DGRAM sockets interface
@@ -21,6 +22,8 @@ config IEEE802154_SOCKET
 
 config IEEE802154_6LOWPAN
 	tristate "6lowpan support over IEEE 802.15.4"
-	depends on IEEE802154 && 6LOWPAN
+	depends on 6LOWPAN
 	---help---
 	  IPv6 compression over IEEE 802.15.4.
+
+endif
-- 
2.2.0

