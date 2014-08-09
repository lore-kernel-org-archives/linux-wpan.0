Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:46941 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbaHITCl (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 9 Aug 2014 15:02:41 -0400
From: Alexander Aring <alex.aring@gmail.com>
Date: Sat,  9 Aug 2014 21:02:15 +0200
Message-Id: <1407610943-27701-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [RFC bluetooth-next 0/8] 6lowpan: introduce generic next header compression layer
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com, Alexander Aring <alex.aring@gmail.com>

Hi,

this patch series introduce a generic interface for the 6LoWPAN header
compression. Inside the 6LoWPAN header there is a variable length next
header id if the compression bit inside the IPHC header is set. [0]
This implementation use a red-black tree to find the nhc structure with
the received variable length nhc id. Then it call the uncompression callback
on received side. On sending side it used the nexthdr attribute of IPv6 header
and call the compression callback on sending side.

We currently support only one next header compression, this is UDP. The callbacks
for compression and uncompression contains the necessary informations to do UDP
compression/uncompression only. If you need more informations inside the callbacks
feel free to change it while supporting new next header compression formats.

It's just a basic support to handle this in a more generic way instead of hacking
everything in iphc.c file.

Also adding basic support for RFC6282 next header compression values. We don't
these, but we should drop these packets then instead sending garbage to next
layer.

It's currently RFC, if nobody screams I will send "real" patches. Maybe we can
do some things better.

- Alex

[0] http://tools.ietf.org/html/rfc6282#section-4.1

Alexander Aring (8):
  6lowpan: add generic nhc layer interface
  6lowpan: nhc layer udp compression
  6lowpan: add hop-by-hop options skeleton
  6lowpan: add routing skeleton
  6lowpan: add fragment skeleton
  6lowpan: add destination options skeleton
  6lowpan: add mobility skeleton
  6lowpan: add ipv6 skeleton

 net/6lowpan/Makefile     |   1 +
 net/6lowpan/iphc.c       | 184 +++++-------------------------------
 net/6lowpan/nhc/Makefile |  10 ++
 net/6lowpan/nhc/core.c   | 238 +++++++++++++++++++++++++++++++++++++++++++++++
 net/6lowpan/nhc/core.h   | 122 ++++++++++++++++++++++++
 net/6lowpan/nhc/dest.c   |  49 ++++++++++
 net/6lowpan/nhc/dest.h   |  11 +++
 net/6lowpan/nhc/frag.c   |  49 ++++++++++
 net/6lowpan/nhc/frag.h   |  11 +++
 net/6lowpan/nhc/hop.c    |  48 ++++++++++
 net/6lowpan/nhc/hop.h    |  11 +++
 net/6lowpan/nhc/ipv6.c   |  48 ++++++++++
 net/6lowpan/nhc/ipv6.h   |  11 +++
 net/6lowpan/nhc/mobil.c  |  49 ++++++++++
 net/6lowpan/nhc/mobil.h  |  11 +++
 net/6lowpan/nhc/route.c  |  48 ++++++++++
 net/6lowpan/nhc/route.h  |  11 +++
 net/6lowpan/nhc/udp.c    | 173 ++++++++++++++++++++++++++++++++++
 net/6lowpan/nhc/udp.h    |   9 ++
 19 files changed, 931 insertions(+), 163 deletions(-)
 create mode 100644 net/6lowpan/nhc/Makefile
 create mode 100644 net/6lowpan/nhc/core.c
 create mode 100644 net/6lowpan/nhc/core.h
 create mode 100644 net/6lowpan/nhc/dest.c
 create mode 100644 net/6lowpan/nhc/dest.h
 create mode 100644 net/6lowpan/nhc/frag.c
 create mode 100644 net/6lowpan/nhc/frag.h
 create mode 100644 net/6lowpan/nhc/hop.c
 create mode 100644 net/6lowpan/nhc/hop.h
 create mode 100644 net/6lowpan/nhc/ipv6.c
 create mode 100644 net/6lowpan/nhc/ipv6.h
 create mode 100644 net/6lowpan/nhc/mobil.c
 create mode 100644 net/6lowpan/nhc/mobil.h
 create mode 100644 net/6lowpan/nhc/route.c
 create mode 100644 net/6lowpan/nhc/route.h
 create mode 100644 net/6lowpan/nhc/udp.c
 create mode 100644 net/6lowpan/nhc/udp.h

-- 
2.0.3

