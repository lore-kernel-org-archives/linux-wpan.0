Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:48585 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755628AbbE2Ivm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2015 04:51:42 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCHv2 bluetooth-next 4/4] MAINTAINERS: Add myself as maintainer for the atusb driver
Date: Fri, 29 May 2015 10:51:28 +0200
Message-Id: <1432889488-28420-5-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1432889488-28420-1-git-send-email-stefan@osg.samsung.com>
References: <1432889488-28420-1-git-send-email-stefan@osg.samsung.com>
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

