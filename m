Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AAECE7A91
	for <linux-wpan@archiver.kernel.org>; Sun, 24 Sep 2023 12:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjIXMXG (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 24 Sep 2023 08:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjIXMXG (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 24 Sep 2023 08:23:06 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65D4112
        for <linux-wpan@vger.kernel.org>; Sun, 24 Sep 2023 05:22:58 -0700 (PDT)
Received: from localhost.localdomain.datenfreihafen.local (p200300e9d71918519b00d9454c2dda6a.dip0.t-ipconnect.de [IPv6:2003:e9:d719:1851:9b00:d945:4c2d:da6a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@sostec.de)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 643EEC127E;
        Sun, 24 Sep 2023 14:22:51 +0200 (CEST)
From:   Stefan Schmidt <stefan@datenfreihafen.org>
To:     linux-wpan@vger.kernel.org
Cc:     alex.aring@gmail.com, miquel.raynal@bootlin.com,
        david.girault@qorvo.com, Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 8/9] misc: switch remaining files to SPDX header for license and copyright
Date:   Sun, 24 Sep 2023 14:22:30 +0200
Message-ID: <20230924122231.716878-9-stefan@datenfreihafen.org>
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
 .github/workflows/main.yml | 4 ++++
 .gitignore                 | 4 ++++
 Makefile.am                | 4 ++++
 autogen.sh                 | 4 ++++
 configure.ac               | 4 ++++
 5 files changed, 20 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index c7b878f..cde0f19 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -1,3 +1,7 @@
+# SPDX-FileCopyrightText: 2023 Stefan Schmidt <stefan@datenfreihafen.org>
+#
+# SPDX-License-Identifier: ISC
+
 name: Basic compile test for wpan-tools
 on: push
 
diff --git a/.gitignore b/.gitignore
index cad8dee..1d2621b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,7 @@
+# SPDX-FileCopyrightText: 2014 Alexander Aring <alex.aring@gmail.com>
+#
+# SPDX-License-Identifier: ISC
+
 *.o
 tags
 TAGS
diff --git a/Makefile.am b/Makefile.am
index 3f15825..50893e7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1,3 +1,7 @@
+# SPDX-FileCopyrightText: 2014 Alexander Aring <alex.aring@gmail.com>
+#
+# SPDX-License-Identifier: ISC
+
 EXTRA_DIST =
 CLEANFILES =
 ACLOCAL_AMFLAGS = -I m4 ${ACLOCAL_FLAGS}
diff --git a/autogen.sh b/autogen.sh
index 0d60b0a..db24799 100755
--- a/autogen.sh
+++ b/autogen.sh
@@ -1,5 +1,9 @@
 #!/bin/sh -e
 
+# SPDX-FileCopyrightText: 2014 Alexander Aring <alex.aring@gmail.com>
+#
+# SPDX-License-Identifier: ISC
+
 if [ -f .git/hooks/pre-commit.sample -a ! -f .git/hooks/pre-commit ] ; then
         cp -p .git/hooks/pre-commit.sample .git/hooks/pre-commit && \
         chmod +x .git/hooks/pre-commit && \
diff --git a/configure.ac b/configure.ac
index f7bd7f7..fee4b44 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,3 +1,7 @@
+dnl SPDX-FileCopyrightText: 2014 Alexander Aring <alex.aring@gmail.com>
+dnl
+dnl SPDX-License-Identifier: ISC
+
 AC_PREREQ(2.60)
 AC_INIT([Userspace tools for Linux IEEE 802.15.4 stack],
 	[0.9], [linux-wpan@vger.kernel.org], [wpan-tools],
-- 
2.41.0

