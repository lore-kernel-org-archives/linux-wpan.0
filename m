Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA702CD13D2
	for <linux-wpan@archiver.kernel.org>; Mon, 18 Sep 2023 15:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjIRPpn (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 18 Sep 2023 11:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjIRPpl (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 18 Sep 2023 11:45:41 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF5310C4;
        Mon, 18 Sep 2023 08:43:23 -0700 (PDT)
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id E887AD0647;
        Mon, 18 Sep 2023 15:08:31 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9C3421C000D;
        Mon, 18 Sep 2023 15:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695049711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DQh+VL37lttml5PY/RZhphyyTOjmlGUq3/JRTV8uL1c=;
        b=dQmQ7if9KvXsnzBzi9Me/UvJMHvDr2+y28mol79FWlc6tT7kXE0lU1a9VMNx7WSL/LFI0u
        MpAwKn3AilWbf+ckkcjy0a6Nz8KAK24K6ZVGml8wy9uK1aTtHpDiPV9yq7b2glQs90GCL5
        gvObWAAIpdbDSRIwrvumMzQYB85eCc7kd4Hey5d+1CU4SZC+KwQ9rCeZuObfyAoFrhqlvD
        AVGWV3w7S9uJFr28VGNRC9FFmJIsvHCIOdbgNliS5Q0/A8Jc/EAr7YCXYt/s73HOYlBLan
        3ebuvmaqWHOHCMpnfF9mXIY6KbD4SJ17Tq/UUL+zmhZRbjBdm958XuDq8Tmzlw==
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
Subject: [PATCH wpan-next v3 01/11] ieee802154: Let PAN IDs be reset
Date:   Mon, 18 Sep 2023 17:07:59 +0200
Message-Id: <20230918150809.275058-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918150809.275058-1-miquel.raynal@bootlin.com>
References: <20230918150809.275058-1-miquel.raynal@bootlin.com>
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

