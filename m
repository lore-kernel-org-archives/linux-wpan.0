Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDD1C433FE
	for <linux-wpan@archiver.kernel.org>; Wed, 12 Jan 2022 17:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355671AbiALRg2 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 12 Jan 2022 12:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355632AbiALRfs (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 12 Jan 2022 12:35:48 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DCEC06118C;
        Wed, 12 Jan 2022 09:35:38 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id BD0B3C0003;
        Wed, 12 Jan 2022 17:35:35 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc:     David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-wireless@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [wpan-tools v2 3/7] iwpan: Fix a comment
Date:   Wed, 12 Jan 2022 18:35:25 +0100
Message-Id: <20220112173529.765170-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220112173529.765170-1-miquel.raynal@bootlin.com>
References: <20220112173529.765170-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

There are a couple of words missing, add them to clarify the comment.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 src/iwpan.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/iwpan.h b/src/iwpan.h
index 860dd37..9d265c6 100644
--- a/src/iwpan.h
+++ b/src/iwpan.h
@@ -43,7 +43,7 @@ struct cmd {
 	const enum command_identify_by idby;
 	/* The handler should return a negative error code,
 	 * zero on success, 1 if the arguments were wrong
-	 * and the usage message should and 2 otherwise.
+	 * and the usage message should be displayed, 2 otherwise.
 	 */
 	int (*handler)(struct nl802154_state *state,
 		       struct nl_cb *cb,
-- 
2.27.0

