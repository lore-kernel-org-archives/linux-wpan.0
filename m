Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:59083 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbbHRIRZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 18 Aug 2015 04:17:25 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools] build: remove leftover from Makefile.am
Date: Tue, 18 Aug 2015 10:07:23 +0200
Message-Id: <1439885243-22609-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

We have no abc folder in src. Looks like this was bootstrapped with some
Makefile.am from libabc.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 Makefile.am | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 2584cb2..2261603 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -7,7 +7,6 @@ AM_CPPFLAGS = \
 	-include $(top_builddir)/config.h \
 	-DSYSCONFDIR=\""$(sysconfdir)"\" \
 	-DLIBEXECDIR=\""$(libexecdir)"\" \
-	-I${top_srcdir}/src/abc \
 	-I${top_srcdir}/src
 
 AM_CFLAGS = ${WPAN_TOOLS_CFLAGS} \
-- 
2.4.3

