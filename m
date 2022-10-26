Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F57EC38A2D
	for <linux-wpan@archiver.kernel.org>; Wed, 26 Oct 2022 09:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbiJZJfL (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 26 Oct 2022 05:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbiJZJfJ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 26 Oct 2022 05:35:09 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5215E66D;
        Wed, 26 Oct 2022 02:35:07 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 415092001C;
        Wed, 26 Oct 2022 09:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666776906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XrzTkPIL8thiU5wCzH/+zPzFdA7kEidJic1LEXioe7I=;
        b=FZq4nS58HyLF4eN2uGY3FBxr3IMxf6a3Iuer9iY3mOF6UtDKr72fgb0cA/P6kSwz3rckoj
        sOMjrLtewnsjYD5xprf2Bqo9cfdXsuW2tW17ZLNQI50tf2L8TuuRx1thAUeN83WWsSIb04
        drv01V0FxwZOQdiby/8SHeA3RzX3YhhnsuOzE3K5b6XmHNEZLDVzskVYQs6MFN2oqH/CgO
        YF07wzcaJoshM0qnPClEr+WdpvEuVKXAr/fxAFU+UP0bqrOSyyj7GUBJBFmGi+agRLP79W
        ktoqoEwwHeKpgsomyYGOq0JT4QU7+nkRYeDZGgCyYwsRteINDBx2vEbZmI5DSA==
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
Subject: [PATCH wpan-next v2 0/3] IEEE 802.15.4: Add coordinator interfaces
Date:   Wed, 26 Oct 2022 11:34:59 +0200
Message-Id: <20221026093502.602734-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello,
These three patches allow the creation of coordinator interfaces, which
were already defined without being usable. The idea behind is to use
them advertizing PANs through the beaconing feature.

Changes since v1:
* Addition of patches 1 and 2.
* Improved the commit message of patch 3.
* Rebased.
* Minor fixes.

Miquel Raynal (3):
  mac802154: Move an skb free within the rx path
  mac802154: Clarify an expression
  mac802154: Allow the creation of coordinator interfaces

 net/mac802154/iface.c | 15 ++++++++-------
 net/mac802154/main.c  |  2 +-
 net/mac802154/rx.c    | 24 +++++++++++-------------
 3 files changed, 20 insertions(+), 21 deletions(-)

-- 
2.34.1

