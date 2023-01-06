Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E9FC4708D
	for <linux-wpan@archiver.kernel.org>; Fri,  6 Jan 2023 11:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjAFLSv (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 6 Jan 2023 06:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbjAFLSs (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 6 Jan 2023 06:18:48 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FCF63188
        for <linux-wpan@vger.kernel.org>; Fri,  6 Jan 2023 03:18:45 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 95A65240013;
        Fri,  6 Jan 2023 11:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673003924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lEaI1Ym2paejQwXNvmzOV2cHFz6vGMqUYVMWC/hHsjg=;
        b=f1ARLXkhHcZliFUB9X0rSf5xEMzSHsOgzNFiqCjoMAkm64eIbeBdrNIB2n05e9uSyGuArw
        +sSCwiqPxVkR1lMhMJ8vSWqn1jGr57/ZB6BUFwchaNFR9XUSvtsw3DGe7RWwrQq0pz28hJ
        QWxtIpF/NVyICPQuAaOjxcYkYh4v3bSz9wcxc5rr398derPs+9Y37uEhXXoO6KMiTyd/sy
        +Q48GRkiWgVdxzZZZWU79LmXR4pNfLasWQE05rr2rRjJ/i7Wu678T7y0xhoSRYzFMH1kRU
        7NwUK0OkPMhq6208yeb/xDXeBkZLc6g9qyaBkoaGXKVmMlcdkvZ+j/9HbpWOeA==
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
Subject: [PATCH wpan-tools v2 5/8] iwpan: Remove duplicated SECTION
Date:   Fri,  6 Jan 2023 12:18:28 +0100
Message-Id: <20230106111831.692202-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230106111831.692202-1-miquel.raynal@bootlin.com>
References: <20230106111831.692202-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

From: David Girault <david.girault@qorvo.com>

This section has been duplicated, drop one.

Signed-off-by: David Girault <david.girault@qorvo.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 src/iwpan.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/src/iwpan.h b/src/iwpan.h
index 9d265c6..406940a 100644
--- a/src/iwpan.h
+++ b/src/iwpan.h
@@ -90,12 +90,6 @@ struct cmd {
 		.handler = (_handler),					\
 		.help = (_help),					\
 	 }
-#define SECTION(_name)							\
-	struct cmd __section ## _ ## _name				\
-	__attribute__((used)) __attribute__((section("__cmd"))) = {	\
-		.name = (#_name),					\
-		.hidden = 1,						\
-	}
 
 #define SECTION(_name)							\
 	struct cmd __section ## _ ## _name				\
-- 
2.34.1

