Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35640 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbbFLFa3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Jun 2015 01:30:29 -0400
Received: by pacyx8 with SMTP id yx8so16050350pac.2
        for <linux-wpan@vger.kernel.org>; Thu, 11 Jun 2015 22:30:29 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH wpan-misc] website: update with wpan-ping info
Date: Fri, 12 Jun 2015 10:59:52 +0530
Message-Id: <1434086992-9639-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Varka Bhadram <varkab@cdac.in>


Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 website/index.txt |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/website/index.txt b/website/index.txt
index 996cffc..907af61 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -11,7 +11,8 @@ http://www.spinics.net/lists/linux-wpan[Mailinglist-Archive]
 wpan-tools
 ----------
 
-To access the nl802154 netlink inteface you will need the wpan-tools.
+To access the nl802154 netlink inteface and also for checking
+the network connectivity you will need the wpan-tools.
 
 Dependencies:
 
@@ -21,6 +22,7 @@ These tools contains:
 
 [horizontal]
 *iwpan*:: based on the wireless http://wireless.kernel.org/en/users/Documentation/iw[iw] tool.
+*wpan-ping*:: Ping utility on IEEE 802.15.4 level.
 
 Download
 ~~~~~~~~
-- 
1.7.9.5

