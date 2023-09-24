Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F0CCE7A8A
	for <linux-wpan@archiver.kernel.org>; Sun, 24 Sep 2023 12:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjIXMXD (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 24 Sep 2023 08:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjIXMXD (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 24 Sep 2023 08:23:03 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3302111F
        for <linux-wpan@vger.kernel.org>; Sun, 24 Sep 2023 05:22:54 -0700 (PDT)
Received: from localhost.localdomain.datenfreihafen.local (p200300e9d71918519b00d9454c2dda6a.dip0.t-ipconnect.de [IPv6:2003:e9:d719:1851:9b00:d945:4c2d:da6a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@sostec.de)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 320D2C0D81;
        Sun, 24 Sep 2023 14:22:48 +0200 (CEST)
From:   Stefan Schmidt <stefan@datenfreihafen.org>
To:     linux-wpan@vger.kernel.org
Cc:     alex.aring@gmail.com, miquel.raynal@bootlin.com,
        david.girault@qorvo.com, Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 1/9] m4: remove empty folder which only holds a .gitignore file
Date:   Sun, 24 Sep 2023 14:22:23 +0200
Message-ID: <20230924122231.716878-2-stefan@datenfreihafen.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230924122231.716878-1-stefan@datenfreihafen.org>
References: <20230924122231.716878-1-stefan@datenfreihafen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

we have no project specific files in the m4 folder, it just gets
generated from autotools. Ignore the complete folder in the top
level .gitignore instead.

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
---
 .gitignore    | 1 +
 m4/.gitignore | 5 -----
 2 files changed, 1 insertion(+), 5 deletions(-)
 delete mode 100644 m4/.gitignore

diff --git a/.gitignore b/.gitignore
index ef71c6a..cad8dee 100644
--- a/.gitignore
+++ b/.gitignore
@@ -10,3 +10,4 @@ config.*
 configure
 libtool
 stamp-h1
+m4/
diff --git a/m4/.gitignore b/m4/.gitignore
deleted file mode 100644
index 38066dd..0000000
--- a/m4/.gitignore
+++ /dev/null
@@ -1,5 +0,0 @@
-libtool.m4
-ltoptions.m4
-ltsugar.m4
-ltversion.m4
-lt~obsolete.m4
-- 
2.41.0

