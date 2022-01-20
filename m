Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6545EC433EF
	for <linux-wpan@archiver.kernel.org>; Thu, 20 Jan 2022 00:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357860AbiATAg7 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 19 Jan 2022 19:36:59 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:57505 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357851AbiATAg4 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 19 Jan 2022 19:36:56 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AF4BCC0008;
        Thu, 20 Jan 2022 00:36:53 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, Xue Liu <liuxuenetmail@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Harry Morris <harrymorris12@gmail.com>,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [wpan-next 4/9] net: ieee802154: at86rf230: Stop leaking skb's
Date:   Thu, 20 Jan 2022 01:36:40 +0100
Message-Id: <20220120003645.308498-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220120003645.308498-1-miquel.raynal@bootlin.com>
References: <20220120003645.308498-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Upon error the ieee802154_xmit_complete() helper is not called. Only
ieee802154_wake_queue() is called manually. We then leak the skb
structure.

Free the skb structure upon error before returning.

There is no Fixes tag applying here, many changes have been made on this
area and the issue kind of always existed.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/net/ieee802154/at86rf230.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 7d67f41387f5..0746150f78cf 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -344,6 +344,7 @@ at86rf230_async_error_recover_complete(void *context)
 		kfree(ctx);
 
 	ieee802154_wake_queue(lp->hw);
+	dev_kfree_skb_any(lp->tx_skb);
 }
 
 static void
-- 
2.27.0

