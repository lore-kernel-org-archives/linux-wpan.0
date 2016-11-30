Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:52076 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757315AbcK3ODj (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 30 Nov 2016 09:03:39 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH bluetooth-next 3/5] ieee802154: add myself as co-maintainer to MAINTAINERS file
Date: Wed, 30 Nov 2016 15:03:23 +0100
Message-Id: <1480514605-30926-4-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1480514605-30926-1-git-send-email-stefan@osg.samsung.com>
References: <1480514605-30926-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: marcel@holtmann.org
Cc: linux-wpan@vger.kernel.org, Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>

Going to help Alexander, spread the review and development load.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
Acked-by: Alexander Aring <aar@pengutronix.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5196538..0e6002a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6105,6 +6105,7 @@ F:	drivers/idle/i7300_idle.c
 
 IEEE 802.15.4 SUBSYSTEM
 M:	Alexander Aring <aar@pengutronix.de>
+M:	Stefan Schmidt <stefan@osg.samsung.com>
 L:	linux-wpan@vger.kernel.org
 W:	http://wpan.cakelab.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git
-- 
2.5.5

