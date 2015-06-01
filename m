Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:32940 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbbFAEe3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Jun 2015 00:34:29 -0400
Received: by pdbqa5 with SMTP id qa5so98417395pdb.0
        for <linux-wpan@vger.kernel.org>; Sun, 31 May 2015 21:34:28 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next 0/3] rdev-ops trace fixes
Date: Mon,  1 Jun 2015 10:03:55 +0530
Message-Id: <1433133238-16056-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>

Varka Bhadram (3):
  ieee802154: trace: fix name for tx power value
  ieee802154: trace: fix name for extended address
  ieee802154: trace: fix extended addr format specifier

 net/ieee802154/trace.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
1.7.9.5

