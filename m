Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:61988 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbaK2OZx (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 29 Nov 2014 09:25:53 -0500
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/2] 6lowpan: introduce nhc framework
Date: Sat, 29 Nov 2014 15:24:40 +0100
Message-Id: <1417271082-10068-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, Martin Townsend <mtownsend1973@gmail.com>

This patch series introduce the next header compression framework. Currently
we support udp compression/uncompression only. This framework allow to add new
next header compression formats easily.

If somebody wants to add a new header compression format and some information
are missing while calling compression and uncompression callbacks. Please
feel free to make framework changes according these callbacks.

Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>

Alexander Aring (2):
  6lowpan: add generic nhc layer interface
  6lowpan: add udp compression via nhc layer

 net/6lowpan/Makefile  |   5 +-
 net/6lowpan/iphc.c    | 188 +++++++-------------------------------------------
 net/6lowpan/nhc.c     | 183 ++++++++++++++++++++++++++++++++++++++++++++++++
 net/6lowpan/nhc.h     | 132 +++++++++++++++++++++++++++++++++++
 net/6lowpan/nhc_udp.c | 173 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 516 insertions(+), 165 deletions(-)
 create mode 100644 net/6lowpan/nhc.c
 create mode 100644 net/6lowpan/nhc.h
 create mode 100644 net/6lowpan/nhc_udp.c

-- 
2.1.3

