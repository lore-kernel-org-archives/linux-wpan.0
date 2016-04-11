Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:32913 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752904AbcDKJE2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 11 Apr 2016 05:04:28 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH bluetooth-next 00/11] 6lowpan: prepare for 6lowpan ndisc implementation
Date: Mon, 11 Apr 2016 11:04:13 +0200
Message-Id: <1460365464-12435-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, Alexander Aring <aar@pengutronix.de>

Hi,

this patch series are taken from the pending RFCv2 about
"6lowpan: l2 neighbour data and short address" which are 802.15.4/6lowpan
subsystem related.

If these patches are fine and are mainline on bluetooth-next, I will try to
bring the rest of patches mainline.

- Alex

Alexander Aring (11):
  ieee802154: cleanups for ieee802154.h
  ieee802154: add short address helpers
  nl802154: avoid address change while running lowpan
  ieee802154: 6lowpan: fix short addr hash
  6lowpan: change naming for lowpan private data
  6lowpan: move lowpan_802154_dev to 6lowpan
  6lowpan: iphc: rename add lowpan prefix
  6lowpan: iphc: remove unnecessary zero data
  6lowpan: move eui64 uncompress function
  6lowpan: add lowpan_is_ll function
  6lowpan: move mac802154 header

 include/linux/ieee802154.h         |  35 +++++++++++-
 include/net/6lowpan.h              |  37 ++++++++++++-
 include/net/mac802154.h            |  10 ++++
 net/6lowpan/6lowpan_i.h            |   9 +++
 net/6lowpan/core.c                 |   8 +--
 net/6lowpan/debugfs.c              |  22 ++++----
 net/6lowpan/iphc.c                 | 111 ++++++++++++++++---------------------
 net/6lowpan/nhc_udp.c              |   2 +-
 net/bluetooth/6lowpan.c            |  82 ++++++++++++++-------------
 net/ieee802154/6lowpan/6lowpan_i.h |  14 +----
 net/ieee802154/6lowpan/core.c      |   6 +-
 net/ieee802154/6lowpan/tx.c        |  14 ++---
 net/ieee802154/nl802154.c          |  10 ++++
 13 files changed, 214 insertions(+), 146 deletions(-)

-- 
2.8.0

