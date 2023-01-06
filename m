Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE6BC3DA7A
	for <linux-wpan@archiver.kernel.org>; Fri,  6 Jan 2023 11:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjAFLSq (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 6 Jan 2023 06:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjAFLSm (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 6 Jan 2023 06:18:42 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C405625F5
        for <linux-wpan@vger.kernel.org>; Fri,  6 Jan 2023 03:18:40 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 989DC240005;
        Fri,  6 Jan 2023 11:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673003918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SC+efU5PqAwVLFuiqQsRReY/dRs97fikxOlstcwAtdM=;
        b=Uy8IuXigPpLxV9AENRcog6XHdXK+2kbiGfw94jaUy4fcCapXJ5CHsXtvu8dITujZ1YYs/R
        c23MEFLlSb8y9jD6krdSoRhbyzJgffkIeMBb+jjuK0YMi6Gxfm8HkwnI9Ab45UHxPDViXW
        Sa0qaeVJap6zG/aHqFhbluT1/Pp1sD4YzTzds5sXvE/u+M4tLpPUEAl9Gp3LefnX51enXD
        vgYW2fV9ed3BrVDtdrjMa9Ai9QXGFRNYSC025mVCbpcx0eapZORyD5tRy0nNybmkkFtbnh
        EppC0D/mCNyFPkpCgMG4Wou94axPMoWyzUsjkp7WVAZLVqFIehGt7d6Hd+i9Uw==
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
        Romuald Despres <Romuald.Despres@qorvo.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-tools v2 2/8] iwpan: Fix the channels printing
Date:   Fri,  6 Jan 2023 12:18:25 +0100
Message-Id: <20230106111831.692202-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230106111831.692202-1-miquel.raynal@bootlin.com>
References: <20230106111831.692202-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

From: Romuald Despres <Romuald.Despres@qorvo.com>

The presence of a channel capability is checked against the tb_msg
netlink attributes array which is the root one, while here we are
looking for channel capabilities, themselves being nested and parsed
into tb_caps. Use tb_caps instead of tb_msg here otherwise we are
accessing a random index in the upper attributes list.

Signed-off-by: Romuald Despres <Romuald.Despres@qorvo.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 src/info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/info.c b/src/info.c
index f85690c..8ed5e4f 100644
--- a/src/info.c
+++ b/src/info.c
@@ -342,7 +342,7 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 			printf("\b \n");
 		}
 
-		if (tb_msg[NL802154_CAP_ATTR_CHANNELS]) {
+		if (tb_caps[NL802154_CAP_ATTR_CHANNELS]) {
 			int counter = 0;
 			int rem_pages;
 			struct nlattr *nl_pages;
-- 
2.34.1

