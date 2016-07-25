Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54335 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751648AbcGYMPD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 25 Jul 2016 08:15:03 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC bluetooth-next 0/4] ieee802154: remove deprecated UAPI
Date: Mon, 25 Jul 2016 14:14:46 +0200
Message-Id: <20160725121450.4093-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <aar@pengutronix.de>

Hi,

this patch series removes the deprecated UAPI which is:

 - RAW socket -> get replaced by AF_PACKET raw
 - ioctl -> get replaced by nl802154
 - old netlink api

---

The first point, it's broken since "I don't know" it's not really a RAW socket.
It's now replaced by AF_PACKET RAW socket.

For 802.15.4 sockets we need anyway at least some DGRAM socket only to handle
mac frames.

---

The ioctl was introduced with a "dev_warn" that somebody should not use ioctl.
I don't know why, but it's for me similar like debugfs when users get such
warning for a ioctl.

Also I don't know if it's really working if we override such ioctl for own
meaning, I would assume that such ioctl should use some private ioctl request
room and not the usually common where other userspace applications assume a
raw byte array and not a struct.

---

The last one is the old netlink api, there still coming fixes to the
mailinglist. Also since net namespace support this netlink interface gets more
and more broken, because it doesn't know anything about namespaces. I think
it's not broken but you need to use nl802154 for that and the old netlink
interface will simple not handle different namespaces e.g. dump interface). It
assumes that every interface is inside "&init_net". Also it doesn't allow me
to work on llsec more without keeping care about not breaking this UAPI and I
don't have any "useable" userspace utility to testing everything which is
related to that netlink API.

- Alex

Alexander Aring (4):
  ieee802154: socket: remove af802154 raw socket
  mac802154: keep Makefile sync with mac80211
  ieee802154: remove old netlink api
  mac802154: iface: remove ioctl functionality

 include/net/cfg802154.h         |    6 -
 include/net/ieee802154_netdev.h |   38 --
 net/ieee802154/Makefile         |    3 +-
 net/ieee802154/core.c           |   57 +-
 net/ieee802154/ieee802154.h     |   86 ---
 net/ieee802154/netlink.c        |  152 -----
 net/ieee802154/nl-mac.c         | 1349 ---------------------------------------
 net/ieee802154/nl-phy.c         |  349 ----------
 net/ieee802154/nl_policy.c      |   78 ---
 net/ieee802154/rdev-ops.h       |   17 -
 net/ieee802154/socket.c         |  277 +-------
 net/mac802154/Makefile          |   13 +-
 net/mac802154/cfg.c             |   26 -
 net/mac802154/iface.c           |   86 +--
 net/mac802154/mac_cmd.c         |  152 -----
 net/mac802154/mib.c             |  227 -------
 16 files changed, 21 insertions(+), 2895 deletions(-)
 delete mode 100644 net/ieee802154/ieee802154.h
 delete mode 100644 net/ieee802154/netlink.c
 delete mode 100644 net/ieee802154/nl-mac.c
 delete mode 100644 net/ieee802154/nl-phy.c
 delete mode 100644 net/ieee802154/nl_policy.c
 delete mode 100644 net/mac802154/mac_cmd.c
 delete mode 100644 net/mac802154/mib.c

-- 
2.9.0

