Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:56080 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756429AbaHHK66 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 Aug 2014 06:58:58 -0400
From: varkabhadram@gmail.com
Date: Fri,  8 Aug 2014 16:27:19 +0530
Message-Id: <1407495439-5906-1-git-send-email-varkabhadram@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH bluetooth-next] MAINTAINERS: add mailing list
To: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc: Varka Bhadram <varkab@cdac.in>

From: Varka Bhadram <varkab@cdac.in>

adds the mailing list address for bluetooth generic 6lowpan and
802.15.4 subsystems

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 MAINTAINERS |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 05e5450..59a4108 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -154,6 +154,7 @@ F:	drivers/scsi/53c700*
 M:	Alexander Aring <alex.aring@gmail.com>
 L:	linux-zigbee-devel@lists.sourceforge.net (moderated for non-subscribers)
 L:	linux-bluetooth@vger.kernel.org
+L:	linux-wpan@vger.kernel.org
 S:	Maintained
 F:	net/6lowpan/
 F:	include/net/6lowpan.h
@@ -4561,6 +4562,7 @@ F:	drivers/idle/i7300_idle.c
 IEEE 802.15.4 SUBSYSTEM
 M:	Alexander Aring <alex.aring@gmail.com>
 L:	linux-zigbee-devel@lists.sourceforge.net (moderated for non-subscribers)
+L:	linux-wpan@vger.kernel.org
 W:	http://apps.sourceforge.net/trac/linux-zigbee
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lowpan/lowpan.git
 S:	Maintained
-- 
1.7.9.5

