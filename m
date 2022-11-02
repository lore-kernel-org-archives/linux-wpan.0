Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535DFC4332F
	for <linux-wpan@archiver.kernel.org>; Wed,  2 Nov 2022 15:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiKBPTs (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 2 Nov 2022 11:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiKBPT1 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 2 Nov 2022 11:19:27 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F341D30D;
        Wed,  2 Nov 2022 08:19:20 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B0812C0014;
        Wed,  2 Nov 2022 15:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667402358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=e/+HUR4SfBX/zvqqCbqjzxp/i1FlOkM3Cjn1zViCHl4=;
        b=UiwkT2SW0IZO+y/JxPZ6ahcnzZKKoogk8jPJaNFtcnd52fQy9a98IQ6AaWZxLfgTryd8+P
        GZZlGHuPB8SjCLswwg0VYMEq9e9UxCVj0Y+NgivqkCqnnKUUX8rBX9Fl11jcAV/tXq9Yi1
        XZzYR4eWo9O9ZWhss4TH9Mg6wH/o6Mam/SEqO2B7i/xAd6bHZYeXwyp3U8h0lVHByZFpUJ
        eEIbKLigrkL4zFEJQKw+FthTyCgjuz8XhAY38Z9mXt7hvaArRoiKpeLKou+SV05QWhMo1C
        EO1l5PkhcpuX1EUGGqhtb57qKKc6H6UErVD5EExbK/KxAOfVLdkohyQ02DWTwQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org
Cc:     David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH wpan-next 0/3] IEEE 802.15.4 PAN discovery handling
Date:   Wed,  2 Nov 2022 16:19:12 +0100
Message-Id: <20221102151915.1007815-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello,

Last preparation step before the introduction of the scanning feature
(really): generic helpers to handle PAN discovery upon beacon
reception. We need to tell user space about the discoveries.

In all the past, current and future submissions, David and Romuald from
Qorvo are credited in various ways (main author, co-author,
suggested-by) depending of the amount of rework that was involved on
each patch, reflecting as much as possible the open-source guidelines we
follow in the kernel. All this effort is made possible thanks to Qorvo
Inc which is pushing towards a featureful upstream WPAN support.

Cheers,
Miquèl

David Girault (1):
  ieee802154: Trace the registration of new PANs

Miquel Raynal (2):
  ieee802154: Advertize coordinators discovery
  ieee802154: Handle coordinators discovery

 include/net/cfg802154.h   |  32 ++++++++++
 include/net/nl802154.h    |  44 ++++++++++++++
 net/ieee802154/Makefile   |   2 +-
 net/ieee802154/core.c     |   2 +
 net/ieee802154/nl802154.c | 123 ++++++++++++++++++++++++++++++++++++++
 net/ieee802154/nl802154.h |   6 ++
 net/ieee802154/pan.c      | 116 +++++++++++++++++++++++++++++++++++
 net/ieee802154/trace.h    |  25 ++++++++
 8 files changed, 349 insertions(+), 1 deletion(-)
 create mode 100644 net/ieee802154/pan.c

-- 
2.34.1

