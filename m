Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:45234 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336AbbETN2Q (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 May 2015 09:28:16 -0400
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH atubs-fw 4/4] atusb/fw: Bump minor version to mark first public release.
Date: Wed, 20 May 2015 15:18:14 +0200
Message-Id: <1432127894-4760-5-git-send-email-stefan@datenfreihafen.org>
In-Reply-To: <1432127894-4760-1-git-send-email-stefan@datenfreihafen.org>
References: <1432127894-4760-1-git-send-email-stefan@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, werner@almesberger.net, Stefan Schmidt <stefan@datenfreihafen.org>

With version 0.2 we made the first public release in binary form of the
firmware. This comes together with the merge of the ATUSB driver to the
mainline linux kernel.

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
---
 atusb/fw/include/atusb/ep0.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/atusb/fw/include/atusb/ep0.h b/atusb/fw/include/atusb/ep0.h
index d21878f..8b0ab9a 100644
--- a/atusb/fw/include/atusb/ep0.h
+++ b/atusb/fw/include/atusb/ep0.h
@@ -22,10 +22,11 @@
  *
  * 0.0	initial release
  * 0.1  addition of ATUSB_TEST
+ * 0.2  First public release
  */
 
 #define EP0ATUSB_MAJOR	0	/* EP0 protocol, major revision */
-#define EP0ATUSB_MINOR	1	/* EP0 protocol, minor revision */
+#define EP0ATUSB_MINOR	2	/* EP0 protocol, minor revision */
 
 #define	HW_TYPE_100813	0	/* 2010-08-13 */
 #define	HW_TYPE_101216	1	/* 2010-12-16 */
-- 
2.1.0

