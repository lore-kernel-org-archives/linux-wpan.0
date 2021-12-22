Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E974C433F5
	for <linux-wpan@archiver.kernel.org>; Wed, 22 Dec 2021 15:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343808AbhLVP54 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 22 Dec 2021 10:57:56 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:49907 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343803AbhLVP5v (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 22 Dec 2021 10:57:51 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id C64D760017;
        Wed, 22 Dec 2021 15:57:48 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org
Cc:     David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [net-next 03/18] net: ieee802154: Move IEEE 802.15.4 Kconfig main entry
Date:   Wed, 22 Dec 2021 16:57:28 +0100
Message-Id: <20211222155743.256280-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211222155743.256280-1-miquel.raynal@bootlin.com>
References: <20211222155743.256280-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

From: David Girault <david.girault@qorvo.com>

It makes certainly more sense to have all the low-range wireless
protocols such as Bluetooth, IEEE 802.11 (WiFi) and IEEE 802.15.4
together, so let's move the main IEEE 802.15.4 stack Kconfig entry at a
better location.

Signed-off-by: David Girault <david.girault@qorvo.com>
[miquel.raynal@bootlin.com: Isolate this change from a bigger commit and
rewrite the commit message.]
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 net/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/Kconfig b/net/Kconfig
index 8a1f9d0287de..0da89d09ffa6 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -228,7 +228,6 @@ source "net/x25/Kconfig"
 source "net/lapb/Kconfig"
 source "net/phonet/Kconfig"
 source "net/6lowpan/Kconfig"
-source "net/ieee802154/Kconfig"
 source "net/mac802154/Kconfig"
 source "net/sched/Kconfig"
 source "net/dcb/Kconfig"
@@ -380,6 +379,7 @@ source "net/mac80211/Kconfig"
 
 endif # WIRELESS
 
+source "net/ieee802154/Kconfig"
 source "net/rfkill/Kconfig"
 source "net/9p/Kconfig"
 source "net/caif/Kconfig"
-- 
2.27.0

