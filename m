Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:45283 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756367AbbAIPnJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 9 Jan 2015 10:43:09 -0500
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv5 bluetooth-next 0/3] 6lowpan: introduce nhc framework
Date: Fri,  9 Jan 2015 16:42:56 +0100
Message-Id: <1420818179-18585-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, Martin Townsend <mtownsend1973@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, Stefan Schmidt <s.schmidt@samsung.com>

This patch series introduce the next header compression framework. Currently
we support udp compression/uncompression only. This framework allow to add new
next header compression formats easily.

If somebody wants to add a new header compression format and some information
are missing while calling compression and uncompression callbacks. Please
feel free to make framework changes according these callbacks.

changes since v2:
 - make udp nhc as module as suggested by Marcel Holtmann
 - fix comment header in nhc_udp.c

I didn't make the lowpan_nhc declaration "const" because this will occur
issues with rb_node, id and idmask array. Which will manipulated during
runtime.

changes since v3:
 - add patch 3/3 for other known rfc6282 ipv6 extension headers compression
   formats
 - add request_modules for loading nhc default compression format modules.
   Which was suggested by Jukka Rissanen. Thanks, this is really working.
 - Add rtnl_lock for lowpan_nhc_add and del since we have no synced
   request_modules call this could make trouble.
 - Move some handling out of nhc_do_compression and uncompression function.
   The complete handling is now inside of iphc.c and nhc_do_compression and
   uncompression functions is only a wrapper call for the callback.
 - rework some menuentries for Kconfig and compression format, they are
   grouped by rfc now.
 - move some generic handling like "skb_pull(skb, nhc->nexthdrlen);" into
   iphc.c. It would be great if we have something also for uncompression
   for the skb_cow. But this isn't possible right now.
 - change warning if nhc was not found to "was not found" instead isn't
   implemented. It isn't implemented if callbacks are NULL now.
 - small cleanups.

changes since v4:
 - add spinlock for to prevent nhc from deletion while using. This can occur
   if nhc module is unloading while compression/uncompression.
 - move nhc handling for nhc compression/uncompression completely into
   nhc_do_compression/nhc_do_uncompression.

Note about locking:

We have now a spinlock nhc_lowpan_lock which prevents manipulating the nhc
datastructures while using it. On receiving side it's easy to handle, at the
end we check if 6lowpan nh compressed flag is set and run uncompression.
On the other hand the transmit side is complicated, we check if next_hdr field
is registrated and run some other compression routines, at least we do the
finally nhc compression which depends on the first check if next_hdr was
registrated. The kernel will crash if we remove the using module between
"next_hdr check" and "do nhc compression", the lock will prevent that now.

Now in the transmit path exist a little window to remove a lowpan_nhc while
compression. This is exactly the part between "check if we support" and
"doing compression". This is a very unlikely case, if this occurs we drop
the packet while compression. Don't know how to better deal with that right
now. I will try to search a better solution later.

changes since v5:
 - s/rfc6282// on filenames and kconfig entries, suggested by Marcel Holtmann
   and Stefan Schmidt
 - s/FRAG/FRAGMENT/ - suggested by Stefan Schmidt
 - s/MOBIL/MOBILITY/ - suggested by Stefan Schmidt
 - s/ROUTE/ROUTING/ - suggested by Stefan Schmidt
 - replace "depends on 6LOWPAN_NHC" with a global "if 6LOWPAN_NHC
   $LOT_OF_ENTRIES endif" inside net/6lowpan/Kconfig
 - fix small typo "nhc" -> "nhcs" in net/6lowpan/Makefile
 - add MODULE_DESCRIPTION to each NHC module

Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Stefan Schmidt <s.schmidt@samsung.com>

Alexander Aring (3):
  6lowpan: add generic nhc layer interface
  6lowpan: add udp compression via nhc layer
  6lowpan: nhc: add other known rfc6282 compressions

 net/6lowpan/Kconfig        |  57 ++++++++++-
 net/6lowpan/Makefile       |  13 ++-
 net/6lowpan/iphc.c         | 200 ++++++-------------------------------
 net/6lowpan/nhc.c          | 241 +++++++++++++++++++++++++++++++++++++++++++++
 net/6lowpan/nhc.h          | 146 +++++++++++++++++++++++++++
 net/6lowpan/nhc_dest.c     |  28 ++++++
 net/6lowpan/nhc_fragment.c |  27 +++++
 net/6lowpan/nhc_hop.c      |  27 +++++
 net/6lowpan/nhc_ipv6.c     |  27 +++++
 net/6lowpan/nhc_mobility.c |  27 +++++
 net/6lowpan/nhc_routing.c  |  27 +++++
 net/6lowpan/nhc_udp.c      | 157 +++++++++++++++++++++++++++++
 12 files changed, 806 insertions(+), 171 deletions(-)
 create mode 100644 net/6lowpan/nhc.c
 create mode 100644 net/6lowpan/nhc.h
 create mode 100644 net/6lowpan/nhc_dest.c
 create mode 100644 net/6lowpan/nhc_fragment.c
 create mode 100644 net/6lowpan/nhc_hop.c
 create mode 100644 net/6lowpan/nhc_ipv6.c
 create mode 100644 net/6lowpan/nhc_mobility.c
 create mode 100644 net/6lowpan/nhc_routing.c
 create mode 100644 net/6lowpan/nhc_udp.c

-- 
2.2.1

