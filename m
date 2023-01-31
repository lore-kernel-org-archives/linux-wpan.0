Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73E0C38142
	for <linux-wpan@archiver.kernel.org>; Tue, 31 Jan 2023 10:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjAaK6U (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 31 Jan 2023 05:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjAaK6S (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 31 Jan 2023 05:58:18 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925BB10411;
        Tue, 31 Jan 2023 02:58:16 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D66F3C0018;
        Tue, 31 Jan 2023 10:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675162695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lNQyNQb3N/K/Yq532srItLp6nhYDICBlRRTSIJegeLA=;
        b=n1CQys+vNDVYRRURYSeeIdPA4bUcDqj3McSu3aeOfnfD1XHk490g8073UMN4wFZwNJwySo
        HdKEsymEdAfX7Q0QbSrhlwIx80A/UVZLYgcb4r8+slNWIa1defx7RHB0k01GvXCewfKekT
        kbI3glOiX+vnNq1urDKEV5SCbss1Y7I1Ke/lD2TBUHXlskgTISopKMvY/8NwIgezuPPTkB
        V9P6quvKLOES3YoFA6sUJffA/+TTaKDcNvtSE1fXHwyxwAaF12vrzzWqQQ0V1Ry80LafeI
        cC6e3TwY1j+5CDjjr8zbcvQKlQILAC2uiZKFh76CgVI/7uwyW+ER95TCjQLaDQ==
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
Subject: [wpan-next 3/4] ieee802154: Add support for allowing to answer BEACON_REQ
Date:   Tue, 31 Jan 2023 11:57:56 +0100
Message-Id: <20230131105757.163034-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131105757.163034-1-miquel.raynal@bootlin.com>
References: <20230131105757.163034-1-miquel.raynal@bootlin.com>
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
index c48b937936aa..5692c328b5bf 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -1617,7 +1617,7 @@ nl802154_send_beacons(struct sk_buff *skb, struct genl_info *info)
 
 	if (info->attrs[NL802154_ATTR_BEACON_INTERVAL]) {
 		request->interval = nla_get_u8(info->attrs[NL802154_ATTR_BEACON_INTERVAL]);
-		if (request->interval > IEEE802154_MAX_SCAN_DURATION) {
+		if (request->interval > IEEE802154_ACTIVE_SCAN_DURATION) {
 			pr_err("Interval is out of range\n");
 			err = -EINVAL;
 			goto free_request;
-- 
2.34.1

