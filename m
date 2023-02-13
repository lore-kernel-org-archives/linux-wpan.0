Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629FCC636D4
	for <linux-wpan@archiver.kernel.org>; Mon, 13 Feb 2023 16:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjBMQzT (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 13 Feb 2023 11:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBMQzS (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 13 Feb 2023 11:55:18 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927161F916;
        Mon, 13 Feb 2023 08:54:31 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9550124000E;
        Mon, 13 Feb 2023 16:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1676307265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qBQX3LuTYDPAWDw+UNzjgwxc82OmD0XMIiMOQ++fvhQ=;
        b=ARY5t1x4HuozPWpqOaqlA9+EfOCeh2YZVkbP44jnefTeHZY/RMpE/8dgLk4ImQR25d3hSQ
        PftFChpthNauBzf+ZmaR/KpFQxHzA6fqA4jqvAPB57XTIMMimOgxIxhxIsyWkp6MHLWtn3
        hcljcevu3gr3QaLcwQiiPO+mDIoiu1lImRe0QTHy/hoBbHOd07IdCpUJNS0NQ1NQA4vV6s
        dm9Hbq22FDN7gPP6QQU5A/dGtsxMwgILIuPH1YLFiKjRqUOp86uu6h7aMcMaXHj2uMbgex
        dmbup14RyuwkjQrWet75X9aHMRbPdwtCGsNimO8bm5FbxWrzr8lS6wMiIt0Liw==
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
        Miquel Raynal <miquel.raynal@bootlin.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH wpan 5/6] mac802154: Fix an always true condition
Date:   Mon, 13 Feb 2023 17:54:13 +0100
Message-Id: <20230213165414.1168401-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230213165414.1168401-1-miquel.raynal@bootlin.com>
References: <20230213165414.1168401-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

At this stage we simply do not care about the delayed work value,
because active scan is not yet supported, so we can blindly queue
another work once a beacon has been sent.

It fixes a smatch warning:
    mac802154_beacon_worker() warn: always true condition
    '(local->beacon_interval >= 0) => (0-u32max >= 0)'

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 net/mac802154/scan.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index fff41e59099e..9b0933a185eb 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -383,9 +383,8 @@ void mac802154_beacon_worker(struct work_struct *work)
 		dev_err(&sdata->dev->dev,
 			"Beacon could not be transmitted (%d)\n", ret);
 
-	if (local->beacon_interval >= 0)
-		queue_delayed_work(local->mac_wq, &local->beacon_work,
-				   local->beacon_interval);
+	queue_delayed_work(local->mac_wq, &local->beacon_work,
+			   local->beacon_interval);
 }
 
 int mac802154_stop_beacons_locked(struct ieee802154_local *local,
-- 
2.34.1

