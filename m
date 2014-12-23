Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:62777 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbaLWKav (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Dec 2014 05:30:51 -0500
Received: by mail-wi0-f173.google.com with SMTP id r20so10415497wiv.6
        for <linux-wpan@vger.kernel.org>; Tue, 23 Dec 2014 02:30:50 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/3] ieee802154: 6lowpan: separate receive/transmit functionality
Date: Tue, 23 Dec 2014 11:30:08 +0100
Message-Id: <1419330611-29410-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Hi,

this patch series based on "ieee802154: structural directory changes" and
contains splitting of receive/transmit functionality in separate tx and rx
files. At least we rename the 6lowpan_rtnl to core which contains core
functionality for 802.15.4 6LoWPAN.

Alexander Aring (3):
  ieee802154: 6lowpan: move receive functionality
  ieee802154: 6lowpan: move transmit functionality
  ieee802154: 6lowpan: rename to core

 net/ieee802154/6lowpan/6lowpan_i.h    |  31 ++
 net/ieee802154/6lowpan/6lowpan_rtnl.c | 729 ----------------------------------
 net/ieee802154/6lowpan/Makefile       |   2 +-
 net/ieee802154/6lowpan/core.c         | 304 ++++++++++++++
 net/ieee802154/6lowpan/rx.c           | 171 ++++++++
 net/ieee802154/6lowpan/tx.c           | 271 +++++++++++++
 6 files changed, 778 insertions(+), 730 deletions(-)
 delete mode 100644 net/ieee802154/6lowpan/6lowpan_rtnl.c
 create mode 100644 net/ieee802154/6lowpan/core.c
 create mode 100644 net/ieee802154/6lowpan/rx.c
 create mode 100644 net/ieee802154/6lowpan/tx.c

-- 
2.2.0

