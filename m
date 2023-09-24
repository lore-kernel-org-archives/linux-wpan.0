Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FC5CE7A8B
	for <linux-wpan@archiver.kernel.org>; Sun, 24 Sep 2023 12:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjIXMXF (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 24 Sep 2023 08:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIXMXE (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 24 Sep 2023 08:23:04 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEFE10D
        for <linux-wpan@vger.kernel.org>; Sun, 24 Sep 2023 05:22:58 -0700 (PDT)
Received: from localhost.localdomain.datenfreihafen.local (p200300e9d71918519b00d9454c2dda6a.dip0.t-ipconnect.de [IPv6:2003:e9:d719:1851:9b00:d945:4c2d:da6a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@sostec.de)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 3F400C107B;
        Sun, 24 Sep 2023 14:22:50 +0200 (CEST)
From:   Stefan Schmidt <stefan@datenfreihafen.org>
To:     linux-wpan@vger.kernel.org
Cc:     alex.aring@gmail.com, miquel.raynal@bootlin.com,
        david.girault@qorvo.com, Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 5/9] src/nl802154.h: switch file to SPDX header for license and copyright
Date:   Sun, 24 Sep 2023 14:22:27 +0200
Message-ID: <20230924122231.716878-6-stefan@datenfreihafen.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230924122231.716878-1-stefan@datenfreihafen.org>
References: <20230924122231.716878-1-stefan@datenfreihafen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

This file has its own commit as we are syncing it between the Linux
kernel and this project when new netlink functionality is added.

The same change needs to be done on the iLinux kernel side as well to
avoid conflicts.

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
---
 src/nl802154.h | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/src/nl802154.h b/src/nl802154.h
index dbad1c9..410ee95 100644
--- a/src/nl802154.h
+++ b/src/nl802154.h
@@ -1,23 +1,11 @@
 #ifndef __NL802154_H
 #define __NL802154_H
-/*
- * 802.15.4 netlink interface public header
- *
- * Copyright 2014 Alexander Aring <aar@pengutronix.de>
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
- *
- */
+
+// SPDX-FileCopyrightText: 2014 Alexander Aring <aar@pengutronix.de>
+//
+// SPDX-License-Identifier: ISC
+
+/* 802.15.4 netlink interface public header */
 
 #define NL802154_GENL_NAME "nl802154"
 
-- 
2.41.0

