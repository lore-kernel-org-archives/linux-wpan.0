Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:54819 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932209AbaLHPvp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 8 Dec 2014 10:51:45 -0500
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv3 bluetooth-next 0/3] 6lowpan: introduce nhc framework
Date: Mon,  8 Dec 2014 16:50:35 +0100
Message-Id: <1418053838-8692-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, Martin Townsend <mtownsend1973@gmail.com>, Marcel Holtmann <marcel@holtmann.org>

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

Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>

Alexander Aring (3):
  6lowpan: add generic nhc layer interface
  6lowpan: add udp compression via nhc layer
  6lowpan: nhc: add other known rfc6282 compressions

 net/6lowpan/Kconfig             |  60 ++++++++++-
 net/6lowpan/Makefile            |  13 ++-
 net/6lowpan/iphc.c              | 223 +++++++++++-----------------------------
 net/6lowpan/nhc.c               | 140 +++++++++++++++++++++++++
 net/6lowpan/nhc.h               | 142 +++++++++++++++++++++++++
 net/6lowpan/nhc_rfc6282_dest.c  |  27 +++++
 net/6lowpan/nhc_rfc6282_frag.c  |  26 +++++
 net/6lowpan/nhc_rfc6282_hop.c   |  26 +++++
 net/6lowpan/nhc_rfc6282_ipv6.c  |  26 +++++
 net/6lowpan/nhc_rfc6282_mobil.c |  26 +++++
 net/6lowpan/nhc_rfc6282_route.c |  26 +++++
 net/6lowpan/nhc_rfc6282_udp.c   | 156 ++++++++++++++++++++++++++++
 12 files changed, 724 insertions(+), 167 deletions(-)
 create mode 100644 net/6lowpan/nhc.c
 create mode 100644 net/6lowpan/nhc.h
 create mode 100644 net/6lowpan/nhc_rfc6282_dest.c
 create mode 100644 net/6lowpan/nhc_rfc6282_frag.c
 create mode 100644 net/6lowpan/nhc_rfc6282_hop.c
 create mode 100644 net/6lowpan/nhc_rfc6282_ipv6.c
 create mode 100644 net/6lowpan/nhc_rfc6282_mobil.c
 create mode 100644 net/6lowpan/nhc_rfc6282_route.c
 create mode 100644 net/6lowpan/nhc_rfc6282_udp.c

-- 
2.1.3

