Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34445 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934226AbdBQPuJ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 17 Feb 2017 10:50:09 -0500
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v3 0/5] Bluetooth: 6LoWPAN: Fix lladdr length
Date: Fri, 17 Feb 2017 17:49:58 +0200
Message-Id: <20170217155003.4594-1-luiz.dentz@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: patrik.flykt@linux.intel.com, aar@pengutronix.de, linux-wpan@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

These patches fixes lladdr length to be 6 bytes long and not 8 which cause
neighbor advertisement to be sent with wrong lladdr including FF:FE filler
bytes for eui64.

Note: This does not fix some of the existing crashes which I hope to address
in a different set.

v2: Make all code paths that generate a link-local from lladdr use the same
code.
v3: Use lowpan_iphc_uncompress_eui48_lladdr to generate the remote ip address.

Alexander Aring (2):
  6lowpan: iphc: override l2 packet information
  ipv6: addrconf: fix 48 bit 6lowpan autoconfiguration

Luiz Augusto von Dentz (1):
  6lowpan: Use netdev addr_len to determine lladdr len

Patrik Flykt (2):
  bluetooth: Set 6 byte device addresses
  6lowpan: Set MAC address lenght according to LOWPAN_LLTYPE

 include/net/6lowpan.h   | 19 +++++++++++++++++
 net/6lowpan/core.c      | 11 +++++++++-
 net/6lowpan/iphc.c      | 57 ++++++++++++++++++++++++++++++++++++++-----------
 net/bluetooth/6lowpan.c | 52 +++++++++++---------------------------------
 net/ipv6/addrconf.c     | 17 ++++++++++-----
 5 files changed, 99 insertions(+), 57 deletions(-)

-- 
2.9.3

