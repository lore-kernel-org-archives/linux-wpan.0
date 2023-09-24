Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4B9CE7A90
	for <linux-wpan@archiver.kernel.org>; Sun, 24 Sep 2023 12:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjIXMXG (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 24 Sep 2023 08:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjIXMXF (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 24 Sep 2023 08:23:05 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C670C115
        for <linux-wpan@vger.kernel.org>; Sun, 24 Sep 2023 05:22:58 -0700 (PDT)
Received: from localhost.localdomain.datenfreihafen.local (p200300e9d71918519b00d9454c2dda6a.dip0.t-ipconnect.de [IPv6:2003:e9:d719:1851:9b00:d945:4c2d:da6a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@sostec.de)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 0B0BAC125D;
        Sun, 24 Sep 2023 14:22:51 +0200 (CEST)
From:   Stefan Schmidt <stefan@datenfreihafen.org>
To:     linux-wpan@vger.kernel.org
Cc:     alex.aring@gmail.com, miquel.raynal@bootlin.com,
        david.girault@qorvo.com, Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 7/9] src: switch files to SPDX header for license and copyright
Date:   Sun, 24 Sep 2023 14:22:29 +0200
Message-ID: <20230924122231.716878-8-stefan@datenfreihafen.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230924122231.716878-1-stefan@datenfreihafen.org>
References: <20230924122231.716878-1-stefan@datenfreihafen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
---
 src/.gitignore  | 4 ++++
 src/Makefile.am | 4 ++++
 src/event.c     | 4 ++++
 src/info.c      | 4 ++++
 src/interface.c | 4 ++++
 src/iwpan.c     | 3 +++
 src/iwpan.h     | 4 ++++
 src/mac.c       | 4 ++++
 src/nl_extras.h | 4 ++++
 src/phy.c       | 4 ++++
 src/scan.c      | 4 ++++
 src/sections.c  | 4 ++++
 12 files changed, 47 insertions(+)

diff --git a/src/.gitignore b/src/.gitignore
index a0a601d..efe0d9e 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -1,3 +1,7 @@
+# SPDX-FileCopyrightText: 2014 Alexander Aring <alex.aring@gmail.com>
+#
+# SPDX-License-Identifier: ISC
+
 .deps
 iwpan
 *.o
diff --git a/src/Makefile.am b/src/Makefile.am
index 7933daf..23b54db 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -1,3 +1,7 @@
+# SPDX-FileCopyrightText: 2014 Alexander Aring <alex.aring@gmail.com>
+#
+# SPDX-License-Identifier: ISC
+
 bin_PROGRAMS = \
 	iwpan
 
diff --git a/src/event.c b/src/event.c
index 5ec597d..d47e778 100644
--- a/src/event.c
+++ b/src/event.c
@@ -1,3 +1,7 @@
+// SPDX-FileCopyrightText: 2023 David Girault <david.girault@qorvo.com>
+//
+// SPDX-License-Identifier: ISC
+
 #include <net/if.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/src/info.c b/src/info.c
index 8ed5e4f..8b7e98e 100644
--- a/src/info.c
+++ b/src/info.c
@@ -1,3 +1,7 @@
+// SPDX-FileCopyrightText: 2014 Alexander Aring <alex.aring@gmail.com>
+//
+// SPDX-License-Identifier: ISC
+
 #include <stdbool.h>
 #include <errno.h>
 #include <net/if.h>
diff --git a/src/interface.c b/src/interface.c
index 85d40a8..c078a25 100644
--- a/src/interface.c
+++ b/src/interface.c
@@ -1,3 +1,7 @@
+// SPDX-FileCopyrightText: 2014 Alexander Aring <alex.aring@gmail.com>
+//
+// SPDX-License-Identifier: ISC
+
 #include <net/if.h>
 #include <errno.h>
 #include <string.h>
diff --git a/src/iwpan.c b/src/iwpan.c
index 3cf5fe2..796d380 100644
--- a/src/iwpan.c
+++ b/src/iwpan.c
@@ -1,3 +1,6 @@
+// SPDX-FileCopyrightText: 2014 Alexander Aring <alex.aring@gmail.com>
+//
+// SPDX-License-Identifier: ISC
 
 #include <errno.h>
 #include <stdio.h>
diff --git a/src/iwpan.h b/src/iwpan.h
index 406940a..24cc926 100644
--- a/src/iwpan.h
+++ b/src/iwpan.h
@@ -1,3 +1,7 @@
+// SPDX-FileCopyrightText: 2014 Alexander Aring <alex.aring@gmail.com>
+//
+// SPDX-License-Identifier: ISC
+
 #ifndef __IWPAN_H
 #define __IWPAN_H
 
diff --git a/src/mac.c b/src/mac.c
index 286802c..79b3ab9 100644
--- a/src/mac.c
+++ b/src/mac.c
@@ -1,3 +1,7 @@
+// SPDX-FileCopyrightText: 2014 Alexander Aring <alex.aring@gmail.com>
+//
+// SPDX-License-Identifier: ISC
+
 #include <net/if.h>
 #include <errno.h>
 #include <string.h>
diff --git a/src/nl_extras.h b/src/nl_extras.h
index 37844f9..2a35f5d 100644
--- a/src/nl_extras.h
+++ b/src/nl_extras.h
@@ -1,3 +1,7 @@
+// SPDX-FileCopyrightText: 2014 Alexander Aring <alex.aring@gmail.com>
+//
+// SPDX-License-Identifier: ISC
+
 #ifndef __NL_EXTRAS_H
 #define __NL_EXTRAS_H
 
diff --git a/src/phy.c b/src/phy.c
index f97900f..f042588 100644
--- a/src/phy.c
+++ b/src/phy.c
@@ -1,3 +1,7 @@
+// SPDX-FileCopyrightText: 2014 Alexander Aring <alex.aring@gmail.com>
+//
+// SPDX-License-Identifier: ISC
+
 #include <net/if.h>
 #include <errno.h>
 #include <string.h>
diff --git a/src/scan.c b/src/scan.c
index e92702d..993e367 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1,3 +1,7 @@
+// SPDX-FileCopyrightText: 2023 David Girault <david.girault@qorvo.com>
+//
+// SPDX-License-Identifier: ISC
+
 #include <errno.h>
 #include <inttypes.h>
 #include <net/if.h>
diff --git a/src/sections.c b/src/sections.c
index 40fdc94..8327fea 100644
--- a/src/sections.c
+++ b/src/sections.c
@@ -1,3 +1,7 @@
+// SPDX-FileCopyrightText: 2014 Alexander Aring <alex.aring@gmail.com>
+//
+// SPDX-License-Identifier: ISC
+
 #include "iwpan.h"
 
 SECTION(get);
-- 
2.41.0

