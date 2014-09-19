Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:42475 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbaISEs1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Sep 2014 00:48:27 -0400
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next v2 0/3] cleanup for mrf24j40 driver
Date: Fri, 19 Sep 2014 10:15:07 +0530
Message-Id: <1411101911-12462-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc: alan@signal11.us, Varka Bhadram <varkab@cdac.in>

changes since v1:
 - changes in commit messages and descriptions suggested by Alan Ott

Varka Bhadram (3):
  mrf24j40: fix Missing a blank line after declarations
  mrf24j40: remove unnecessary return statement
  mrf24j40: use pr_* / dev_* instead of printk()

 drivers/net/ieee802154/mrf24j40.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

-- 
1.7.9.5

