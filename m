Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:56402 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632AbaJ0QOJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Oct 2014 12:14:09 -0400
Received: by mail-wg0-f46.google.com with SMTP id x13so1701899wgg.29
        for <linux-wpan@vger.kernel.org>; Mon, 27 Oct 2014 09:14:07 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 00/16] ieee802154: rework receive handling
Date: Mon, 27 Oct 2014 17:13:27 +0100
Message-Id: <1414426423-24856-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch serie improves and cleanups the receive handling.
Instead workqueue we use a tasklet now for parsing frames.
The first patch is a fix for using put_unaligned_le16 to copy
checksum in skb data which was reported by Marcel Holtmann.

Other patches are cleanups for preparing further patches to
introduce a frame parsing like mac80211. We don't change
the printout function to netdev_foo now because the most
code will be replaced by the new frame parsing implementation.

changes since v2:
 - correct ieee802154 instead ieee80211 in patch 04/16 ("mac802154: rx:
   document ieee802154_rx() context requirement")
 - reword complete commit message of patch 04/16 ("mac802154: rx: document
   ieee802154_rx() context requirement")
 - fix && instead || in patch 13/16 ("ieee802154: add valid psdu length helper")
 - make patch 13/16 ("ieee802154: add valid psdu length helper") more human
   readable to check start at first end then end interval. Instead end <-> start
   checking.

Alexander Aring (16):
  mac802154: tx: use put_unaligned_le16 for copy crc
  ieee802154: drivers: use dev_alloc_skb
  mac802154: rx: use tasklet instead workqueue
  mac802154: rx: document ieee802154_rx() context requirement
  mac802154: rx: move receive handling into rx.c
  mac802154: tx: remove monitor receive while xmit
  mac802154: rx: rename remove mac802154_subif_rx
  mac802154: rx: move skb->protocol setting
  mac802154: rx: add CHECKSUM_UNNECESSARY
  mac802154: rx: add monitor pkt_type information
  mac802154: rx: move skb_reset_mac_header
  mac802154: rx: move rcu locking
  ieee802154: add valid psdu length helper
  at86rf230: use ieee802154_is_valid_psdu_len helper
  at86rf230: improve receive handling
  mac802154: rx: change naming convention

 drivers/net/ieee802154/at86rf230.c |  32 ++---
 drivers/net/ieee802154/cc2520.c    |   2 +-
 drivers/net/ieee802154/mrf24j40.c  |   2 +-
 include/linux/ieee802154.h         |  11 ++
 include/net/mac802154.h            |   1 +
 net/mac802154/ieee802154_i.h       |   9 +-
 net/mac802154/iface.c              | 186 -------------------------
 net/mac802154/main.c               |  30 ++++
 net/mac802154/monitor.c            |  27 ----
 net/mac802154/rx.c                 | 279 +++++++++++++++++++++++++++++++------
 net/mac802154/tx.c                 |   7 +-
 11 files changed, 296 insertions(+), 290 deletions(-)

-- 
2.1.2

