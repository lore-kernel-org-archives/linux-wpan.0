Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5420EE82CB0
	for <linux-wpan@archiver.kernel.org>; Wed, 27 Sep 2023 16:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjI0Qr0 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 27 Sep 2023 12:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjI0Qr0 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 27 Sep 2023 12:47:26 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DC091;
        Wed, 27 Sep 2023 09:47:24 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3E70A1C0006;
        Wed, 27 Sep 2023 16:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695833243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DQh+VL37lttml5PY/RZhphyyTOjmlGUq3/JRTV8uL1c=;
        b=QlwE6x3CQEKPOS28jI0vcQ3tGM0k0Lm56o1Bh0FEZ98n8wTVB9+jrilEMguqWKYsDe5qaG
        xzNBJdbSWPt5Pwx1vU3np8j4Qnb1sQOvpwWD5+bgyqwHytFY7Cdl+VnzRVkAjtp8FQ4wke
        HPqmdEujtBzY229Ru7UA11U9a+4h5CFewPY1XDHTOBCcOqWKRhVnERU+wIqCPnf5VgChyA
        a7FbqioD6C3LeKwpCN7mQ/Cwh0/254QhkB+E0KFLQHfbcvjcJROODpTRlO9ckU8/yU9WhK
        5UU6+nno+6mVWFDq1HT9H1nElBD6rKlA6UeWMNaTbDKZMX44TNXwhHNbWTHiFA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-next v5 01/11] ieee802154: Let PAN IDs be reset
Date:   Wed, 27 Sep 2023 18:47:04 +0200
Message-Id: <20230927164714.128476-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927164714.128476-1-miquel.raynal@bootlin.com>
References: <20230927164714.128476-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Soon association and disassociation will be implemented, which will
require to be able to either change the PAN ID from 0xFFFF to a real
value when association succeeded, or to reset the PAN ID to 0xFFFF upon
disassociation. Let's allow to do that manually for now.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 net/ieee802154/nl802154.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index d610c1886160..46ac6f599fe1 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -1087,16 +1087,6 @@ static int nl802154_set_pan_id(struct sk_buff *skb, struct genl_info *info)
 
 	pan_id = nla_get_le16(info->attrs[NL802154_ATTR_PAN_ID]);
 
-	/* TODO
-	 * I am not sure about to check here on broadcast pan_id.
-	 * Broadcast is a valid setting, comment from 802.15.4:
-	 * If this value is 0xffff, the device is not associated.
-	 *
-	 * This could useful to simple deassociate an device.
-	 */
-	if (pan_id == cpu_to_le16(IEEE802154_PAN_ID_BROADCAST))
-		return -EINVAL;
-
 	return rdev_set_pan_id(rdev, wpan_dev, pan_id);
 }
 
-- 
2.34.1

