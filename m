Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34958 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751694AbdBFRJi (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Feb 2017 12:09:38 -0500
Received: by mail-wm0-f66.google.com with SMTP id u63so23067687wmu.2
        for <linux-wpan@vger.kernel.org>; Mon, 06 Feb 2017 09:09:37 -0800 (PST)
From: Harry Morris <harrymorris12@gmail.com>
Subject: [PATCH v8 3/3] ieee802154: Add entry in MAINTAINTERS for CA8210 driver
Date: Mon,  6 Feb 2017 17:08:57 +0000
Message-Id: <20170206170857.5064-4-h.morris@cascoda.com>
In-Reply-To: <20170206170857.5064-1-h.morris@cascoda.com>
References: <20170206170857.5064-1-h.morris@cascoda.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: aar@pengutronix.de, stefan@osg.samsung.com, marcel@holtmann.org, Harry Morris <h.morris@cascoda.com>

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

