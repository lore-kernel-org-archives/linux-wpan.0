Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:41558 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755630AbaJ2Ufs (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 16:35:48 -0400
Received: by mail-wi0-f172.google.com with SMTP id bs8so2788123wib.5
        for <linux-wpan@vger.kernel.org>; Wed, 29 Oct 2014 13:35:47 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 00/17] ieee802154: fix checksum and monitor handling
Date: Wed, 29 Oct 2014 21:34:27 +0100
Message-Id: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch series fix checksum and monitor handling. The checksum handling
is currently a little bit weird, because all driver drops the checksum while
delivering. In monitor mode we want to see the received checksum. This patch
series contains various patches to fix the checksum handling and add basic
support for real monitor mode with promiscuous mode setting.

The checksum handling is now in some state which should work also for monitor
interfaces. There exist a better way to add runtime changeable flags to handle
crc calculation via hardware or software. Also flags like if the monitor
interface receiving is with or without checksum. This is only to introduce some
behaviour which should working.

Alexander Aring (17):
  mac802154: main: remove unnecessary include
  mac802154: remove tab after define
  mac802154: add IEEE802154_HW_ARET hw flag
  mac802154: add hardware address filter flag
  mac802154: add support for promiscuous mode
  at86rf230: add support for promiscuous mode
  mac802154: separate omit tx/rx flags
  mac802154: rx: remove unnecessary parameter
  mac802154: rx: simplify crc receive handling
  mac802154: rx: add software checksum filtering check
  mac802154: rx: remove override pkt_type set to PACKET_HOST
  mac802154: rx: use netif_receive_skb
  mac802154: rx: add rx stats incrementation
  mac802154: rx: monitor receive cleanup
  mac802154: rx: add error handling after skb_clone
  at86rf230: deliver with checksum
  mac802154: add basic support for monitor

 drivers/net/ieee802154/at86rf230.c | 35 +++++++++++++++++++--
 drivers/net/ieee802154/cc2520.c    |  3 +-
 drivers/net/ieee802154/mrf24j40.c  |  3 +-
 include/net/mac802154.h            | 40 ++++++++++++++++++------
 net/mac802154/driver-ops.h         | 13 ++++++++
 net/mac802154/ieee802154_i.h       |  1 +
 net/mac802154/iface.c              | 12 ++++++-
 net/mac802154/main.c               |  1 -
 net/mac802154/rx.c                 | 64 +++++++++++++++++++++-----------------
 net/mac802154/tx.c                 |  2 +-
 10 files changed, 127 insertions(+), 47 deletions(-)

-- 
2.1.2

