Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:34553 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbbEQTpc (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 17 May 2015 15:45:32 -0400
Received: by wguv19 with SMTP id v19so104436975wgu.1
        for <linux-wpan@vger.kernel.org>; Sun, 17 May 2015 12:45:31 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 00/34] ieee802154: capabilities, atusb support and fakelb rework
Date: Sun, 17 May 2015 21:44:36 +0200
Message-Id: <1431891910-32231-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, Alexander Aring <alex.aring@gmail.com>

Hi Marcel,

this patch series contains mainly the following changes:

 - add support for phy capabilities
 - add support for atusb transceiver
 - rework fakelb driver implementation

Some of them patches was already send to wpan mailinglist, I did few
changes. These are:

 - add "atusb" prefix in some of the static function in atusb driver
 - a cleanup which move dev_consume_skb_any(skb) out of if and else
   branch. It's just called always, before it the call was in the
   if and else branch. See patch ("mac802154: tx: allow xmit complete
   from hard irq")
 - fix typo s/serveral/several in patch ("fakelb: cleanup code")

This patch series does _not_ include the mib/pib locks removal and
atomic_t for the data/beacon sequence number. These patches depends
on another patch ("mac802154: fix hold rtnl while ioctl") which should
go into bluetooth. I will send in the next days a patch series for bluetooth
which contains the ("mac802154: fix hold rtnl while ioctl") patch. If I seeing
this patch inside of bluetooth-next then I will send the mib/pib locks removal
and atomic_t for the data/beacon sequence number again for bluetooth-next.
Please let me know if this handling is fine. I think this avoids some merge
conflicts then.

Thanks.

- Alex

Alexander Aring (33):
  nl802154: cleanup invalid argument handling
  ieee802154: move validation check out of softmac
  ieee802154: change transmit power to s32
  ieee802154: change transmit power to mbm
  ieee802154: change cca ed level to mbm
  ieee802154: introduce wpan_phy_supported
  ieee802154: add several phy supported handling
  mac802154: check for really changes
  mac802154: remove check if operation is supported
  cfg802154: introduce wpan phy flags
  ieee802154: add iftypes capability
  at86rf230: set cca_modes supported flags
  at86rf230: rework tx power support
  at86rf230: rework tx cca energy detection level
  at86rf230: add cca ed level reset value
  at86rf230: add reset states of tx power level
  nl802154: add support for dump phy capabilities
  at86rf230: fix callback for aret handling
  mac802154: tx: allow xmit complete from hard irq
  ieee802154: add support for atusb transceiver
  fakelb: creating two virtual phys per default
  fakelb: use list_for_each_entry_safe
  fakelb: rename fakelb_dev_priv to fakelb_phy
  fakelb: don't deliver when one phy
  fakelb: declare rwlock static
  fakelb: declare fakelb list static
  fakelb: move lock out of iteration
  fakelb: introduce fakelb ifup phys list
  fakelb: use own channel and page attributes
  fakelb: add virtual phy reset defaults
  fakelb: remove fakelb_hw_deliver
  fakelb: add support for async xmit handling
  fakelb: cleanup code

Martin Townsend (1):
  mac802154: fakelb: Fix potential NULL pointer dereference.

 drivers/net/ieee802154/Kconfig     |  10 +
 drivers/net/ieee802154/Makefile    |   1 +
 drivers/net/ieee802154/at86rf230.c | 376 ++++++++------------
 drivers/net/ieee802154/at86rf230.h | 220 ++++++++++++
 drivers/net/ieee802154/atusb.c     | 692 +++++++++++++++++++++++++++++++++++++
 drivers/net/ieee802154/atusb.h     |  84 +++++
 drivers/net/ieee802154/cc2520.c    |   2 +-
 drivers/net/ieee802154/fakelb.c    | 209 +++++------
 drivers/net/ieee802154/mrf24j40.c  |   2 +-
 include/net/cfg802154.h            |  62 +++-
 include/net/mac802154.h            |  38 +-
 include/net/nl802154.h             |  79 +++++
 net/ieee802154/nl-mac.c            |   8 +-
 net/ieee802154/nl-phy.c            |   4 +-
 net/ieee802154/nl802154.c          | 209 +++++++++--
 net/mac802154/cfg.c                |  63 +---
 net/mac802154/driver-ops.h         |   8 +-
 net/mac802154/mac_cmd.c            |   6 +-
 net/mac802154/main.c               |  32 ++
 net/mac802154/util.c               |   5 +-
 20 files changed, 1639 insertions(+), 471 deletions(-)
 create mode 100644 drivers/net/ieee802154/at86rf230.h
 create mode 100644 drivers/net/ieee802154/atusb.c
 create mode 100644 drivers/net/ieee802154/atusb.h

-- 
2.3.7

