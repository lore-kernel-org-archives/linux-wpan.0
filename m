Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C1BC433F5
	for <linux-wpan@archiver.kernel.org>; Mon,  7 Feb 2022 15:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351856AbiBGPMX (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 7 Feb 2022 10:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442267AbiBGOsO (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 7 Feb 2022 09:48:14 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B66C0401C2;
        Mon,  7 Feb 2022 06:48:14 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6E11020004;
        Mon,  7 Feb 2022 14:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644245292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ldA300CM2Fkg8uMoeWMMCYiaylyn7EXhdD1N6AVozPY=;
        b=FlNiqOnsr2gApYAQchcUmE+7c7Kd42Jtxn/9SVN88gvTRV9Q38iMhg5Zv6Y35CVoN76I0y
        t3xXJeGJGVAwa4gRgh5cLzp7R2FFEI3yEM7phBuo1BQcCc/q+2lkAJWNiCvFxzyLt2CDm0
        cm0YT2ItxcP6re2lW2PIXmdSE1A75yWMp07OqEc/O67rNXScfmNqmXb8XKfa/ACkfxd/Uk
        l1QwSVHpVBWN2QgcfeD0wfViI3Z2Y2/fg9CKcVl625WbpuHR/SnVI1l1m+g9ASsqXahokf
        ToAY2N3+dKi6HIfLksDaIDG7JDi3Mt47k3Sh8Ho+VzvIYPmhPvW67KMGL8N/GQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-next v2 04/14] net: ieee802154: atusb: Call _xmit_error() when a transmission fails
Date:   Mon,  7 Feb 2022 15:47:54 +0100
Message-Id: <20220207144804.708118-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220207144804.708118-1-miquel.raynal@bootlin.com>
References: <20220207144804.708118-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

ieee802154_xmit_error() is the right helper to call when a transmission
has failed. Let's use it instead of open-coding it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/net/ieee802154/atusb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
index f27a5f535808..0e6f180b4e79 100644
--- a/drivers/net/ieee802154/atusb.c
+++ b/drivers/net/ieee802154/atusb.c
@@ -271,9 +271,7 @@ static void atusb_tx_done(struct atusb *atusb, u8 seq)
 		 * unlikely case now that seq == expect is then true, but can
 		 * happen and fail with a tx_skb = NULL;
 		 */
-		ieee802154_wake_queue(atusb->hw);
-		if (atusb->tx_skb)
-			dev_kfree_skb_irq(atusb->tx_skb);
+		ieee802154_xmit_error(atusb->hw, atusb->tx_skb, false);
 	}
 }
 
-- 
2.27.0

