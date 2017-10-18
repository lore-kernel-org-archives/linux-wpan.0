Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14075 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932333AbdJRMGS (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 18 Oct 2017 08:06:18 -0400
From: Patrik Flykt <patrik.flykt@linux.intel.com>
Subject: [RFC 0/3] 6LoWPAN tun/tap device
Date: Wed, 18 Oct 2017 15:06:12 +0300
Message-Id: <20171018120615.24126-1-patrik.flykt@linux.intel.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org
Cc: luiz.von.dentz@intel.com


	Hi,

These patches aim at a bit different approach in handling IP over
Bluetooth Low Energy connections that what has been implemented in the
kernel so far. The goal is to lift the current L2CAP channel handling
into Bluez userspace with the following benefits:
 * Authorization agent can be used directly
 * Use common code to handle profiles/services
 * Async IO
 * No new sets of kernel APIs are needed

The essence of the change is to use a regular TUN/TAP interface
enhanced with 6LoWPAN header compression and decompression with Bluez
handling all other aspects of Bluetooth Low Energy connections. As the
kernel already contains a very capable 6LoWPAN implementation, it is
reused with the TUN/TAP driver providing appropriate IP interface
handling while sending the resulting 6LoWPAN compressed IP packets to
user space and Bluez that will send them further over BT LE L2CAP.
These changes are not bound to current BT LE IPSP implementation, other
upcoming BT LE profiles or other user space components can freely reuse
what is being presented here. Luiz will send the corresponding changes
for Bluez in a short while.

Patches 1/3 and 2/3 introduce no new functionality but only a trivial
transformation where the 6LoWPAN compression would take struct
lowpan_dev instead of the bigger struct net_device. The reason is to
decouple 6LoWPAN compression from the net_device itself, as the
intended TUN/TAP driver does not have any relation to 6LoWPAN link
types and the compression/decompression functionality is in essence a
library to produce the desired IP packet transformation.

Patch 3/3 introduces 6LoWPAN handling into the current tun.c driver by
adding a new IFF_6LO flag for turning the feature on and off.
Admittedly the features could be implemented better than it is right
now, the point is not to come up with the prettiest code but to
introduce the feature and then start discussing what the best option is
to implement such an interface variant - is it via such an IFF_6LO
flag, should a particular new type of BT LE 6LowPAN interface be
created, or can this be generalized to cover also 802.15.4 interfaces
although the 802.15.4 technology does not have anything corresponding
to the Bluez user space daemon.

Patches apply to bluetooth-next fac72b24 as of today.


Cheers,

	Patrik


Patrik Flykt (3):
  6lowpan: Use struct lowpan_dev instead of net_device
  6lowpan: Factor out lowpan device context initialization
  tun: Add 6LoWPAN compression/decompression to tun driver

 drivers/net/tun.c           |  61 +++++++++++++++++++++-
 include/net/6lowpan.h       |  10 ++--
 include/uapi/linux/if_tun.h |   1 +
 net/6lowpan/core.c          |  22 +++++---
 net/6lowpan/iphc.c          | 121 +++++++++++++++++++-------------------------
 net/6lowpan/nhc.c           |   8 +--
 net/6lowpan/nhc.h           |   2 +-
 net/bluetooth/6lowpan.c     |   6 ++-
 net/ieee802154/6lowpan/rx.c |   3 +-
 net/ieee802154/6lowpan/tx.c |   2 +-
 10 files changed, 147 insertions(+), 89 deletions(-)

-- 
2.11.0

