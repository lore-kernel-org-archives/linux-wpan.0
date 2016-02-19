Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60699 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752585AbcBSI7Q (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Fri, 19 Feb 2016 03:59:16 -0500
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH bluetooth-next 1/5] MAINTAINERS: update 802.15.4 entries
Date: Fri, 19 Feb 2016 09:59:10 +0100
Message-Id: <1455872354-26032-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>

This patch updates my e-mail address and other pending information for
802.15.4 subsystem which are not correct anymore.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 MAINTAINERS | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f678c37..a8a01a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -151,7 +151,7 @@ S:	Maintained
 F:	drivers/scsi/53c700*
 
 6LOWPAN GENERIC (BTLE/IEEE 802.15.4)
-M:	Alexander Aring <alex.aring@gmail.com>
+M:	Alexander Aring <aar@pengutronix.de>
 M:	Jukka Rissanen <jukka.rissanen@linux.intel.com>
 L:	linux-bluetooth@vger.kernel.org
 L:	linux-wpan@vger.kernel.org
@@ -5424,10 +5424,11 @@ S:	Supported
 F:	drivers/idle/i7300_idle.c
 
 IEEE 802.15.4 SUBSYSTEM
-M:	Alexander Aring <alex.aring@gmail.com>
+M:	Alexander Aring <aar@pengutronix.de>
 L:	linux-wpan@vger.kernel.org
-W:	https://github.com/linux-wpan
-T:	git git://github.com/linux-wpan/linux-wpan-next.git
+W:	http://wpan.cakelab.org/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
 S:	Maintained
 F:	net/ieee802154/
 F:	net/mac802154/
-- 
2.7.1

