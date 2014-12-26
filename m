Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:54091 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbaLZEr7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 25 Dec 2014 23:47:59 -0500
Received: by mail-pa0-f54.google.com with SMTP id fb1so12690486pad.27
        for <linux-wpan@vger.kernel.org>; Thu, 25 Dec 2014 20:47:59 -0800 (PST)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next 0/3] Fixes and cleanup for CC2520
Date: Fri, 26 Dec 2014 10:13:37 +0530
Message-Id: <1419569020-5410-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

This series will introduce some cleanup code and fix for having
zero perm_extended_addr address.

Varka Bhadram (3):
  cc2520: use devm_kzalloc(.., sizeof(*pointer), ..) pattern
  cc2520: remove 'ret' goto label
  cc2520: fix zero perm_extended_addr address

 drivers/net/ieee802154/cc2520.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

-- 
1.7.9.5

