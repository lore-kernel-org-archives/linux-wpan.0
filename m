Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4BBC6FA99
	for <linux-wpan@archiver.kernel.org>; Fri, 10 Mar 2023 15:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbjCJPQi (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 10 Mar 2023 10:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbjCJPQN (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 10 Mar 2023 10:16:13 -0500
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [IPv6:2001:4b98:dc4:8::240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC18135519
        for <linux-wpan@vger.kernel.org>; Fri, 10 Mar 2023 07:07:16 -0800 (PST)
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 02836C1C3F
        for <linux-wpan@vger.kernel.org>; Fri, 10 Mar 2023 14:55:13 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8F9F3FF812;
        Fri, 10 Mar 2023 14:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678460032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fv3jIeKrIkDieiBEX6at/JBzPtv+kX9zrb04yvy0Ybc=;
        b=l/TbTnJPSDlj3k2v/yr0uUKZb0nN5g9o88A4Ju54GPfKqcZGja1QohLjnX2+6QeiZtZpdg
        l61Nb91bzf+wUS+jqhYbVdPsCUXb9LViOhTa7w5A6c0gctm6D5bJxGLXfxejWVwW92Hmt/
        OGq/NQn7RK826DMA/SIYD7SNSJ671+mrC9LgQuoMD46NrEah0L1g94qV+5nF8LxC9RCtY/
        NqoSVfvXxaS8wBFcxvf6uM5I/hTNhfjQMoeV7k1PWIy6ak/Ty1cgtPUZ2rgrFf+CaEZEOC
        1mK28YjNgjaP9aB6wbj16gnM2G2s3GCZZRVY23hs1Y6bagDlkGu/47RzSI7ggw==
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
Subject: [PATCH wpan-next v2 3/4] ieee802154: Add support for allowing to answer BEACON_REQ
Date:   Fri, 10 Mar 2023 15:53:45 +0100
Message-Id: <20230310145346.1397068-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310145346.1397068-1-miquel.raynal@bootlin.com>
References: <20230310145346.1397068-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Accept beaconing configurations from the user which involve answering
beacon requests rather than only passively sending beacons. This may
help devices to find the PAN more quickly.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 net/ieee802154/nl802154.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index ef0b48c9ed2f..0ecc49d9c8c9 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -233,7 +233,7 @@ static const struct nla_policy nl802154_policy[NL802154_ATTR_MAX+1] = {
 		NLA_POLICY_RANGE(NLA_U8, NL802154_SCAN_DONE_REASON_FINISHED,
 				 NL802154_SCAN_DONE_REASON_ABORTED),
 	[NL802154_ATTR_BEACON_INTERVAL] =
-		NLA_POLICY_MAX(NLA_U8, IEEE802154_MAX_SCAN_DURATION),
+		NLA_POLICY_MAX(NLA_U8, IEEE802154_ACTIVE_SCAN_DURATION),
 
 #ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
 	[NL802154_ATTR_SEC_ENABLED] = { .type = NLA_U8, },
-- 
2.34.1

