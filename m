Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:45923 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbaK2VPL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 29 Nov 2014 16:15:11 -0500
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth-next 0/2] 6lowpan: introduce nhc framework
Date: Sat, 29 Nov 2014 22:14:41 +0100
Message-Id: <1417295683-22682-1-git-send-email-alex.aring@gmail.com>
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

Note:

If building 6lowpan_udp as module please make sure it's loaded before running
rfc6282 udp connection. If it's not loaded we send 6lowpan with raw udp header
and next header compression bit isn't set. Nevertheless if you use rfc6282
connection and 6lowpan_udp isn't loaded following will be printed:

"ieee802154 wpan-phy0 wpan0: received nhc which is not supported. Dropping."

changes since v2:
 - make udp nhc as module as suggested by Marcel Holtmann
 - fix comment header in nhc_udp.c

I didn't make the lowpan_nhc declaration "const" because this will occur
issues with rb_node, id and idmask array. Which will manipulated during
runtime.

Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>

Alexander Aring (2):
  6lowpan: add generic nhc layer interface
  6lowpan: add udp compression via nhc layer

 net/6lowpan/Kconfig   |   7 ++
 net/6lowpan/Makefile  |   6 +-
 net/6lowpan/iphc.c    | 176 ++++----------------------------------------------
 net/6lowpan/nhc.c     | 175 +++++++++++++++++++++++++++++++++++++++++++++++++
 net/6lowpan/nhc.h     | 130 +++++++++++++++++++++++++++++++++++++
 net/6lowpan/nhc_udp.c | 169 ++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 497 insertions(+), 166 deletions(-)
 create mode 100644 net/6lowpan/nhc.c
 create mode 100644 net/6lowpan/nhc.h
 create mode 100644 net/6lowpan/nhc_udp.c

-- 
2.1.3

