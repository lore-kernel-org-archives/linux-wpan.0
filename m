Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:55587 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468AbbKISUA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 9 Nov 2015 13:20:00 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools] build: avoid redefinition errors with libnl >= 3.2.27
Date: Mon,  9 Nov 2015 19:10:42 +0100
Message-Id: <1447092642-17115-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

 From 3.2.17 onwards we have nla for s8, s16, etc defined directly in libnl.
If we keep including this file anyway we run into redefinition errors. Better
include use our own only for earlier versions.

Happened to me on Fedora 22 after my last update.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 src/nl_extras.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/nl_extras.h b/src/nl_extras.h
index 9d841aa..c4d1d14 100644
--- a/src/nl_extras.h
+++ b/src/nl_extras.h
@@ -1,6 +1,8 @@
 #ifndef __NL_EXTRAS_H
 #define __NL_EXTRAS_H
 
+#if LIBNL_VER_MIC <= 26
+
 #ifndef NLA_S8
 
 #define NLA_S8	13
@@ -43,4 +45,6 @@ static inline int32_t nla_get_s32(struct nlattr *nla)
 
 #endif /* NLA_S64 */
 
+#endif /* LIBNL_VER_MIC */
+
 #endif /* __NL_EXTRAS_H */
-- 
2.4.3

