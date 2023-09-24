Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF50CE7A88
	for <linux-wpan@archiver.kernel.org>; Sun, 24 Sep 2023 12:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjIXMXI (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 24 Sep 2023 08:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjIXMXH (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 24 Sep 2023 08:23:07 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657A1101
        for <linux-wpan@vger.kernel.org>; Sun, 24 Sep 2023 05:23:01 -0700 (PDT)
Received: from localhost.localdomain.datenfreihafen.local (p200300e9d71918519b00d9454c2dda6a.dip0.t-ipconnect.de [IPv6:2003:e9:d719:1851:9b00:d945:4c2d:da6a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@sostec.de)
        by proxima.lasnet.de (Postfix) with ESMTPSA id A5E38C1289;
        Sun, 24 Sep 2023 14:22:51 +0200 (CEST)
From:   Stefan Schmidt <stefan@datenfreihafen.org>
To:     linux-wpan@vger.kernel.org
Cc:     alex.aring@gmail.com, miquel.raynal@bootlin.com,
        david.girault@qorvo.com, Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 9/9] workflow: add reuse job to check for REUSE compliance
Date:   Sun, 24 Sep 2023 14:22:31 +0200
Message-ID: <20230924122231.716878-10-stefan@datenfreihafen.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230924122231.716878-1-stefan@datenfreihafen.org>
References: <20230924122231.716878-1-stefan@datenfreihafen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

The linter ensures we can catch problems early on and keeps the codebase
reuse compliant. A big step for ard for all downstream users who care
about license compliance and SBOM generation.

As extra step we generate a SBOM file as artifact.

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
---
 .github/workflows/reuse.yml | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 .github/workflows/reuse.yml

diff --git a/.github/workflows/reuse.yml b/.github/workflows/reuse.yml
new file mode 100644
index 0000000..194a7d7
--- /dev/null
+++ b/.github/workflows/reuse.yml
@@ -0,0 +1,19 @@
+# SPDX-FileCopyrightText: 2023 Stefan Schmidt <stefan@datenfreihafen.org>
+#
+# SPDX-License-Identifier: ISC
+
+name: Check for REUSE compliance of wpan-tools
+on: push
+
+jobs:
+  reuse:
+    runs-on: ubuntu-latest
+    steps:
+    - name: Check out repository
+      uses: actions/checkout@v4
+    - name: Install reuse tool
+      run: pip3 install reuse
+    - name: Run reuse lint
+      run: reuse lint
+    - name: Create SBOM
+      run: reuse spdx > sbom.txt
-- 
2.41.0

