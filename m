Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:40237 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbaIXKWG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Sep 2014 06:22:06 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/4] ieee802154: mrf24j40 cleanups and 6lowpan fix
Date: Wed, 24 Sep 2014 12:21:29 +0200
Message-Id: <1411554093-14976-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Hi,

this patches series contains cleanups for the mrf24j40 driver of the 802.15.4 subsystem.
Also one patch to fix a 802.15.4 6LoWPAN bug if we replace the IPv6 header with 6LoWPAN
header on a shared skb data buffer.

- Alex

Simon Vincent (1):
  ieee802154: 6lowpan: ensure header compression does not corrupt ipv6
    header

Varka Bhadram (3):
  mrf24j40: fix Missing a blank line after declarations
  mrf24j40: remove unnecessary return statement
  mrf24j40: use pr_* / dev_* instead of printk()

 drivers/net/ieee802154/mrf24j40.c |  19 +++---
 net/ieee802154/6lowpan_rtnl.c     | 125 +++++++++++++++++++++++++++-----------
 2 files changed, 99 insertions(+), 45 deletions(-)

-- 
2.1.0

