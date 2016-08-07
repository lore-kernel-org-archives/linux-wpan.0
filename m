Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49783 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751888AbcHGOdC (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Aug 2016 10:33:02 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFCv2 bluetooth-next 00/19] bluetooth: rework 6lowpan implementation
Date: Sun,  7 Aug 2016 16:30:37 +0200
Message-Id: <20160807143056.3116-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, Alexander Aring <aar@pengutronix.de>

Hi,

This patch series is my second RFC for making btle 6lowpan into the right
direction.

I added hopefully all suggestions which I got from RFCv1. The interface address
will be assigned when the first l2cap chan connection gets in. This device
address will be get by "hci_copy_identity_address" bluetooth API function and
I hope this is the right function to get the "RPA device address".

Checkout commit message of Patch 19/19 to see how I used it.

Bad news are, I will start my master thesis shortly so I am not able to work
on this patch series anymore.

- Alex

changes since v2:
 - Add patch "bluetooth: introduce l2cap chan priv data" to deal with private
   l2cap chan data when doing the final put, instead handling own heap
   allocation to do that.
 - remove patch "6lowpan: ndisc: don't remove short address" which was for
   802.15.4 handling only. It's mainline now.
 - following changes was done for new btle 6lowpan implementation:
    - Changing debugfs UAPI:
      - 6LoWPAN interface will be add/del on power on/off per hci dev. Depends
        on 6lowpan_enable is "1".
      - "6lowpan_control" is moved now to the hci debugfs entry and available
         if 6lowpan interface is also available only.
    - Setting device address is done when the first l2cap_chan connection comes
      in (ready callback). This will be done by hci_copy_identity_address and
      I hope this will be the RPA address. After first connection comes in
      the 6LoWPAN interface will came up.
      If last connection is lost, the device address will be 0...0.
      In general a device address of 0...0 indicates no connection and the
      interface can be set "up" while this.
    - Adding module_get/put to don't remove module while interfaces are
      there and other bug fixes.
    - Added TODO comment for multicast listener support.

Alexander Aring (19):
  ieee802154: 6lowpan: remove headroom check
  ieee802154: 6lowpan: move skb cb BUILD_BUG_ON check
  6lowpan: remove LOWPAN_IPHC_MAX_HEADER_LEN
  6lowpan: hold netdev while unregister
  6lowpan: introduce generic default naming
  6lowpan: move rx defines to generic
  bluetooth: introduce l2cap_hdev_chan_connect
  bluetooth: add hci dev notifier
  bluetooth: introduce l2cap chan priv data
  bluetooth: export functions and variables
  6lowpan: bluetooth: remove implementation
  ieee802154: 6lowpan: move header create to 6lowpan
  6lowpan: move dev_init to generic
  6lowpan: iphc: override l2 packet information
  ipv6: addrconf: fix 48 bit 6lowpan autoconfiguration
  6lowpan: iphc: add handling for btle
  6lowpan: move multicast flags to generic
  6lowpan: move addr_len setting away from generic
  6lowpan: bluetooth: add new implementation

 include/net/6lowpan.h              |   30 +-
 include/net/bluetooth/hci_core.h   |    8 +
 include/net/bluetooth/l2cap.h      |    7 +
 net/6lowpan/core.c                 |   47 +-
 net/6lowpan/iphc.c                 |  111 +++
 net/bluetooth/6lowpan.c            | 1707 +++++++++++++-----------------------
 net/bluetooth/hci_core.c           |   24 +
 net/bluetooth/hci_sock.c           |    2 +
 net/bluetooth/l2cap_core.c         |   50 +-
 net/ieee802154/6lowpan/6lowpan_i.h |    9 -
 net/ieee802154/6lowpan/core.c      |   23 +-
 net/ieee802154/6lowpan/tx.c        |   94 +-
 net/ipv6/addrconf.c                |   19 +-
 13 files changed, 922 insertions(+), 1209 deletions(-)

-- 
2.9.2

