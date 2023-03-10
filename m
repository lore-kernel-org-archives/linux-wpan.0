Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79C8C6FA99
	for <linux-wpan@archiver.kernel.org>; Fri, 10 Mar 2023 15:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbjCJPQb (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 10 Mar 2023 10:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbjCJPQJ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 10 Mar 2023 10:16:09 -0500
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [IPv6:2001:4b98:dc4:8::240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B873134AFA
        for <linux-wpan@vger.kernel.org>; Fri, 10 Mar 2023 07:07:10 -0800 (PST)
Received: from relay9-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::229])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 58BA7CAE96
        for <linux-wpan@vger.kernel.org>; Fri, 10 Mar 2023 14:55:17 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 07D92FF802;
        Fri, 10 Mar 2023 14:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678460030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BzQf+RG5g4UxThfZ/YQmrnm+OtbLNbm8VCPv+pV0M4I=;
        b=gE1JZ7IsIi/SndGWwPh1OyrN2kxadTfkeJWrmTCwErGr6PxrXHj+gr9HMl0pbxt4nCCNR5
        SCPT9Ag9URy88o/tnbmEJEM+oP4MQNa4cT8irghuWgojn+fNJN0TmAdM6MFiTcIwrC/UQl
        RSPg28qbxbGh+8GOlEQ+60AbonUddHQSa3HHxjdE7ip+ybYTVNtnfUQBDQYr3nX7Cjfpr9
        tfK/uiF71sAVReUCra9p2p4Bv2J8QpNcnU8j5pVlgzWlnDcdYDfqQ/LAzPv6OuEeaEEmmf
        TCHgLQxwxa9BFAzYHJd95fx73X9/us2O+0HQBETzY5qU1eUrYv/TMlpS2B0rwg==
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
Subject: [PATCH wpan-next v2 1/4] ieee802154: Add support for user active scan requests
Date:   Fri, 10 Mar 2023 15:53:43 +0100
Message-Id: <20230310145346.1397068-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310145346.1397068-1-miquel.raynal@bootlin.com>
References: <20230310145346.1397068-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

In case a passive scan could not discover any PAN, a device may decide
to perform an active scan to force coordinators to send a BEACON
"immediately". Allow users to request to perform an active scan.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 net/ieee802154/nl802154.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index a18fb98a4b09..ef0b48c9ed2f 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -1426,6 +1426,7 @@ static int nl802154_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 
 	type = nla_get_u8(info->attrs[NL802154_ATTR_SCAN_TYPE]);
 	switch (type) {
+	case NL802154_SCAN_ACTIVE:
 	case NL802154_SCAN_PASSIVE:
 		request->type = type;
 		break;
-- 
2.34.1

