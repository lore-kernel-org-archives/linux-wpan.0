Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D705CCA47B
	for <linux-wpan@archiver.kernel.org>; Fri,  1 Jul 2022 14:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiGAOiO (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 1 Jul 2022 10:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbiGAOh5 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 1 Jul 2022 10:37:57 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2053D491
        for <linux-wpan@vger.kernel.org>; Fri,  1 Jul 2022 07:34:39 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 113FD20000F;
        Fri,  1 Jul 2022 14:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656686078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i3NuLMYQGegEDlsYXHWQTxM+kmTZB4g8rjBeozny6tE=;
        b=i2ka9kXXuZ37KT6UoKKQurjW0uS0UFroLMKHA1U6dnyyx4m0nYr6Bmx3RNdTlzL+BElNcv
        kREe6eNed4RWFg3CymrsEwt+CVVrd15ILhCokodR1fgepSQvYveoow1D7Ui95mjmtDFTJ0
        erSckKVgTzXkoKvPcrwePdSvmNua4SdXbpEk651N7K9aBBbdmLgQDjXuABb8CiFGCZ3amk
        9QnjTu8/IFL7gnXhEacac3OaBaVWGzMZwXlABCTf6V8TDG9C69P/xSJKk4RpkMZMtMsn05
        j5yzz6CJnkacgB2qeVzuwtljoOz9wpKUpnzlRsnbcxQh+GB50232VYtSS4jENQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org
Cc:     David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-tools 2/7] iwpan: Export iwpan_debug
Date:   Fri,  1 Jul 2022 16:34:29 +0200
Message-Id: <20220701143434.1267864-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220701143434.1267864-1-miquel.raynal@bootlin.com>
References: <20220701143434.1267864-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

