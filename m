Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:42787 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbaLTOF3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 20 Dec 2014 09:05:29 -0500
Received: by mail-wg0-f41.google.com with SMTP id y19so3470913wgg.14
        for <linux-wpan@vger.kernel.org>; Sat, 20 Dec 2014 06:05:26 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/5] ieee802154: structural directory changes
Date: Sat, 20 Dec 2014 15:04:55 +0100
Message-Id: <1419084300-29069-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch series contains structural changes according the ieee802154
directory. The current situation is that this directory contains stuff
about ieee802154 6lowpan, ieee802154 address family and netlink interface.
This patch series introduce now sub directories for 6lowpan and af802154
implementation to getting a better overview about these implementations.
The ieee802154 directory contains stuff for nl802154, netlink and sysfs
only.

Alexander Aring (5):
  ieee802154: create af802154 sub-directory
  ieee802154: af802154: rename internal header
  ieee802154: af802154: rename af_ieee802154 to core
  ieee802154: create 6lowpan sub-directory
  ieee802154: 6lowpan: rename internal header

 net/ieee802154/{reassembly.h => 6lowpan/6lowpan_i.h} | 6 +++---
 net/ieee802154/{ => 6lowpan}/6lowpan_rtnl.c          | 2 +-
 net/ieee802154/6lowpan/Makefile                      | 3 +++
 net/ieee802154/{ => 6lowpan}/reassembly.c            | 2 +-
 net/ieee802154/Makefile                              | 6 ++----
 net/ieee802154/af802154/Makefile                     | 3 +++
 net/ieee802154/{af802154.h => af802154/af802154_i.h} | 6 +++---
 net/ieee802154/{af_ieee802154.c => af802154/core.c}  | 2 +-
 net/ieee802154/{ => af802154}/dgram.c                | 2 +-
 net/ieee802154/{ => af802154}/raw.c                  | 2 +-
 10 files changed, 19 insertions(+), 15 deletions(-)
 rename net/ieee802154/{reassembly.h => 6lowpan/6lowpan_i.h} (85%)
 rename net/ieee802154/{ => 6lowpan}/6lowpan_rtnl.c (99%)
 create mode 100644 net/ieee802154/6lowpan/Makefile
 rename net/ieee802154/{ => 6lowpan}/reassembly.c (99%)
 create mode 100644 net/ieee802154/af802154/Makefile
 rename net/ieee802154/{af802154.h => af802154/af802154_i.h} (93%)
 rename net/ieee802154/{af_ieee802154.c => af802154/core.c} (99%)
 rename net/ieee802154/{ => af802154}/dgram.c (99%)
 rename net/ieee802154/{ => af802154}/raw.c (99%)

-- 
2.2.0

