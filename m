Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:63006 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889AbaHHMEW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 Aug 2014 08:04:22 -0400
From: varkabhadram@gmail.com
Date: Fri,  8 Aug 2014 17:32:45 +0530
Message-Id: <1407499365-7271-1-git-send-email-varkabhadram@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: [PATCH bluetooth-next] MAINTAINERS: update maintainers info
To: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc: Varka Bhadram <varkab@cdac.in>

From: Varka Bhadram <varkab@cdac.in>

adds the mailing list address for bluetooth 6loWPAN and
IEEE-802.15.4 subsystems. Also adds web page info.

Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
Hi,

Previosly its my mistake i have not updated my local bluetooth-next
tree. Sorry for the noise.

Thanks
Varka Bhadram.

 MAINTAINERS |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 05e5450..43f3df1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -152,8 +152,8 @@ F:	drivers/scsi/53c700*
 
 6LOWPAN GENERIC (BTLE/IEEE 802.15.4)
 M:	Alexander Aring <alex.aring@gmail.com>
-L:	linux-zigbee-devel@lists.sourceforge.net (moderated for non-subscribers)
 L:	linux-bluetooth@vger.kernel.org
+L:	linux-wpan@vger.kernel.org
 S:	Maintained
 F:	net/6lowpan/
 F:	include/net/6lowpan.h
@@ -4560,13 +4560,14 @@ F:	drivers/idle/i7300_idle.c
 
 IEEE 802.15.4 SUBSYSTEM
 M:	Alexander Aring <alex.aring@gmail.com>
-L:	linux-zigbee-devel@lists.sourceforge.net (moderated for non-subscribers)
-W:	http://apps.sourceforge.net/trac/linux-zigbee
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lowpan/lowpan.git
+L:	linux-wpan@vger.kernel.org
+W:	https://github.com/linux-wpan
+T:	git git://github.com/linux-wpan/linux-wpan-next.git
 S:	Maintained
 F:	net/ieee802154/
 F:	net/mac802154/
 F:	drivers/net/ieee802154/
+F:	Documentation/networking/ieee802154.txt
 
 IGUANAWORKS USB IR TRANSCEIVER
 M:	Sean Young <sean@mess.org>
-- 
1.7.9.5

