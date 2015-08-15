Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38624 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbbHOJBG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 15 Aug 2015 05:01:06 -0400
Received: by wicja10 with SMTP id ja10so40700187wic.1
        for <linux-wpan@vger.kernel.org>; Sat, 15 Aug 2015 02:01:05 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/2] ieee802154: 6lowpan: fixes for multiple interfaces
Date: Sat, 15 Aug 2015 11:00:31 +0200
Message-Id: <1439629233-4328-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

Hi,

while working on "ieee802154: 6lowpan: cleanup and rework dispatch evaluation",
I detected issues which was introduced by removal the multiple interfaces
feature _per_ wpan interface. These are:

 - multiple registration for the packet handler -> fixed by open_count
 - check on if the wpan interface has a lowpan interface.

I also detect the missing dev_put while lowpan netdev_registation and
take some patches like moving the ARPHRD check earlier, we need to
check on this before evaluating the ieee802154_ptr.

- Alex

Alexander Aring (2):
  ieee802154: 6lowpan: fix packet layer registration
  ieee802154: 6lowpan: fix non-lowpan wpan interfaces

 net/ieee802154/6lowpan/core.c | 22 +++++++++++++++++-----
 net/ieee802154/6lowpan/rx.c   |  7 ++++---
 2 files changed, 21 insertions(+), 8 deletions(-)

-- 
2.5.0

