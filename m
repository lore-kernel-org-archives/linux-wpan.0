Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:63776 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbaKLSwG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 12 Nov 2014 13:52:06 -0500
Received: by mail-wi0-f182.google.com with SMTP id d1so5866132wiv.9
        for <linux-wpan@vger.kernel.org>; Wed, 12 Nov 2014 10:52:04 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/2] ieee802154: introduce new interframe spacing time handling
Date: Wed, 12 Nov 2014 19:51:55 +0100
Message-Id: <1415818317-26487-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch series contains patches for introducing and use of interframe
spacing time handling. The interframe spacing time handling depends on
transceiver if it's done at transceiver level or need to be done at SoftMAC
(mac802154) level. On the at86rf2xx transceiver this is done at transceiver
when max frame retries is above 0.

The mac802154 solution is to run a hrtimer which start at complete function.
When the timer expires we wake the queue again. This stops the transmit queue
after a transmit for a specific time.

Currently all drivers except the at86rf230 cares about interframe spacing time.
I think nobody hit the issue because the latency of workqueue. If we don't making
interframe spacing time with async xmit handler we run into fragmentation issues
while 802.15.4 6LoWPAN.

Alexander Aring (2):
  mac802154: add interframe spacing time handling
  at86rf230: remove interframe spacing time workaround

 drivers/net/ieee802154/at86rf230.c | 60 +++++++++++++++++++++++---------------
 include/linux/ieee802154.h         |  3 ++
 include/net/cfg802154.h            |  8 +++++
 include/net/mac802154.h            |  3 +-
 net/mac802154/ieee802154_i.h       |  4 +++
 net/mac802154/iface.c              |  2 ++
 net/mac802154/main.c               | 17 +++++++++++
 net/mac802154/tx.c                 |  2 +-
 net/mac802154/util.c               | 32 ++++++++++++++++++--
 9 files changed, 103 insertions(+), 28 deletions(-)

-- 
2.1.3

