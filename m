Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:47043 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400AbbIIP0n (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 9 Sep 2015 11:26:43 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [RFC bluetooth-next 0/4] GHC compression detection
Date: Wed,  9 Sep 2015 17:26:29 +0200
Message-Id: <1441812393-32472-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, jukka.rissanen@linux.intel.com, Stefan Schmidt <stefan@osg.samsung.com>

Hello.

This is a first stab at RFC7400. So far we only hook into the NHC framework to
detect the three registered GHC types (extension header, UDP and ICMPv6).
This is aligned with how we detect the NHC frames.

TODO items:
o How to handle reserved and unassigned ranges in the HEADER TYPE?
o Implement compression/decompresion for GHC UDP
o Implement compression/decompresion for GHC ICMPv6
o How to handle 6CIO in IPv6 ND?

Stefan Schmidt (4):
  6lowpan: clarify Kconfig entries for upcoming GHC support
  6lowpan: add nhc module for GHC extension header detection
  6lowpan: add nhc module for GHC UDP detection
  6lowpan: add nhc module for GHC ICMPv6 detection

 net/6lowpan/Kconfig                | 20 ++++++++++++++++++--
 net/6lowpan/Makefile               |  5 +++++
 net/6lowpan/ghc_extension_header.c | 27 +++++++++++++++++++++++++++
 net/6lowpan/ghc_icmpv6.c           | 27 +++++++++++++++++++++++++++
 net/6lowpan/ghc_udp.c              | 27 +++++++++++++++++++++++++++
 5 files changed, 104 insertions(+), 2 deletions(-)
 create mode 100644 net/6lowpan/ghc_extension_header.c
 create mode 100644 net/6lowpan/ghc_icmpv6.c
 create mode 100644 net/6lowpan/ghc_udp.c

regards
Stefan Schmidt

-- 
2.4.3

