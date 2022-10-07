Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C368C433F5
	for <linux-wpan@archiver.kernel.org>; Fri,  7 Oct 2022 08:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJGIxr (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 7 Oct 2022 04:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiJGIxp (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 7 Oct 2022 04:53:45 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C2E1176D0;
        Fri,  7 Oct 2022 01:53:36 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3E1A31BF219;
        Fri,  7 Oct 2022 08:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665132814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aGRNCGNS064CIJP0zfs/0SttjDUV/R2b1TtqqrmcegY=;
        b=NhOEwu3P49RZlCINVR3MvlMlLWeb4yQvIjzVhzNtII4k9fuWFCAoiCrCZaFLJ0BvKestxU
        wfGc3+X2ChzN/YQGka4Fb6zBTV12IHPH6D4paTTMx3ULA6tO1EFt87BGUt9hXy7/dzd5Xs
        SBEd4Bhc6V52davad4ZgoHWNIG8RUwDOriZkrMlLgVhI1zYfzoBUTbHhTNUnd6GYpcp7ND
        pTMSxud/9MU6PIPHhMvWg/+DwkMUz6C59dTBXVjwDX/xcouHBSrPg9YDiIBwNj84PKEoz/
        2/a1UuJ0J769BOfCcu8L9+uI4HQ3Z5i+Jx1W9n+RlmxE/JmMQ+P2p0bv9YO8EA==
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
Subject: [PATCH wpan/next v4 7/8] mac802154: Avoid delivering frames received in a non satisfying filtering mode
Date:   Fri,  7 Oct 2022 10:53:09 +0200
Message-Id: <20221007085310.503366-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221007085310.503366-1-miquel.raynal@bootlin.com>
References: <20221007085310.503366-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

We must avoid the situation where one interface disables address
filtering and AACK on the PHY while another interface expects to run
with AACK and address filtering enabled. Just ignore the frames on the
concerned interface if this happens.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 net/mac802154/rx.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 8438bdcd5042..14bc646b9ab7 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -211,6 +211,13 @@ __ieee802154_rx_handle_packet(struct ieee802154_local *local,
 		if (!ieee802154_sdata_running(sdata))
 			continue;
 
+		/* Do not deliver packets received on interfaces expecting
+		 * AACK=1 if the address filters where disabled.
+		 */
+		if (local->hw.phy->filtering < IEEE802154_FILTERING_4_FRAME_FIELDS &&
+		    sdata->required_filtering == IEEE802154_FILTERING_4_FRAME_FIELDS)
+			continue;
+
 		ieee802154_subif_frame(sdata, skb, &hdr);
 		skb = NULL;
 		break;
@@ -270,11 +277,6 @@ void ieee802154_rx(struct ieee802154_local *local, struct sk_buff *skb)
 
 	ieee802154_monitors_rx(local, skb);
 
-	/* TODO: Avoid delivering frames received at the level
-	 * IEEE802154_FILTERING_NONE on interfaces not expecting it because of
-	 * the missing auto ACK handling feature.
-	 */
-
 	/* TODO: Handle upcomming receive path where the PHY is at the
 	 * IEEE802154_FILTERING_NONE level during a scan.
 	 */
-- 
2.34.1

