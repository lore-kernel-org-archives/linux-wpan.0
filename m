Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35038 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935213AbcJXPFV (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 24 Oct 2016 11:05:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id o81so10218928wma.2
        for <linux-wpan@vger.kernel.org>; Mon, 24 Oct 2016 08:05:21 -0700 (PDT)
From: harrymorris12@gmail.com
Subject: [PATCH 3/3] ieee802154: Add entry in MAINTAINTERS for CA8210 driver
Date: Mon, 24 Oct 2016 16:04:49 +0100
Message-Id: <20161024150449.11132-4-h.morris@cascoda.com>
In-Reply-To: <20161024150449.11132-1-h.morris@cascoda.com>
References: <20161024150449.11132-1-h.morris@cascoda.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, stefan@osg.samsung.com, Harry Morris <h.morris@cascoda.com>

From: Harry Morris <h.morris@cascoda.com>

Signed-off-by: Harry Morris <h.morris@cascoda.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 05e5450..37df5b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2130,6 +2130,15 @@ W:	http://www.linux-c6x.org/wiki/index.php/Main_Page
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
 L:	linux-cachefs@redhat.com
-- 
2.9.3.windows.1

