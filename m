Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:36825 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbbKYO71 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 25 Nov 2015 09:59:27 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH v2 bluetooth-next 1/7] 6lowpan: clarify Kconfig entries for upcoming GHC support
Date: Wed, 25 Nov 2015 15:59:11 +0100
Message-Id: <1448463557-22618-2-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1448463557-22618-1-git-send-email-stefan@osg.samsung.com>
References: <1448463557-22618-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-bluetooth@vger.kernel.org, Stefan Schmidt <stefan@osg.samsung.com>

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
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
2.4.3

