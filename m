Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5C8C5479D
	for <linux-wpan@archiver.kernel.org>; Fri,  6 Jan 2023 11:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjAFLSq (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 6 Jan 2023 06:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjAFLSl (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 6 Jan 2023 06:18:41 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9D7625DF
        for <linux-wpan@vger.kernel.org>; Fri,  6 Jan 2023 03:18:38 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D3724240014;
        Fri,  6 Jan 2023 11:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673003917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/2VGcVxYVS1JEm5/Fm6gwZL3KFWld/QNwfbHBHWWzzo=;
        b=Kl0ii14kt1IbPJrL3Vl3xYSm8mgDRPvLWbMsqY4PpVwU6GmroGAuidQythqzMCTPlkAZqB
        ePuqdtf6NxES33x9dBOCxxKtrUhQtoDDJRum9E0HdwPne7KeZCLJTA6nAqfJcm/mMKFxTl
        iVViDpdqXoumVmuUqPy+EphKik6O1qSnVfOu3K0wrzKCvUHmoNwH3FdflcDUT77uq5Ixpk
        sTdJfKjglboeRn+jsRFVO0HdfE+nCLay+w8jBgUPTPPVR+/WJNNI/USNmbu/4z1ZUqvSiK
        n6bY2eJnkuLz1SnAY+8VJL3rNCabqm7bfgMy9ZWJ6Oy+8IBGzb3jVDc6ad/xHg==
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
Subject: [PATCH wpan-tools v2 1/8] iwpan: Synchronize nl802154.h with the latest kernel
Date:   Fri,  6 Jan 2023 12:18:24 +0100
Message-Id: <20230106111831.692202-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230106111831.692202-1-miquel.raynal@bootlin.com>
References: <20230106111831.692202-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

The low-level security commands are now listed inconditionnally, so
let's reflect this change in the header so that the addition of further
commands is made at the right location.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 src/nl802154.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/nl802154.h b/src/nl802154.h
index ddcee12..eb8ad48 100644
--- a/src/nl802154.h
+++ b/src/nl802154.h
@@ -56,9 +56,6 @@ enum nl802154_commands {
 
 	NL802154_CMD_SET_WPAN_PHY_NETNS,
 
-	/* add new commands above here */
-
-#ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
 	NL802154_CMD_SET_SEC_PARAMS,
 	NL802154_CMD_GET_SEC_KEY,		/* can dump */
 	NL802154_CMD_NEW_SEC_KEY,
@@ -72,7 +69,8 @@ enum nl802154_commands {
 	NL802154_CMD_GET_SEC_LEVEL,		/* can dump */
 	NL802154_CMD_NEW_SEC_LEVEL,
 	NL802154_CMD_DEL_SEC_LEVEL,
-#endif /* CONFIG_IEEE802154_NL802154_EXPERIMENTAL */
+
+	/* add new commands above here */
 
 	/* used to define NL802154_CMD_MAX below */
 	__NL802154_CMD_AFTER_LAST,
-- 
2.34.1

