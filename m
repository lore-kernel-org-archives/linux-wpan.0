Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DC8C433F5
	for <linux-wpan@archiver.kernel.org>; Fri, 18 Mar 2022 18:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240311AbiCRS6p (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 18 Mar 2022 14:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240299AbiCRS61 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 18 Mar 2022 14:58:27 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D195232D19;
        Fri, 18 Mar 2022 11:57:05 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 570F6C0009;
        Fri, 18 Mar 2022 18:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647629823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7uhKeSJ5TdvqQx9rBcypmjG7Wuhjj3YD9ai0d1ExtG4=;
        b=Kq2QY0XfTQ54KLEUenh/1SARhK7DqAJX8ZA5+RQlOBz5fniOvyfeO7eXqDj05QJ3S0Md6p
        HxkP/xN42jtBfLpwto29kfsT1u1/eUPE9qGvDPytZD2ffbIFBoazYbHiWEZG8p6DidNh4U
        hS9CRuVQLklNY4kVYQPQw/11hwkNIo5bN990PkAGkfllSE/kkvN1kMPikvVZlq+3GYFp/f
        s+F51MBQVUC+QHuyB0dlr9kTQp5ePz4zTXj849wg/ufT/y/WIp/urXXTuLihcM8pOEbx3i
        FO6Pp/tzfllFU4A0l5yaw2uRfSgykz95hZS0ox+LWjTMD26NstiR2VZSOb4V8w==
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
Subject: [PATCH wpan-next v4 11/11] net: ieee802154: ca8210: Call _xmit_error() when a transmission fails
Date:   Fri, 18 Mar 2022 19:56:44 +0100
Message-Id: <20220318185644.517164-12-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220318185644.517164-1-miquel.raynal@bootlin.com>
References: <20220318185644.517164-1-miquel.raynal@bootlin.com>
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
 drivers/net/ieee802154/ca8210.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 116aece191cd..b1eb74200f23 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -1729,11 +1729,11 @@ static int ca8210_async_xmit_complete(
 			status
 		);
 		if (status != IEEE802154_TRANSACTION_OVERFLOW) {
-			dev_kfree_skb_any(priv->tx_skb);
-			ieee802154_wake_queue(priv->hw);
+			ieee802154_xmit_error(priv->hw, priv->tx_skb, status);
 			return 0;
 		}
 	}
+
 	ieee802154_xmit_complete(priv->hw, priv->tx_skb, true);
 
 	return 0;
-- 
2.27.0

