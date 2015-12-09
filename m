Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36122 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123AbbLIVrZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 9 Dec 2015 16:47:25 -0500
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 01/10] 6lowpan: clarify Kconfig entries for upcoming GHC support
Date: Wed,  9 Dec 2015 22:46:22 +0100
Message-Id: <1449697591-15991-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1449697591-15991-1-git-send-email-alex.aring@gmail.com>
References: <1449697591-15991-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, kernel@pengutronix.de, Stefan Schmidt <stefan@osg.samsung.com>, Alexander Aring <alex.aring@gmail.com>

From: Stefan Schmidt <stefan@osg.samsung.com>

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/6lowpan/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/6lowpan/Kconfig b/net/6lowpan/Kconfig
index 7fa0f38..6af7a46 100644
--- a/net/6lowpan/Kconfig
+++ b/net/6lowpan/Kconfig
@@ -6,11 +6,12 @@ menuconfig 6LOWPAN
 	  "6LoWPAN" which is supported by IEEE 802.15.4 or Bluetooth stacks.
 
 menuconfig 6LOWPAN_NHC
-	tristate "Next Header Compression Support"
+	tristate "Next Header and Generic Header Compression Support"
 	depends on 6LOWPAN
 	default y
 	---help---
-	  Support for next header compression.
+	  Support for next header and generic header compression defined in
+	  RFC6282 and RFC7400.
 
 if 6LOWPAN_NHC
 
-- 
2.6.1

