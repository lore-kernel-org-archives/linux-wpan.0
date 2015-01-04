Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:61254 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbbADQLJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 4 Jan 2015 11:11:09 -0500
Received: by mail-wg0-f43.google.com with SMTP id k14so8554327wgh.16
        for <linux-wpan@vger.kernel.org>; Sun, 04 Jan 2015 08:11:08 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/5] ieee802154: structural directory changes
Date: Sun,  4 Jan 2015 17:10:52 +0100
Message-Id: <1420387857-32029-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch series contains patches to create a 6lowpan sub-directory inside
ieee802154. At least we handle receive and transmit functionality in separate
files.

This series based on previous the previous series:

"ieee802154: 6lowpan: separate receive/transmit functionality" and
"ieee802154: structural directory changes".

I changed PATCH 1/5 "ieee802154: create 6lowpan sub-directory" only to source
the "net/ieee802154/6lowpan/Kconfig" file. Furthermore there will more options
like debugfs etc... available for ieee802154 6lowpan functionality.

- Alex

Alexander Aring (5):
  ieee802154: create 6lowpan sub-directory
  ieee802154: 6lowpan: rename internal header
  ieee802154: 6lowpan: move receive functionality
  ieee802154: 6lowpan: move transmit functionality
  ieee802154: 6lowpan: rename to core

 net/ieee802154/6lowpan/6lowpan_i.h        |  72 +++
 net/ieee802154/6lowpan/Kconfig            |   5 +
 net/ieee802154/6lowpan/Makefile           |   3 +
 net/ieee802154/6lowpan/core.c             | 304 +++++++++++++
 net/ieee802154/{ => 6lowpan}/reassembly.c |   2 +-
 net/ieee802154/6lowpan/rx.c               | 171 +++++++
 net/ieee802154/6lowpan/tx.c               | 271 +++++++++++
 net/ieee802154/6lowpan_rtnl.c             | 729 ------------------------------
 net/ieee802154/Kconfig                    |   6 +-
 net/ieee802154/Makefile                   |   3 +-
 net/ieee802154/reassembly.h               |  41 --
 11 files changed, 829 insertions(+), 778 deletions(-)
 create mode 100644 net/ieee802154/6lowpan/6lowpan_i.h
 create mode 100644 net/ieee802154/6lowpan/Kconfig
 create mode 100644 net/ieee802154/6lowpan/Makefile
 create mode 100644 net/ieee802154/6lowpan/core.c
 rename net/ieee802154/{ => 6lowpan}/reassembly.c (99%)
 create mode 100644 net/ieee802154/6lowpan/rx.c
 create mode 100644 net/ieee802154/6lowpan/tx.c
 delete mode 100644 net/ieee802154/6lowpan_rtnl.c
 delete mode 100644 net/ieee802154/reassembly.h

-- 
2.2.1

