Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:50245 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbaKETwH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 5 Nov 2014 14:52:07 -0500
Received: by mail-wi0-f178.google.com with SMTP id bs8so1075283wib.11
        for <linux-wpan@vger.kernel.org>; Wed, 05 Nov 2014 11:52:05 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 00/18] ieee802154: interface registration and perm address support
Date: Wed,  5 Nov 2014 20:51:11 +0100
Message-Id: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Varka Bhadram <varkabhadram@gmail.com>

This patch series contains various changes to make the 802.15.4 implementation
similar like wireless/mac80211 implementation. Mainly changes are a complete
rework for interface registration handling and supporting for perm address.
The perm address can be set by driver layer and is the default "unique"
extended address for the wpan_phy. Also we have now a default interface
registration. This means a driver registrate a default wpan interface while
registration the wpan_phy. No extra interface add handling via userspace tool is
needed anymore.

Cc: Varka Bhadram <varkabhadram@gmail.com>

Alexander Aring (18):
  ieee802154: rework wpan_phy index assignment
  ieee802154: remove nl802154 unused functions
  mac802154: move interface del handling in iface
  mac802154: move interface add handling in iface
  mac802154: move dev_hold out of ieee802154_if_add
  ieee802154: rework interface registration
  ieee802154: remove mlme get_phy callback
  mac802154: add default interface registration
  mac802154: add ieee802154_vif struct
  ieee802154: add IEEE802154_EXTENDED_ADDR_LEN
  ieee802154: add ieee802154_random_extended_addr
  mac802154: add ieee802154_le64_to_be64
  mac802154: cleanup ieee802154_netdev_to_extended_addr
  mac802154: add support for perm_extended_addr
  at86rf230: generate random perm extended address
  at86rf230: add force slotted operation bit
  mac802154: use IEEE802154_EXTENDED_ADDR_LEN
  mac802154: fix typo promisuous to promiscuous

 MAINTAINERS                        |   1 -
 drivers/net/ieee802154/at86rf230.c |  10 ++
 drivers/net/ieee802154/cc2520.c    |   1 +
 include/linux/ieee802154.h         |  16 +++
 include/net/cfg802154.h            |   7 +-
 include/net/ieee802154_netdev.h    |  12 ---
 include/net/mac802154.h            |  32 +++++-
 include/net/nl802154.h             | 122 -----------------------
 net/ieee802154/6lowpan_rtnl.c      |   8 --
 net/ieee802154/core.c              |  30 +++---
 net/ieee802154/core.h              |   3 +
 net/ieee802154/nl-mac.c            | 193 ++-----------------------------------
 net/ieee802154/nl-phy.c            |   4 +-
 net/mac802154/cfg.c                |  14 ++-
 net/mac802154/ieee802154_i.h       |  14 ++-
 net/mac802154/iface.c              | 148 +++++++++++++++++++++-------
 net/mac802154/mac_cmd.c            |  20 ----
 net/mac802154/main.c               |  95 +++---------------
 net/mac802154/rx.c                 |   4 +-
 19 files changed, 237 insertions(+), 497 deletions(-)
 delete mode 100644 include/net/nl802154.h

-- 
2.1.3

