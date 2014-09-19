Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35096 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbaISLDy (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Sep 2014 07:03:54 -0400
Received: by mail-pa0-f53.google.com with SMTP id rd3so3632078pab.12
        for <linux-wpan@vger.kernel.org>; Fri, 19 Sep 2014 04:03:53 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH wpan-next v3 0/3] cleanup for mrf24j40
Date: Fri, 19 Sep 2014 16:27:14 +0530
Message-Id: <1411124237-16919-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alan@signal11.us, Varka Bhadram <varkab@cdac.in>

changes since v2:
- generated patches based on wpan-next

changes since v1:
- changes in commit messages and descriptions suggested by Alan Ott

Varka Bhadram (3):
  mrf24j40: fix Missing a blank line after declarations
  mrf24j40: remove unnecessary return statement
  mrf24j40: use pr_* / dev_* instead of printk()

 drivers/net/ieee802154/mrf24j40.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

-- 
1.7.9.5

