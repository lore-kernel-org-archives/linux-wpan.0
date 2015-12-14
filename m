Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37324 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042AbbLNOB4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 14 Dec 2015 09:01:56 -0500
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFCv4 bluetooth-next 0/2] 6lowpan: 6co and stateful compression support
Date: Mon, 14 Dec 2015 15:00:52 +0100
Message-Id: <1450101654-22633-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, kernel@pengutronix.de, mcr@sandelman.ca, lukasz.duda@nordicsemi.no, martin.gergeleit@hs-rm.de, Alexander Aring <alex.aring@gmail.com>

Hi,

this patch series adds stateful compression support and add 6co option as a new
userspace option for processing RA messages inside userspace.

I am not sure if "6CO" handling inside userspace is the best option here.

I will send also "radvd" patches which introduce a very "basic" support for
processing(non 6LBR)/manage(6LBR) 6CO option fields. These patches doesn't
support lifetime handling of contexts. There exists the question as well if
we should handle the lifetime handling inside userspace or kernelspace.

I am currently follow this approach:
If we doesn't need it inside the kernelspace, then we should handle it in
userspace.

It's difficult to figure out if we really can it handle inside userspace only.

RFC6775 describes some different roles inside the network:

 - 6LN (6LoWPAN Node)
 - 6LR (Router inside 6LoWPAN network)
 - 6LBR ($IP_NETWORK <-> 6LoWPAN network)

Processing ICMPv6 (RA/RS, NA/NS) messages may be different for each role. I
currently have not the full overlook inside RFC6775 and sometimes (as example
of ABRO field, another Option-Field for 6LoWPAN) says:

8.1.3.  Routers Processing Router Advertisements
Note: (I suppose this is for 6LR only!)
If a received RA does not contain an ABRO, then the RA MUST be silently
ignored.

---

For my knowledge such handling need to be inside kernelspace. This is filter
functionality only, processing can be handled inside userspace (which needs ABRO
also as userspace option at first), but then the kernel need to know which "role
(6LN, 6LR, 6LBR)" the interface has.

- Alex

changes since v4:
 - remove patches for adding debugfs which are already upstream.
 - add "ipv6: add 6co as icmpv6 userspace option"
 - fix transmit check on (cid) instead (sci || dci) for adding CID inline
   data. If CID is zero it will be compressed.
 - remove "dci_table, sci_table, mcast_table" we have "ctx_table" only.
 - Change enabled with "u32 flags" since we need more information than
   "enabled" only. We handle also "compression flag" now.

Alexander Aring (2):
  6lowpan: iphc: add support for stateful compression
  ipv6: add 6co as icmpv6 userspace option

 include/net/6lowpan.h |  31 ++++
 include/net/ndisc.h   |   1 +
 net/6lowpan/core.c    |   6 +-
 net/6lowpan/debugfs.c |  97 ++++++++++++
 net/6lowpan/iphc.c    | 420 +++++++++++++++++++++++++++++++++++++++++++-------
 net/ipv6/ndisc.c      |   3 +-
 6 files changed, 499 insertions(+), 59 deletions(-)

-- 
2.6.1

