Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CF3C433EF
	for <linux-wpan@archiver.kernel.org>; Thu,  9 Jun 2022 20:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbiFIUaG (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 9 Jun 2022 16:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbiFIUaF (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 9 Jun 2022 16:30:05 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [IPv6:2a01:4f8:121:31eb:3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD9B28D6B3;
        Thu,  9 Jun 2022 13:30:03 -0700 (PDT)
Received: from localhost.localdomain.datenfreihafen.local (p200300e9d72f7220bc8f3831994f1895.dip0.t-ipconnect.de [IPv6:2003:e9:d72f:7220:bc8f:3831:994f:1895])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@sostec.de)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 034D2C03A0;
        Thu,  9 Jun 2022 22:30:00 +0200 (CEST)
From:   Stefan Schmidt <stefan@datenfreihafen.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-wpan@vger.kernel.org, alex.aring@gmail.com,
        netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: pull-request: ieee802154-next 2022-06-09
Date:   Thu,  9 Jun 2022 22:29:56 +0200
Message-Id: <20220609202956.1512156-1-stefan@datenfreihafen.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello Dave, Jakub.

An update from ieee802154 for your *net-next* tree.

This is a separate pull request for 6lowpan changes. We agreed with the
bluetooth maintainers to switch the trees these changing are going into
from bluetooth to ieee802154.

Jukka Rissanen stepped down as a co-maintainer of 6lowpan (Thanks for the
work!). Alexander is staying as maintainer.

Alexander reworked the nhc_id lookup in 6lowpan to be way simpler.
Moved the data structure from rb to an array, which is all we need in this
case.

regards
Stefan Schmidt

The following changes since commit 0530a683fc858aa641d88ad83315ea53c27bce10:

  Merge branch 'vsock-virtio-add-support-for-device-suspend-resume' (2022-05-02 16:04:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan-next.git tags/ieee802154-for-net-next-2022-06-09

for you to fetch changes up to 260b5c694bd41fd53b1aa21fbea369568c7b5a4a:

  MAINTAINERS: Remove Jukka Rissanen as 6lowpan maintainer (2022-06-09 21:53:28 +0200)

----------------------------------------------------------------
Alexander Aring (3):
      net: 6lowpan: remove const from scalars
      net: 6lowpan: use array for find nhc id
      net: 6lowpan: constify lowpan_nhc structures

Jukka Rissanen (1):
      MAINTAINERS: Remove Jukka Rissanen as 6lowpan maintainer

 MAINTAINERS                     |   1 -
 net/6lowpan/nhc.c               | 103 ++++++++--------------------------------
 net/6lowpan/nhc.h               |  38 ++++++---------
 net/6lowpan/nhc_dest.c          |   9 +---
 net/6lowpan/nhc_fragment.c      |   9 +---
 net/6lowpan/nhc_ghc_ext_dest.c  |   9 +---
 net/6lowpan/nhc_ghc_ext_frag.c  |  11 +----
 net/6lowpan/nhc_ghc_ext_hop.c   |   9 +---
 net/6lowpan/nhc_ghc_ext_route.c |   9 +---
 net/6lowpan/nhc_ghc_icmpv6.c    |   9 +---
 net/6lowpan/nhc_ghc_udp.c       |   9 +---
 net/6lowpan/nhc_hop.c           |   9 +---
 net/6lowpan/nhc_ipv6.c          |  11 +----
 net/6lowpan/nhc_mobility.c      |   9 +---
 net/6lowpan/nhc_routing.c       |   9 +---
 net/6lowpan/nhc_udp.c           |   9 +---
 16 files changed, 48 insertions(+), 215 deletions(-)
