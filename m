Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34873 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbbE2F2m (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2015 01:28:42 -0400
Received: by pacwv17 with SMTP id wv17so43205465pac.2
        for <linux-wpan@vger.kernel.org>; Thu, 28 May 2015 22:28:42 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next 0/5] fixes and cleanups for cc2520
Date: Fri, 29 May 2015 10:56:53 +0530
Message-Id: <1432877218-12537-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: bradjc5@gmail.com, Varka Bhadram <varkab@cdac.in>

This series mainly related to tx power settings with or without
CC2591 amplifier.


Hi Brad Campbell,
	I added you in CC. Please test these changes with CC2591.

--
Varka Bhadram

Varka Bhadram (5):
  cc2520: fix in default tx power setting
  cc2520: fix CC2591 handling
  cc2520: add set transmit power setting support
  cc2520: update initial transmit power value
  cc2520: update current channel

 drivers/net/ieee802154/cc2520.c |  124 +++++++++++++++++++++++++++++++++++----
 include/linux/spi/cc2520.h      |    1 -
 2 files changed, 114 insertions(+), 11 deletions(-)

-- 
1.7.9.5

