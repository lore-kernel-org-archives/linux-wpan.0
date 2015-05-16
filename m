Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37489 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754AbbEPP1A (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 16 May 2015 11:27:00 -0400
Received: by wibt6 with SMTP id t6so23971463wib.0
        for <linux-wpan@vger.kernel.org>; Sat, 16 May 2015 08:26:59 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 00/13] fakelb: rework driver implementation
Date: Sat, 16 May 2015 17:26:04 +0200
Message-Id: <1431789977-31393-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mtownsend1973@gmail.com, simon.vincent@xsilon.com, Alexander Aring <alex.aring@gmail.com>

Hi,

this patch series completes rework the fakelb driver. After loading the fakelb
driver you have as default two registered phys. Example use:

1. Creating a lowpan interface on each wpan interface.

2. try IPv6 connection between the two lowpan interfaces.

This patch series based on
"mac802154: fakelb: Fix potential NULL pointer dereference." by
Martin Townsend.

- Alex

Alexander Aring (13):
  fakelb: creating two virtual phys per default
  fakelb: use list_for_each_entry_safe
  fakelb: rename fakelb_dev_priv to fakelb_phy
  fakelb: don't deliver when one phy
  fakelb: declare rwlock static
  fakelb: declare fakelb list static
  fakelb: move lock out of iteration
  fakelb: introduce fakelb ifup phys list
  fakelb: use own channel and page attributes
  fakelb: add virtual phy reset defaults
  fakelb: remove fakelb_hw_deliver
  fakelb: add support for async xmit handling
  fakelb: cleanup code

 drivers/net/ieee802154/fakelb.c | 180 +++++++++++++++++-----------------------
 1 file changed, 76 insertions(+), 104 deletions(-)

-- 
2.3.7

