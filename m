Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:36819 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbbKYO70 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 25 Nov 2015 09:59:26 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH v2 bluetooth-next 0/7] GHC compression detection
Date: Wed, 25 Nov 2015 15:59:10 +0100
Message-Id: <1448463557-22618-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-bluetooth@vger.kernel.org, Stefan Schmidt <stefan@osg.samsung.com>

Hello.

This is a first stab at RFC7400. So far we only hook into the NHC framework to
detect the registered GHC types (extension headers, UDP and ICMPv6).
This is aligned with how we detect the NHC frames.

Changes since v1:
        o Use correct NEXTHDR defines for LOWPAN_NHC()
        o Split out different extension headers into one module each
        o Add some help text for configure options

Changes since RFC:
        o prefixed new files with nhc_ to stay in line with other nhc modules
        o added linux-bluetooth to CC

Stefan Schmidt (7):
  6lowpan: clarify Kconfig entries for upcoming GHC support
  6lowpan: add nhc module for GHC hop-by-hopextension header detection
  6lowpan: add nhc module for GHC UDP detection
  6lowpan: add nhc module for GHC ICMPv6 detection
  6lowpan: add nhc module for GHC destination extension header detection
  6lowpan: add nhc module for GHC fragmentation extension header
    detection
  6lowpan: add nhc module for GHC routing extension header detection

 net/6lowpan/Kconfig             | 39 +++++++++++++++++++++++++++++++++++++--
 net/6lowpan/Makefile            |  8 ++++++++
 net/6lowpan/nhc_ghc_ext_dest.c  | 27 +++++++++++++++++++++++++++
 net/6lowpan/nhc_ghc_ext_frag.c  | 28 ++++++++++++++++++++++++++++
 net/6lowpan/nhc_ghc_ext_hop.c   | 27 +++++++++++++++++++++++++++
 net/6lowpan/nhc_ghc_ext_route.c | 27 +++++++++++++++++++++++++++
 net/6lowpan/nhc_ghc_icmpv6.c    | 27 +++++++++++++++++++++++++++
 net/6lowpan/nhc_ghc_udp.c       | 27 +++++++++++++++++++++++++++
 8 files changed, 208 insertions(+), 2 deletions(-)
 create mode 100644 net/6lowpan/nhc_ghc_ext_dest.c
 create mode 100644 net/6lowpan/nhc_ghc_ext_frag.c
 create mode 100644 net/6lowpan/nhc_ghc_ext_hop.c
 create mode 100644 net/6lowpan/nhc_ghc_ext_route.c
 create mode 100644 net/6lowpan/nhc_ghc_icmpv6.c
 create mode 100644 net/6lowpan/nhc_ghc_udp.c

-- 
2.4.3

