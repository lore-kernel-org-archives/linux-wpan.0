Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33489 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757299AbcKCPTs (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 3 Nov 2016 11:19:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id u144so8549571wmu.0
        for <linux-wpan@vger.kernel.org>; Thu, 03 Nov 2016 08:19:47 -0700 (PDT)
From: harrymorris12@gmail.com
Subject: [PATCH v2 3/3] ieee802154: Add entry in MAINTAINTERS for CA8210 driver
Date: Thu,  3 Nov 2016 15:16:51 +0000
Message-Id: <20161103151651.7880-4-h.morris@cascoda.com>
In-Reply-To: <20161103151651.7880-1-h.morris@cascoda.com>
References: <20161103151651.7880-1-h.morris@cascoda.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, stefan@osg.samsung.com, Harry Morris <h.morris@cascoda.com>

From: Harry Morris <h.morris@cascoda.com>

Signed-off-by: Harry Morris <h.morris@cascoda.com>
Acked-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5e925a2..cb3428f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2829,6 +2829,15 @@ W:	http://www.linux-c6x.org/wiki/index.php/Main_Page
 S:	Maintained
 F:	arch/c6x/
 
+CA8210 IEEE-802.15.4 RADIO DRIVER
+M:	Harry Morris <h.morris@cascoda.com>
+M:	linuxdev@cascoda.com
+L:	linux-wpan@vger.kernel.org
+W:	https://github.com/Cascoda/ca8210-linux.git
+S:	Maintained
+F:	drivers/net/ieee802154/ca8210.c
+F:	Documentation/devicetree/bindings/net/ieee802154/ca8210.txt
+
 CACHEFILES: FS-CACHE BACKEND FOR CACHING ON MOUNTED FILESYSTEMS
 M:	David Howells <dhowells@redhat.com>
 L:	linux-cachefs@redhat.com (moderated for non-subscribers)
-- 
2.9.3.windows.1

