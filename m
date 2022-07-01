Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79050CCA479
	for <linux-wpan@archiver.kernel.org>; Fri,  1 Jul 2022 14:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiGAOgk (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 1 Jul 2022 10:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGAOfs (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 1 Jul 2022 10:35:48 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7056F419BD;
        Fri,  1 Jul 2022 07:31:26 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 75B15FF80A;
        Fri,  1 Jul 2022 14:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656685885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Si5ugFl42mYJfb0QZ4VrOuuWsvqGFMavmyvZm4reCcU=;
        b=NTmCkCkqNPcjMn1tZn14i1KNqsnurzDvLZc3G2ZlHNKbWso0UtZ7bBSpyg+mv5ICqBm3Sq
        QS9Yi4L29u1fdfxZsXEfK4ZhAHXWaKvTbqJkzMs+Tw12Q8canjMomgtZ/lV5a3EmwhJbPN
        eOzFH8WF0zZIcH10fc3NFYrn6ofckBUniteedeOmmzRcsh1p4nnAHtO8lnutMeo35x7gw6
        6GC9QOI7UMEI4p9uV+8F5K/+f7GQ6wPBWYV9qwrnY4eVmYyfrWo+tKsl/L58XxUAInDpTU
        S84rYavVVPyG30IA5VAdOMF6wLXP23/mBWLXp63O3vJvGluXRsr1CJZVA25CKg==
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-next 15/20] net: ieee802154: Add support for allowing to answer BEACON_REQ
Date:   Fri,  1 Jul 2022 16:30:47 +0200
Message-Id: <20220701143052.1267509-16-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220701143052.1267509-1-miquel.raynal@bootlin.com>
References: <20220701143052.1267509-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
index 9505e17e7ce7..00b03c33e826 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -1594,7 +1594,7 @@ nl802154_send_beacons(struct sk_buff *skb, struct genl_info *info)
 
 	if (info->attrs[NL802154_ATTR_BEACON_INTERVAL]) {
 		request->interval = nla_get_u8(info->attrs[NL802154_ATTR_BEACON_INTERVAL]);
-		if (request->interval > IEEE802154_MAX_SCAN_DURATION) {
+		if (request->interval > IEEE802154_ACTIVE_SCAN_DURATION) {
 			pr_err("Interval is out of range\n");
 			err = -EINVAL;
 			goto free_request;
-- 
2.34.1

