Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37597 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbbJTGcE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 20 Oct 2015 02:32:04 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/6] 6lowpan: iphc defines and rework tc and flow label handling
Date: Tue, 20 Oct 2015 08:31:20 +0200
Message-Id: <1445322686-2952-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com, Alexander Aring <alex.aring@gmail.com>

Hi,

this patch series based on my previous series "[PATCH bluetooth-next 1/6]
mac802154: llsec: use kzfree" and contains changes for iphc defines and
reworking the tc/flow label handling.

I tested the tc/flow label handling with fakelb and wireshark. So it should
be wrong, when wireshark is wrong also. I hope wireshark has some correct
mechanism to handle it. I used "wireshark 1.12.7".

- Alex

Alexander Aring (6):
  6lowpan: nhc: move iphc manipulation out of nhc
  6lowpan: move IPHC functionality defines
  6lowpan: remove lowpan_is_addr_broadcast
  6lowpan: iphc: change define values
  6lowpan: rework tc and flow label handling
  6lowpan: put mcast compression in an own function

 include/net/6lowpan.h       | 133 -----------
 net/6lowpan/iphc.c          | 565 +++++++++++++++++++++++++++++++-------------
 net/6lowpan/nhc.c           |  13 +-
 net/6lowpan/nhc.h           |   9 +-
 net/6lowpan/nhc_udp.c       |  22 +-
 net/ieee802154/6lowpan/tx.c |   5 +-
 6 files changed, 430 insertions(+), 317 deletions(-)

-- 
2.6.1

