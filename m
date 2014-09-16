Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:62769 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbaIPEvS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Sep 2014 00:51:18 -0400
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next 0/3] ieee802154: cleanup for mrf24j40
Date: Tue, 16 Sep 2014 10:18:39 +0530
Message-Id: <1410842922-10564-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc: alan@signal11.us, Varka Bhadram <varkab@cdac.in>


Varka Bhadram (3):
  ieee802154: mrf24j40: fix Missing a blank line after declarations
  ieee802154: mrf24j40: remove return statement
  ieee802154: mrf24j40: use pr_* / dev_*

 drivers/net/ieee802154/mrf24j40.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

-- 
1.7.9.5

