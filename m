Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:56679 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbbAAPwk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 1 Jan 2015 10:52:40 -0500
Received: by mail-we0-f169.google.com with SMTP id m14so3586235wev.0
        for <linux-wpan@vger.kernel.org>; Thu, 01 Jan 2015 07:52:39 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] af_ieee802154: make header uapi conform
Date: Thu,  1 Jan 2015 16:44:37 +0100
Message-Id: <1420127077-25699-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch uses __u16 and __u8 instead of u16 and u8 typedefs. These
typedefs coming from linux/types.h and are also easily available in
standard userspace environments. The af_ieee802154 header is normally
an userspace header. For now, we just copy this header in an userspace
application.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
The "int addr_type" should be the above enum. I will fix this later. This
header has also other various issues. For now I just want the same version
in userspace which is also inside kernelspace.

 include/net/af_ieee802154.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/net/af_ieee802154.h b/include/net/af_ieee802154.h
index 7d38e2f..63af3f2 100644
--- a/include/net/af_ieee802154.h
+++ b/include/net/af_ieee802154.h
@@ -21,6 +21,7 @@
 #define _AF_IEEE802154_H
 
 #include <linux/socket.h> /* for sa_family_t */
+#include <linux/types.h>
 
 enum {
 	IEEE802154_ADDR_NONE = 0x0,
@@ -34,10 +35,10 @@ enum {
 
 struct ieee802154_addr_sa {
 	int addr_type;
-	u16 pan_id;
+	__u16 pan_id;
 	union {
-		u8 hwaddr[IEEE802154_ADDR_LEN];
-		u16 short_addr;
+		__u8 hwaddr[IEEE802154_ADDR_LEN];
+		__u16 short_addr;
 	};
 };
 
-- 
2.2.0

