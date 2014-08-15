Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:59291 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbaHOKaB (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 15 Aug 2014 06:30:01 -0400
Received: by mail-wi0-f177.google.com with SMTP id ho1so642612wib.4
        for <linux-wpan@vger.kernel.org>; Fri, 15 Aug 2014 03:30:00 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Date: Fri, 15 Aug 2014 12:29:40 +0200
Message-Id: <1408098592-13412-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH wpan-next 00/12] ieee802154: mac802154: wireless transformation part 3
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Hi, this is the next series which do mainly a rework of xmit path. Also
dropping some kmalloc's from hotpath and remove the channel hopping feature.

We provide now async xmit and the the at86rf230 is the only one mainline driver
which supports that for now.

Next things are still frame parsing like 80211 and registration of phy's and
interfaces like 80211.

I need to look which is the best to work on the next series.

It's still available on [0], which is my working branch for the mac rework.

- Alex

[0] https://github.com/linux-wpan/linux-wpan-next/commits/wpan_rework_rfc

Alexander Aring (12):
  mac802154: tx: move xmit callback to tx file
  mac802154: make struct ieee802154_ops const
  mac802154: add netdev qeue helpers
  mac802154: tx: remove kmalloc in xmit hotpath
  mac802154: tx: remove xmit channel context switch
  mac802154: tx: add drv_xmit to driver-ops
  mac802154: tx: fix error handling on xmit
  mac802154: tx: add support for async xmit callback
  at86rf230: asynchrous xmit handling
  ieee802154: add valid frame length helper
  at86rf230: use ieee802154_is_valid_frame_len
  at86rf230: improve receive handling

 drivers/net/ieee802154/at86rf230.c |  64 +++++++--------------
 drivers/net/ieee802154/cc2520.c    |   4 +-
 drivers/net/ieee802154/mrf24j40.c  |   4 +-
 include/net/ieee802154.h           |  10 +++-
 include/net/mac802154.h            |  15 ++++-
 net/mac802154/Makefile             |   2 +-
 net/mac802154/driver-ops.h         |  12 ++++
 net/mac802154/ieee802154_i.h       |   6 +-
 net/mac802154/iface.c              |  33 -----------
 net/mac802154/main.c               |   6 +-
 net/mac802154/tx.c                 | 114 ++++++++++++++++++-------------------
 net/mac802154/util.c               |  55 ++++++++++++++++++
 12 files changed, 177 insertions(+), 148 deletions(-)
 create mode 100644 net/mac802154/util.c

-- 
2.0.3

