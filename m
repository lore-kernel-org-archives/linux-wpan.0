Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60758 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751913AbcAYH67 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 25 Jan 2016 02:58:59 -0500
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCHv2 bluetooth-next 0/2] 6lowpan: stateful compression support
Date: Mon, 25 Jan 2016 08:58:53 +0100
Message-Id: <1453708735-29931-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de, mcr@sandelman.ca, lukasz.duda@nordicsemi.no, Alexander Aring <aar@pengutronix.de>

Hi,

this contains at first some small fix for the netdev notifier which I deteced
while hacking 6lowpan stateful compression support.

I rework the debugfs entry for the stateful compression. Now each context entry
for a 6LoWPAN contains has his own subdirectory (named as his CID value).
In this subdirectories there exists the following files for manipulating the
context entry:

 - active: If the context belongs to the table or not.
 - compression: the compression flag according rfc6775.
 - prefix: ipv6 prefix in xxxx:xxxx:....:xxxx form.
 - prefix_length: the length of the ipv6 prefix.

This offers a setting per property instead doing remember the full context and
doing echo "$FULL_CONTEXT_INFORMATION" > ctx_table.

These files should be prepared to move into the sysfs directory when it seems to
running fine.

There exist one file "show" inside $LOWPAN_IFACE/contexts/. This file is for
a "pretty-printout" for the current context table. I use the same format-string
like RIOT-OS, example:

cid|prefix                                     |C
-------------------------------------------------
  0|                                 2001::/64 |1
  1|                                2001::1/128|1
  2|                                2001::5/128|1
  7|                                 2002::/64 |1


difference here is that RIOT shows the lifetime, but I currently see no sense to
handle the lifetime in kernelspace.

Also I added support to clean the context table when doing a "ifdown". The reason
is that IPv6 interface will also drop all address information while doing a
ifdown and a 6LoWPAN should not use previous context information after ifup again.

- Alex

changes since v2:

- removes some unnecessary WARN_ONCE for parameter which can't be above of 15
  by masking with 0xf.
- remove some "!!" when function returns bool.
- change naming from compression flag to "compression" instead "C", but leave
  it in "show" as "C".
- change that "show" will display "compression" instead "active", reported by
  Lukasz Duda.
- remove comment about which was hard to understand. I removed it instead
  confuse other developers. It should describe that the compression flag
  indicates to use compression on tx side only if is set. contexts on receive
  will always be used.

Alexander Aring (2):
  6lowpan: iphc: add support for stateful compression
  ieee802154: 6lowpan: fix return of netdev notifier

 include/net/6lowpan.h         |  32 ++++
 net/6lowpan/core.c            |  39 +++-
 net/6lowpan/debugfs.c         | 247 +++++++++++++++++++++++++
 net/6lowpan/iphc.c            | 414 ++++++++++++++++++++++++++++++++++++------
 net/ieee802154/6lowpan/core.c |   7 +-
 5 files changed, 677 insertions(+), 62 deletions(-)

-- 
2.7.0

