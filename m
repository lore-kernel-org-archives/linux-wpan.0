Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:43865 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754050AbbICMyb (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 3 Sep 2015 08:54:31 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH bluetooth-next] ieee802154: 6lowpan: use correct ESC value for dispatch
Date: Thu,  3 Sep 2015 14:54:19 +0200
Message-Id: <1441284859-22191-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

The ESC dispatch value has some history and it originally was 0x7f in rfc4944
(see section-5.1). With the release of rfc6282 this value got part of the
LOWPAN_IPHC range and was no longer available for ESC. Instead 0x40 was used
as replacement (see section-2 in rfc6282).

We have been checking the dispatch byte in an order where IPHC would always be
evaluated before ESC and thus we would never reach the ESC check as the IPHC
range already covers this value.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 net/ieee802154/6lowpan/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
index 3c31980..b1fd47d 100644
--- a/net/ieee802154/6lowpan/rx.c
+++ b/net/ieee802154/6lowpan/rx.c
@@ -20,7 +20,7 @@
 #define LOWPAN_DISPATCH_FRAG_MASK	0xf8
 
 #define LOWPAN_DISPATCH_NALP		0x00
-#define LOWPAN_DISPATCH_ESC		0x7f
+#define LOWPAN_DISPATCH_ESC		0x40
 #define LOWPAN_DISPATCH_HC1		0x42
 #define LOWPAN_DISPATCH_DFF		0x43
 #define LOWPAN_DISPATCH_BC0		0x50
-- 
2.4.3

