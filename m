Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0EEC54EBC
	for <linux-wpan@archiver.kernel.org>; Fri,  6 Jan 2023 11:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjAFLSw (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 6 Jan 2023 06:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjAFLSs (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 6 Jan 2023 06:18:48 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D641C625F5
        for <linux-wpan@vger.kernel.org>; Fri,  6 Jan 2023 03:18:41 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EC4F024000A;
        Fri,  6 Jan 2023 11:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673003920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i3NuLMYQGegEDlsYXHWQTxM+kmTZB4g8rjBeozny6tE=;
        b=OJaEMt/kVgehjuKxONUiPNGkJLG6jjjmajBnycqWMcA2c60WKJV1q7HOajYvOCdGC8pUtK
        KWpW8bz2lQA/Fb/56L72WYkQ7seNRkqMO4Q8Hw2XWjMWhBCGazvklapc1fs0wlIAUvhbSQ
        1F/gD7ZLd35rZw0+vRL2hOrrnDPAuiYBzFVw8qTTa1L0WThQ2QCtLk9QI3VGxjwvRGAiqq
        eBK0GC0Vfxyiq7XURpshccRYaH0I200siQXqg+Hhmx3VtYCArRHHufIFoZTPi+PxxQJCqb
        OmjQtuqc570GAk9axthhtt1vw8Y4lwOJXmWd+clu1fhPC8hYYW0xqtR6FbjT9A==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org
Cc:     David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-tools v2 3/8] iwpan: Export iwpan_debug
Date:   Fri,  6 Jan 2023 12:18:26 +0100
Message-Id: <20230106111831.692202-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230106111831.692202-1-miquel.raynal@bootlin.com>
References: <20230106111831.692202-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

From: David Girault <david.girault@qorvo.com>

This debug flag will be used later on in different files.

Signed-off-by: David Girault <david.girault@qorvo.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 src/iwpan.c | 2 +-
 src/iwpan.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/iwpan.c b/src/iwpan.c
index fb7bef1..3cf5fe2 100644
--- a/src/iwpan.c
+++ b/src/iwpan.c
@@ -21,7 +21,7 @@
 
 /* TODO libnl 1.x compatibility code */
 
-static int iwpan_debug = 0;
+int iwpan_debug = 0;
 
 static int nl802154_init(struct nl802154_state *state)
 {
diff --git a/src/iwpan.h b/src/iwpan.h
index 48c4f03..860dd37 100644
--- a/src/iwpan.h
+++ b/src/iwpan.h
@@ -120,4 +120,6 @@ DECLARE_SECTION(get);
 
 const char *iftype_name(enum nl802154_iftype iftype);
 
+extern int iwpan_debug;
+
 #endif /* __IWPAN_H */
-- 
2.34.1

