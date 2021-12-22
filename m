Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0CEC433F5
	for <linux-wpan@archiver.kernel.org>; Wed, 22 Dec 2021 15:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343962AbhLVP6z (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 22 Dec 2021 10:58:55 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:38423 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343914AbhLVP6X (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 22 Dec 2021 10:58:23 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 1E2CAE0003;
        Wed, 22 Dec 2021 15:58:21 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org
Cc:     David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [wpan-tools 3/7] iwpan: Fix a comment
Date:   Wed, 22 Dec 2021 16:58:12 +0100
Message-Id: <20211222155816.256405-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211222155816.256405-1-miquel.raynal@bootlin.com>
References: <20211222155816.256405-1-miquel.raynal@bootlin.com>
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

