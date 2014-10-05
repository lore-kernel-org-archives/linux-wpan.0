Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:49555 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbaJESX2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 5 Oct 2014 14:23:28 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/2] mac802154: ieee802154: typo and routing fixes
Date: Sun,  5 Oct 2014 20:23:10 +0200
Message-Id: <1412533392-4072-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Hi,

this patches series contains a tirivial typo in mac802154 Kconfig entry and
drop PACKET_OTHERHOST skb's before parsing 6lowpan header.

- Alex

Julien Catalano (1):
  trivial: net/mac802154: Fix Kconfig typo

Simon Vincent (1):
  ieee802154: 6lowpan: Drop PACKET_OTHERHOST skbs in 6lowpan

 net/ieee802154/6lowpan_rtnl.c | 3 +++
 net/mac802154/Kconfig         | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.1.2

