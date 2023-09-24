Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CFACE7A8D
	for <linux-wpan@archiver.kernel.org>; Sun, 24 Sep 2023 12:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjIXMXE (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 24 Sep 2023 08:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjIXMXD (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 24 Sep 2023 08:23:03 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B345109
        for <linux-wpan@vger.kernel.org>; Sun, 24 Sep 2023 05:22:57 -0700 (PDT)
Received: from localhost.localdomain.datenfreihafen.local (p200300e9d71918519b00d9454c2dda6a.dip0.t-ipconnect.de [IPv6:2003:e9:d719:1851:9b00:d945:4c2d:da6a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@sostec.de)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 46183C0EB6;
        Sun, 24 Sep 2023 14:22:49 +0200 (CEST)
From:   Stefan Schmidt <stefan@datenfreihafen.org>
To:     linux-wpan@vger.kernel.org
Cc:     alex.aring@gmail.com, miquel.raynal@bootlin.com,
        david.girault@qorvo.com, Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 4/9] wpan-hwsim: switch files to SPDX header for license and copyright
Date:   Sun, 24 Sep 2023 14:22:26 +0200
Message-ID: <20230924122231.716878-5-stefan@datenfreihafen.org>
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
 wpan-hwsim/Makefile.am       |  4 ++++
 wpan-hwsim/mac802154_hwsim.h |  4 ++++
 wpan-hwsim/wpan-hwsim.c      | 22 +++++-----------------
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/wpan-hwsim/Makefile.am b/wpan-hwsim/Makefile.am
index 0587178..e7ff242 100644
--- a/wpan-hwsim/Makefile.am
+++ b/wpan-hwsim/Makefile.am
@@ -1,3 +1,7 @@
+# SPDX-FileCopyrightText: 2018 Alexander Aring <aring@mojatatu.com>
+#
+# SPDX-License-Identifier: ISC
+
 bin_PROGRAMS = wpan-hwsim
 
 wpan_hwsim_SOURCES = wpan-hwsim.c \
diff --git a/wpan-hwsim/mac802154_hwsim.h b/wpan-hwsim/mac802154_hwsim.h
index 6c6e30e..62e6962 100644
--- a/wpan-hwsim/mac802154_hwsim.h
+++ b/wpan-hwsim/mac802154_hwsim.h
@@ -1,3 +1,7 @@
+// SPDX-FileCopyrightText: 2018 Alexander Aring <aring@mojatatu.com>
+//
+// SPDX-License-Identifier: ISC
+
 #ifndef __MAC802154_HWSIM_H
 #define __MAC802154_HWSIM_H
 
diff --git a/wpan-hwsim/wpan-hwsim.c b/wpan-hwsim/wpan-hwsim.c
index 0a7c492..e1f2fe5 100644
--- a/wpan-hwsim/wpan-hwsim.c
+++ b/wpan-hwsim/wpan-hwsim.c
@@ -1,20 +1,8 @@
-/*
- * Linux IEEE 802.15.4 hwsim tool
- *
- * Copyright (C) 2018 Alexander Aring <aring@mojatatu.com>
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
- */
+// SPDX-FileCopyrightText: 2018 Alexander Aring <aring@mojatatu.com>
+//
+// SPDX-License-Identifier: ISC
+
+/* Linux IEEE 802.15.4 hwsim tool */
 
 #include <inttypes.h>
 #include <stdbool.h>
-- 
2.41.0

