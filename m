Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:46005 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817AbbE1VrB (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 28 May 2015 17:47:01 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH bluetooth-next 4/4] MAINTAINERS: Add myself as maintainer for the atusb driver
Date: Thu, 28 May 2015 23:46:47 +0200
Message-Id: <1432849607-24491-5-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1432849607-24491-1-git-send-email-stefan@osg.samsung.com>
References: <1432849607-24491-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>, Stefan Schmidt <stefan@osg.samsung.com>

From: Stefan Schmidt <s.schmidt@samsung.com>

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d87ccb..d69a7c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1860,6 +1860,14 @@ W:	http://www.attotech.com
 S:	Supported
 F:	drivers/scsi/esas2r
 
+ATUSB IEEE 802.15.4 RADIO DRIVER
+M:	Stefan Schmidt <stefan@osg.samsung.com>
+L:	linux-wpan@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ieee802154/atusb.c
+F:	drivers/net/ieee802154/atusb.h
+F:	drivers/net/ieee802154/at86rf230.h
+
 AUDIT SUBSYSTEM
 M:	Paul Moore <paul@paul-moore.com>
 M:	Eric Paris <eparis@redhat.com>
-- 
2.1.0

