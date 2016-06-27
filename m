Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:39769 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751905AbcF0WAn (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 27 Jun 2016 18:00:43 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCHv2 bluetooth-next 0/8] ieee802154: pending/new fixes and cleanup/features
Date: Tue, 28 Jun 2016 00:00:29 +0200
Message-Id: <20160627220037.10108-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <aar@pengutronix.de>

Hi,

I currently work on running the RIOT-OS stack in userspace stuff. At first
for a testing use-case. While working on that I detected the intra-pan
addressing behaviour and non-monitors on fakelb.

I recently posted the first 4 patches and the atusb one. I simple put
them now into one patch-series and added Stefan's suggestion, but still
not use if these pointer helpers on mac headers are okay for lowlevel
functionality.

- Alex

changes since v2:
 - Add new patch [5/8] 6lowpan: ndisc: set invalid unicast short addr to unspec
 - Add new patch [8/8] fakelb: allow to run as monitor.
 - split WARN_ON cleanup from "ieee802154: fix skb get fc on big endian" into
   new separate [7/8] ieee802154: cleanup WARN_ON for fc fetch.
 - add missing pan_id check in case of non intra-pan and dadder available for
   ieee802154_skb_src_pan function.
 - add fix for atusb csma setting which isn't mainline yet.

Alexander Aring (8):
  ieee802154: add ieee802154_skb_dst_pan helper
  ieee802154: add ieee802154_skb_src_pan helper
  ieee802154: 6lowpan: fix intra pan id check
  ieee802154: fix skb get fc on big endian
  6lowpan: ndisc: set invalid unicast short addr to unspec
  atusb: don't change csma settings while set channel
  ieee802154: cleanup WARN_ON for fc fetch
  fakelb: allow to run as monitor

 drivers/net/ieee802154/atusb.c  |   6 +--
 drivers/net/ieee802154/fakelb.c |   8 +++
 include/linux/ieee802154.h      |  29 +++++++++++
 include/net/mac802154.h         | 108 ++++++++++++++++++++++++++++++++++++++--
 net/6lowpan/ndisc.c             |   7 ++-
 net/ieee802154/6lowpan/rx.c     |   2 +-
 6 files changed, 148 insertions(+), 12 deletions(-)

-- 
2.9.0

