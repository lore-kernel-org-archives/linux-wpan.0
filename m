Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:57618 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbaJYSdV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 25 Oct 2014 14:33:21 -0400
Received: by mail-lb0-f169.google.com with SMTP id 10so4007045lbg.28
        for <linux-wpan@vger.kernel.org>; Sat, 25 Oct 2014 11:33:19 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 0/7] ieee802154: file movements
Date: Sat, 25 Oct 2014 09:40:58 +0200
Message-Id: <1414222865-1692-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This series contains file movements patches inside the 802.15.4 subsystem.
The series contains necessary movements to get a similar architecture like
mac80211 and wireless subsystem.

changes since v2:
 - rename mutal inclusion define while moving ieee802154 header to
   include/linux/. From NET_IEEE802154_H to LINUX_IEEE802154_H.

Alexander Aring (7):
  mac802154: move ieee802154_dev.c to main.c
  mac802154: move mac802154.h to ieee802154_i.h
  mac802154: move wpan.c to iface.c
  ieee802154: move wpan-phy.h to cfg802154.h
  ieee802154: move wpan-class.c to core.c
  ieee802154: move ieee802154 header
  MAINTAINERS: add missing headers in 802.15.4

 MAINTAINERS                                   | 7 +++++++
 drivers/net/ieee802154/at86rf230.c            | 4 ++--
 drivers/net/ieee802154/cc2520.c               | 4 ++--
 drivers/net/ieee802154/fakehard.c             | 4 ++--
 drivers/net/ieee802154/fakelb.c               | 2 +-
 drivers/net/ieee802154/mrf24j40.c             | 4 ++--
 include/{net => linux}/ieee802154.h           | 8 +++-----
 include/net/{wpan-phy.h => cfg802154.h}       | 7 ++++---
 include/net/ieee802154_netdev.h               | 2 +-
 net/ieee802154/6lowpan_rtnl.c                 | 2 +-
 net/ieee802154/Makefile                       | 2 +-
 net/ieee802154/{wpan-class.c => core.c}       | 2 +-
 net/ieee802154/dgram.c                        | 2 +-
 net/ieee802154/header_ops.c                   | 3 ++-
 net/ieee802154/nl-mac.c                       | 4 ++--
 net/ieee802154/nl-phy.c                       | 2 +-
 net/mac802154/Makefile                        | 4 ++--
 net/mac802154/{mac802154.h => ieee802154_i.h} | 6 +++---
 net/mac802154/{wpan.c => iface.c}             | 6 +++---
 net/mac802154/llsec.c                         | 4 ++--
 net/mac802154/mac_cmd.c                       | 6 +++---
 net/mac802154/{ieee802154_dev.c => main.c}    | 4 ++--
 net/mac802154/mib.c                           | 4 ++--
 net/mac802154/monitor.c                       | 6 +++---
 net/mac802154/rx.c                            | 2 +-
 net/mac802154/tx.c                            | 4 ++--
 26 files changed, 56 insertions(+), 49 deletions(-)
 rename include/{net => linux}/ieee802154.h (98%)
 rename include/net/{wpan-phy.h => cfg802154.h} (97%)
 rename net/ieee802154/{wpan-class.c => core.c} (99%)
 rename net/mac802154/{mac802154.h => ieee802154_i.h} (98%)
 rename net/mac802154/{wpan.c => iface.c} (99%)
 rename net/mac802154/{ieee802154_dev.c => main.c} (99%)

-- 
2.1.2

