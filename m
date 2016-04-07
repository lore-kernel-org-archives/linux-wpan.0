Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50665 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757346AbcDGSyc (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 7 Apr 2016 14:54:32 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFCv2 bluetooth-next 00/21] 6lowpan: l2 neighbour data and short address
Date: Thu,  7 Apr 2016 20:54:01 +0200
Message-Id: <1460055262-4330-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, Alexander Aring <aar@pengutronix.de>

Hi,

this patch series introduces a private neighbour dataroom for 6LoWPAN
interfaces. The first use case for such private neighbour data is short
address handling for 802.15.4 6LoWPAN networks.

This private data can also be useful for other upcomming 6lowpan handling,
which need to be stored inside each neighbour for IPv6 (6LoWPAN) neighbour
discovery.

The patch series introduces a generic 6LoWPAN specific neighbour private data
(which is currently emtpy) and an additional linklayer specific neighbour
private data. This linklayer data will be used by 802.15.4 to adding short
address handling.

Future work for generic 6LoWPAN (net/6lowpan) branch will introduce some
additional callbacks for handle generic 6lowpan neighbour private data.
e.g. 6LoWPAN Capability Indication Option [0].


Note:

I have no glue if the short address handling is RFC compliant.

How it works currently is that the short address is an optional address option
inside of NA/NS (of course we need also the address option in RS). It will not
work when an extended address option isn't there. In my opinion an extended
address field is always there because this address is always available.

If I am wrong, then we need to add some dummy extended addr (maybe all
zero-extended, but "ip -6 neigh will be look somewhat wrong then. :-) ).
We currently doesn't accept a NA/NS which don't has the extended address
inside the option fields.

If there exists a valid source address on the link, then extended address and
short address will be added to the option. The length field inside the option
field will be indicated if extended or short, see [2]. In case no valid source
address is there, then the extended address option will be added.


Another 6LoWPAN stack RIOT will do a complete different handling here:
It add extended address XOR short address to the NS/NA messages, depends on
configuration. It also drops NS/NA messages which contains two address options.
So I can't test it, I don't know which way is the correct way, if RIOT do it
right then I think we don't need to have a private data for each neighbour,
because we can handle dev->addr as extended or short then, but I think RIOT
is wrong here.

Future handling of this patch series:

I will try to get at first the 802.15.4/6LoWPAN stuff mainline which doesn't
include the ipv6/ndisc changes.

- Alex

[0] https://tools.ietf.org/html/rfc7400
[1] https://tools.ietf.org/html/rfc6775
[2] https://tools.ietf.org/html/rfc4944#section-8

changes since v2:
 - Introduce ndisc_ops to have our own implementation for dealing with NS/NA
   which allows also to support RFC6775 (e.g. ARO).
 - add handling for handling 6CO as userspace option for RA messages in
   case of 6LoWPAN interfaces.
 - change lowpan_is_ll to check on linklayer type only.
 - added some reviewed-by's.
 - move short addr slaac to net/6lowpan instead ipv6 handling.
 - add handling for context based address compression in case for
   short address as link-layer address.
 - change strategy to use short address, a short address will always be used
   when it's available.
 - Handle override flag in NA messages to update short address information or
   not.

Alexander Aring (21):
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
  6lowpan: add private neighbour data
  6lowpan: add 802.15.4 short addr slaac
  6lowpan: remove ipv6 module request
  ndisc: add addr_len parameter to ndisc_opt_addr_space
  ndisc: add addr_len parameter to ndisc_opt_addr_data
  ndisc: add addr_len parameter to ndisc_fill_addr_option
  ipv6: introduce neighbour discovery ops
  ipv6: export ndisc functions
  6lowpan: introduce 6lowpan-nd
  6lowpan: add support for 802.15.4 short addr handling

 include/linux/ieee802154.h         |  35 +-
 include/linux/netdevice.h          |   6 +-
 include/net/6lowpan.h              |  61 +++-
 include/net/addrconf.h             |   3 +
 include/net/mac802154.h            |  10 +
 include/net/ndisc.h                | 101 +++++-
 net/6lowpan/6lowpan_i.h            |  11 +
 net/6lowpan/Makefile               |   2 +-
 net/6lowpan/core.c                 |  58 +++-
 net/6lowpan/debugfs.c              |  22 +-
 net/6lowpan/iphc.c                 | 278 ++++++++++------
 net/6lowpan/ndisc.c                | 631 +++++++++++++++++++++++++++++++++++++
 net/6lowpan/nhc_udp.c              |   2 +-
 net/bluetooth/6lowpan.c            |  84 ++---
 net/ieee802154/6lowpan/6lowpan_i.h |  14 +-
 net/ieee802154/6lowpan/core.c      |  18 +-
 net/ieee802154/6lowpan/tx.c        | 117 ++++---
 net/ieee802154/nl802154.c          |  10 +
 net/ipv6/addrconf.c                |   7 +-
 net/ipv6/ndisc.c                   | 132 +++++---
 net/ipv6/route.c                   |   4 +-
 21 files changed, 1304 insertions(+), 302 deletions(-)
 create mode 100644 net/6lowpan/ndisc.c

-- 
2.8.0

