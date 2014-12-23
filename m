Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:33175 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754155AbaLWO25 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Dec 2014 09:28:57 -0500
Received: by mail-wg0-f48.google.com with SMTP id y19so9163445wgg.7
        for <linux-wpan@vger.kernel.org>; Tue, 23 Dec 2014 06:28:56 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/7] ieee802154: 6lowpan: remove full-size calculation workarounds
Date: Tue, 23 Dec 2014 15:28:22 +0100
Message-Id: <1419344909-16007-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>

Hi,

this patch series based on "ieee802154: 6lowpan: separate receive/transmit functionality".

In this patch series I mainly removes the lowpan_uncompress_size function
workarounds. Why this is a workaround solution? So this function parse again
the 6LoWPAN header for getting the 6LoWPAN header size. We do parsing twice
and this is the first ugly thing there. The second thing is that when we
add new header compression we need to touch the lowpan_uncompress_size again
for adding next header size calculation. This series removes the workaround
so we need to parse/create this only once. It was myself which introduce
this workaround to have at first something which works. Since Martin Townsend
work which put out the lowpan_give_upper_layer outside of the iphc decompression
we can handle it now in that way.

This patch also includes some cleanup patches which I detect while programming
this one. In futher the 6LoWPAN parsing should look like mac802154 parsing.
mac802154 parsing look like mac80211. To rework the 6LoWPAN parsing will be
the next steps.

Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>

Alexander Aring (7):
  6lowpan: allow pull only at lowpan_fetch_skb
  ieee802154: 6lowpan: skb_pull with error handling
  ieee802154: 6lowpan: use skb_network_header
  ieee802154: 6lowpan: remove rx full-size calc workaround
  ieee802154: 6lowpan: handle fragmented IPv6
  ieee802154: 6lowpan: cleanup frag dispatch cases
  ieee802154: 6lowpan: remove tx full-size calc workaround

 include/net/6lowpan.h               | 117 +-----------------------------------
 net/ieee802154/6lowpan/6lowpan_i.h  |   1 +
 net/ieee802154/6lowpan/reassembly.c |  31 ++++++++--
 net/ieee802154/6lowpan/rx.c         |  39 +++++-------
 net/ieee802154/6lowpan/tx.c         |  18 +++---
 5 files changed, 56 insertions(+), 150 deletions(-)

-- 
2.2.0

