Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F35CE7A8A
	for <linux-wpan@archiver.kernel.org>; Sun, 24 Sep 2023 12:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjIXMXH (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 24 Sep 2023 08:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIXMXG (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 24 Sep 2023 08:23:06 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C637110B
        for <linux-wpan@vger.kernel.org>; Sun, 24 Sep 2023 05:22:59 -0700 (PDT)
Received: from localhost.localdomain.datenfreihafen.local (p200300e9d71918519b00d9454c2dda6a.dip0.t-ipconnect.de [IPv6:2003:e9:d719:1851:9b00:d945:4c2d:da6a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@sostec.de)
        by proxima.lasnet.de (Postfix) with ESMTPSA id ABF35C1121;
        Sun, 24 Sep 2023 14:22:50 +0200 (CEST)
From:   Stefan Schmidt <stefan@datenfreihafen.org>
To:     linux-wpan@vger.kernel.org
Cc:     alex.aring@gmail.com, miquel.raynal@bootlin.com,
        david.girault@qorvo.com, Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 6/9] examples: switch files to SPDX header for license and copyright
Date:   Sun, 24 Sep 2023 14:22:28 +0200
Message-ID: <20230924122231.716878-7-stefan@datenfreihafen.org>
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
 examples/.gitignore         |  4 ++++
 examples/Makefile.am        |  4 ++++
 examples/README.examples    |  4 ++++
 examples/af_ieee802154_rx.c | 23 ++++-------------------
 examples/af_ieee802154_tx.c | 23 ++++-------------------
 examples/af_inet6_rx.c      | 23 ++++-------------------
 examples/af_inet6_tx.c      | 23 ++++-------------------
 examples/af_packet_rx.c     | 23 ++++-------------------
 examples/af_packet_tx.c     | 23 ++++-------------------
 9 files changed, 36 insertions(+), 114 deletions(-)

diff --git a/examples/.gitignore b/examples/.gitignore
index 845e803..3dad378 100644
--- a/examples/.gitignore
+++ b/examples/.gitignore
@@ -1,3 +1,7 @@
+# SPDX-FileCopyrightText: 2016 Samsung Electronics Co., Ltd.
+#
+# SPDX-License-Identifier: ISC
+
 /.deps
 /af_ieee802154_rx
 /af_ieee802154_tx
diff --git a/examples/Makefile.am b/examples/Makefile.am
index b475c1f..00bd991 100644
--- a/examples/Makefile.am
+++ b/examples/Makefile.am
@@ -1,3 +1,7 @@
+# SPDX-FileCopyrightText: 2016 Samsung Electronics Co., Ltd.
+#
+# SPDX-License-Identifier: ISC
+
 noinst_PROGRAMS = af_ieee802154_tx \
 	          af_ieee802154_rx \
 	          af_packet_tx \
diff --git a/examples/README.examples b/examples/README.examples
index 11e9424..bf69c90 100644
--- a/examples/README.examples
+++ b/examples/README.examples
@@ -1,3 +1,7 @@
+// SPDX-FileCopyrightText: 2016 Samsung Electronics Co., Ltd.
+//
+// SPDX-License-Identifier: ISC
+
 This folder contains various examples on how the Linux-wpan stack can be used
 from userspace, using the Linux socket interface.
 
diff --git a/examples/af_ieee802154_rx.c b/examples/af_ieee802154_rx.c
index 86ba707..4bfd7b6 100644
--- a/examples/af_ieee802154_rx.c
+++ b/examples/af_ieee802154_rx.c
@@ -1,23 +1,8 @@
-/*
- * IEEE 802.15.4 socket example
- *
- * Copyright (C) 2016 Samsung Electronics Co., Ltd.
- *
- * Author: Stefan Schmidt <stefan@osg.samsung.com>
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
+// SPDX-FileCopyrightText: 2016 Samsung Electronics Co., Ltd.
+//
+// SPDX-License-Identifier: ISC
 
+/* IEEE 802.15.4 socket example */
 /* gcc af_ieee802154_rx.c -o af_ieee802154_rx */
 
 #include <sys/types.h>
diff --git a/examples/af_ieee802154_tx.c b/examples/af_ieee802154_tx.c
index faad17e..7cbc8a1 100644
--- a/examples/af_ieee802154_tx.c
+++ b/examples/af_ieee802154_tx.c
@@ -1,23 +1,8 @@
-/*
- * IEEE 802.15.4 socket example
- *
- * Copyright (C) 2016 Samsung Electronics Co., Ltd.
- *
- * Author: Stefan Schmidt <stefan@osg.samsung.com>
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
+// SPDX-FileCopyrightText: 2016 Samsung Electronics Co., Ltd.
+//
+// SPDX-License-Identifier: ISC
 
+/* IEEE 802.15.4 socket example */
 /* gcc af_ieee802154_tx.c -o af_ieee802154_tx */
 
 #include <sys/types.h>
diff --git a/examples/af_inet6_rx.c b/examples/af_inet6_rx.c
index d512471..525e68d 100644
--- a/examples/af_inet6_rx.c
+++ b/examples/af_inet6_rx.c
@@ -1,23 +1,8 @@
-/*
- * IEEE 802.15.4 socket example
- *
- * Copyright (C) 2016 Samsung Electronics Co., Ltd.
- *
- * Author: Stefan Schmidt <stefan@osg.samsung.com>
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
+// SPDX-FileCopyrightText: 2016 Samsung Electronics Co., Ltd.
+//
+// SPDX-License-Identifier: ISC
 
+/* IEEE 802.15.4 socket example */
 /* gcc af_inet6_rx.c -o af_inet6_rx */
 
 #include <sys/types.h>
diff --git a/examples/af_inet6_tx.c b/examples/af_inet6_tx.c
index a62f730..ece640f 100644
--- a/examples/af_inet6_tx.c
+++ b/examples/af_inet6_tx.c
@@ -1,23 +1,8 @@
-/*
- * AF_INET6 over IEEE 802.15.4 socket example
- *
- * Copyright (C) 2016 Samsung Electronics Co., Ltd.
- *
- * Author: Stefan Schmidt <stefan@osg.samsung.com>
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
+// SPDX-FileCopyrightText: 2016 Samsung Electronics Co., Ltd.
+//
+// SPDX-License-Identifier: ISC
 
+/* IEEE 802.15.4 socket example */
 /* gcc af_inet6_tx.c -o af_inet6_tx */
 
 #include <sys/types.h>
diff --git a/examples/af_packet_rx.c b/examples/af_packet_rx.c
index 9770965..8757589 100644
--- a/examples/af_packet_rx.c
+++ b/examples/af_packet_rx.c
@@ -1,23 +1,8 @@
-/*
- * IEEE 802.15.4 socket example
- *
- * Copyright (C) 2016 Samsung Electronics Co., Ltd.
- *
- * Author: Stefan Schmidt <stefan@osg.samsung.com>
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
+// SPDX-FileCopyrightText: 2016 Samsung Electronics Co., Ltd.
+//
+// SPDX-License-Identifier: ISC
 
+/* IEEE 802.15.4 socket example */
 /* gcc af_packet_rx.c -o af_packet_rx */
 
 #include <sys/types.h>
diff --git a/examples/af_packet_tx.c b/examples/af_packet_tx.c
index 82a15f4..e247eaf 100644
--- a/examples/af_packet_tx.c
+++ b/examples/af_packet_tx.c
@@ -1,23 +1,8 @@
-/*
- * IEEE 802.15.4 socket example
- *
- * Copyright (C) 2016 Samsung Electronics Co., Ltd.
- *
- * Author: Stefan Schmidt <stefan@osg.samsung.com>
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
+// SPDX-FileCopyrightText: 2016 Samsung Electronics Co., Ltd.
+//
+// SPDX-License-Identifier: ISC
 
+/* IEEE 802.15.4 socket example */
 /* gcc af_packet_tx.c -o af_packet_tx */
 
 #include <sys/types.h>
-- 
2.41.0

