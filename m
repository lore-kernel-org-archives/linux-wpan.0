Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08036C43334
	for <linux-wpan@archiver.kernel.org>; Fri,  1 Jul 2022 14:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbiGAOiN (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 1 Jul 2022 10:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiGAOh5 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 1 Jul 2022 10:37:57 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379053BF92
        for <linux-wpan@vger.kernel.org>; Fri,  1 Jul 2022 07:34:38 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D1F2D200006;
        Fri,  1 Jul 2022 14:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656686076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SC+efU5PqAwVLFuiqQsRReY/dRs97fikxOlstcwAtdM=;
        b=O4mj72JtqKPBVh1LuESHZX/trUxAu9Rr1HsTh4aYYh0LMOXPhLYRoF8RyPl7NHjML/rg4D
        7gon1xOHUktLzDQCi9PbSOcpf0lB3wAav1O1Y3lEWyQywHpmHUjFAl0TdZgZXM0cBNSNaK
        jO+TNY8HKAmrKfTFeZYk0mTeLQec+gzu+LWrY8asRZMR/sFBzpcptkuvEWnkqmuNlzdfJU
        Yxqe1OkvClkVDQTikM5s5Hn7mH7nGvvAQcwzdKhWeL6eNmQDw0lxPVwDr4Nqeu6osgBxR8
        3mXc6KERk2/zjM+iv3MLdoJRY4NyfsFWBm6AUvJgFYV5PD82wznLSM2rGXVcxg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org
Cc:     David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Romuald Despres <Romuald.Despres@qorvo.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-tools 1/7] iwpan: Fix the channels printing
Date:   Fri,  1 Jul 2022 16:34:28 +0200
Message-Id: <20220701143434.1267864-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220701143434.1267864-1-miquel.raynal@bootlin.com>
References: <20220701143434.1267864-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

