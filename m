Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:53410 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955AbbFRIhq (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Jun 2015 04:37:46 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 1/3] wpan-ping: adjust maximal packet length for extended addresses
Date: Thu, 18 Jun 2015 10:37:34 +0200
Message-Id: <1434616656-16209-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

This value is to static right now but does its job. It needs to get
more flexible based on various things like addressing scheme and link
layer crypto in the future.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 wpan-ping/wpan-ping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wpan-ping/wpan-ping.c b/wpan-ping/wpan-ping.c
index 0d9da44..d4d0002 100644
--- a/wpan-ping/wpan-ping.c
+++ b/wpan-ping/wpan-ping.c
@@ -43,7 +43,7 @@
 #include "../src/nl802154.h"
 
 #define MIN_PAYLOAD_LEN 5
-#define MAX_PAYLOAD_LEN 116
+#define MAX_PAYLOAD_LEN 105 //116 with short address
 #define IEEE802154_ADDR_LEN 8
 /* Set the dispatch header to not 6lowpan for compat */
 #define NOT_A_6LOWPAN_FRAME 0x00
-- 
2.4.3

