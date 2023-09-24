Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C596CE7A8F
	for <linux-wpan@archiver.kernel.org>; Sun, 24 Sep 2023 12:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjIXMXE (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 24 Sep 2023 08:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjIXMXD (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 24 Sep 2023 08:23:03 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AED8103
        for <linux-wpan@vger.kernel.org>; Sun, 24 Sep 2023 05:22:57 -0700 (PDT)
Received: from localhost.localdomain.datenfreihafen.local (p200300e9d71918519b00d9454c2dda6a.dip0.t-ipconnect.de [IPv6:2003:e9:d719:1851:9b00:d945:4c2d:da6a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@sostec.de)
        by proxima.lasnet.de (Postfix) with ESMTPSA id B3358C0E36;
        Sun, 24 Sep 2023 14:22:48 +0200 (CEST)
From:   Stefan Schmidt <stefan@datenfreihafen.org>
To:     linux-wpan@vger.kernel.org
Cc:     alex.aring@gmail.com, miquel.raynal@bootlin.com,
        david.girault@qorvo.com, Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 2/9] license: clearly indicate license in file name and use new LICENSES folder
Date:   Sun, 24 Sep 2023 14:22:24 +0200
Message-ID: <20230924122231.716878-3-stefan@datenfreihafen.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230924122231.716878-1-stefan@datenfreihafen.org>
References: <20230924122231.716878-1-stefan@datenfreihafen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

For now you would need to identify the license by its actual license text.
We never had mentioned ISC anywhere as the license. Make this clear by
the filename (in a LICENSES folder as it is practice with reuse).

Keeping the old COPYING file around as symlink.

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
---
 COPYING          | 25 +------------------------
 LICENSES/ISC.txt | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 24 deletions(-)
 mode change 100644 => 120000 COPYING
 create mode 100644 LICENSES/ISC.txt

diff --git a/COPYING b/COPYING
deleted file mode 100644
index f579f35..0000000
--- a/COPYING
+++ /dev/null
@@ -1,24 +0,0 @@
-Copyright (c) 2014		Alexander Aring
-Copyright (c) 2015		Stefan Schmidt
-
-
-Code is based on iw tool.
-
-Original Authors:
-
-Copyright (c) 2007, 2008	Johannes Berg
-Copyright (c) 2007		Andy Lutomirski
-Copyright (c) 2007		Mike Kershaw
-Copyright (c) 2008-2009		Luis R. Rodriguez
-
-Permission to use, copy, modify, and/or distribute this software for any
-purpose with or without fee is hereby granted, provided that the above
-copyright notice and this permission notice appear in all copies.
-
-THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
-WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
-MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
-ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
-WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
-ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
-OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
diff --git a/COPYING b/COPYING
new file mode 120000
index 0000000..afdb398
--- /dev/null
+++ b/COPYING
@@ -0,0 +1 @@
+LICENSES/ISC.txt
\ No newline at end of file
diff --git a/LICENSES/ISC.txt b/LICENSES/ISC.txt
new file mode 100644
index 0000000..72b508c
--- /dev/null
+++ b/LICENSES/ISC.txt
@@ -0,0 +1,23 @@
+Copyright (c) 2014		Alexander Aring
+Copyright (c) 2015		Stefan Schmidt
+
+Code is based on iw tool.
+
+Original Authors:
+
+Copyright (c) 2007, 2008	Johannes Berg
+Copyright (c) 2007		Andy Lutomirski
+Copyright (c) 2007		Mike Kershaw
+Copyright (c) 2008-2009		Luis R. Rodriguez
+
+Permission to use, copy, modify, and/or distribute this software for any
+purpose with or without fee is hereby granted, provided that the above
+copyright notice and this permission notice appear in all copies.
+
+THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
-- 
2.41.0

