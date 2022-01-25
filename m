Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AFEC433F5
	for <linux-wpan@archiver.kernel.org>; Tue, 25 Jan 2022 12:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444835AbiAYM2Q (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 25 Jan 2022 07:28:16 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:37637 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383104AbiAYMZ6 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 25 Jan 2022 07:25:58 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 278D1FF806;
        Tue, 25 Jan 2022 12:25:41 +0000 (UTC)
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
Subject: [wpan-next v3 0/3] ieee802154: A bunch of light changes
Date:   Tue, 25 Jan 2022 13:25:37 +0100
Message-Id: <20220125122540.855604-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Here are a few small cleanups and improvements in preparation of a wider
series bringing a lot of features. These are aside changes, hence they
have their own small series.

Changes in v3:
* Split the v2 into two series: fixes for the wpan branch and cleanups
  for wpan-next. Here are random "cleanups".
* Reworded the ieee802154_wake/stop_queue helpers kdoc as discussed
  with Alexander.

Miquel Raynal (3):
  net: ieee802154: hwsim: Ensure frame checksum are valid
  net: ieee802154: Use the IEEE802154_MAX_PAGE define when relevant
  net: mac802154: Explain the use of ieee802154_wake/stop_queue()

 drivers/net/ieee802154/mac802154_hwsim.c |  2 +-
 include/net/mac802154.h                  | 12 ++++++++++++
 net/ieee802154/nl-phy.c                  |  4 ++--
 3 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.27.0

