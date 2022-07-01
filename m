Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB582C43334
	for <linux-wpan@archiver.kernel.org>; Fri,  1 Jul 2022 14:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiGAOiV (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 1 Jul 2022 10:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbiGAOh5 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 1 Jul 2022 10:37:57 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA463D4B9
        for <linux-wpan@vger.kernel.org>; Fri,  1 Jul 2022 07:34:40 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5F54C200015;
        Fri,  1 Jul 2022 14:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656686079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7DYGlaVj+dX75xjeCSEzO2H48Gb9JrtGwznnKQcBMSY=;
        b=HpX6Fe58kbw4o9L9dDcvFrM9w5xP4PIDjVWYLOuRGoIr5zNcDJTYlvV+5/LuOrzwdatM+2
        R51NHIz1fwYJK8amHH/hPcl0b9QQyqIGJ7oxKgEndrxGVg7jHBmACRW9asXLF0ugInZ6gP
        zGkz2mJQNBPdpWQBajsp/1QbGUgd93cA5Nlc1qxzr2PcDvS3BpZp5HkF7DNcSvQ+qN4c8H
        aAAD6MAeG6+zf7S4ShWeBUpgEt7kj6DkwSZ2CC47EZKvMyyP+EAACsrSs1XRhDt4Q1DVUf
        j1/wPZx0Z3yau2D1UAFOEUoWDU4HqLPub7+00YiRLERFI4bH5SmAlZ89svmcSA==
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
Subject: [PATCH wpan-tools 3/7] iwpan: Fix a comment
Date:   Fri,  1 Jul 2022 16:34:30 +0200
Message-Id: <20220701143434.1267864-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220701143434.1267864-1-miquel.raynal@bootlin.com>
References: <20220701143434.1267864-1-miquel.raynal@bootlin.com>
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
2.34.1

