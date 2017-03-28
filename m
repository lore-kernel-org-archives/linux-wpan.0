Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34874 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbdC1ML1 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Mar 2017 08:11:27 -0400
Received: by mail-wr0-f195.google.com with SMTP id p52so19169987wrc.2
        for <linux-wpan@vger.kernel.org>; Tue, 28 Mar 2017 05:11:21 -0700 (PDT)
From: Harry Morris <harrymorris12@gmail.com>
Subject: [PATCH v9 3/3] ieee802154: Add entry in MAINTAINTERS for CA8210 driver
Date: Tue, 28 Mar 2017 13:09:00 +0100
Message-Id: <20170328120900.5328-4-h.morris@cascoda.com>
In-Reply-To: <20170328120900.5328-1-h.morris@cascoda.com>
References: <20170328120900.5328-1-h.morris@cascoda.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: aar@pengutronix.de, marcel@holtmann.org, stefan@osg.samsung.com, Harry Morris <h.morris@cascoda.com>

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

