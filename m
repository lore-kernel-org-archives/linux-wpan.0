Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29180C433EF
	for <linux-wpan@archiver.kernel.org>; Fri,  1 Jul 2022 14:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiGAOg6 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 1 Jul 2022 10:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiGAOgI (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 1 Jul 2022 10:36:08 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5208470E41;
        Fri,  1 Jul 2022 07:31:34 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8A7BAFF805;
        Fri,  1 Jul 2022 14:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656685892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1LSAcTXR6qicmezvRhlLgmcrUrtDDK9geZUwOZJlwAk=;
        b=PeqKqg6LU1afhIBtFeBEK2gfuSydBsWEau2zrssFjDPO0ja4xUfWRZpZwdN7sDADsNyMxt
        XapjTXFMhdlqNZSzhZl/Ro5TvUqgQNgsOeJW7PCxNmUnDzlJrFjB16xx/9kbF6i+NL33v1
        9ML97MhOiRUR7Op9CFG/+DPpE4WKUJhisVbKncsgcqPxgiB0uklO0zZQO8VeE8jOGWqn+G
        kWvCSyrO++xVQDutKpWZCZn9rmLM2A0mIRMBAqZcsLptmBATu6x8A65NakWlB9WeJbaNYR
        4yeg+cgbEqHxvtGUzQKvnEZ4QFrbP0BqBbc/6/Y8zxqD3vVlULHvG9E+6NInkw==
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
Subject: [PATCH wpan-next 19/20] ieee802154: hwsim: Do not check the rtnl
Date:   Fri,  1 Jul 2022 16:30:51 +0200
Message-Id: <20220701143052.1267509-20-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220701143052.1267509-1-miquel.raynal@bootlin.com>
References: <20220701143052.1267509-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

There is no need to ensure the rtnl is locked when changing a driver's
channel. This cause issues when scanning and this is the only driver
relying on it. Just drop this dependency because it does not seem
legitimate.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/net/ieee802154/mac802154_hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index 38c217bd7c82..a5b9fc2fb64c 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -100,7 +100,7 @@ static int hwsim_hw_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
 	pib->page = page;
 	pib->channel = channel;
 
-	pib_old = rtnl_dereference(phy->pib);
+	rcu_assign_pointer(pib_old, phy->pib);
 	rcu_assign_pointer(phy->pib, pib);
 	kfree_rcu(pib_old, rcu);
 	return 0;
-- 
2.34.1

