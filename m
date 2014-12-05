Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:43051 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbaLERz5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 5 Dec 2014 12:55:57 -0500
From: Stefan Schmidt <s.schmidt@samsung.com>
Subject: [PATCH wpan-tools 1/3] configure: Fail if libnl3 dependency is not found
Date: Fri,  5 Dec 2014 18:55:42 +0100
Message-Id: <1417802144-3012-2-git-send-email-s.schmidt@samsung.com>
In-Reply-To: <1417802144-3012-1-git-send-email-s.schmidt@samsung.com>
References: <1417802144-3012-1-git-send-email-s.schmidt@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>

The conditionals are not used anywhere and we have a hard dependency on
libnl3 so fail if we do not detect it during configure.

Signed-off-by: Stefan Schmidt <s.schmidt@samsung.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 791607f..6ad60f5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -31,7 +31,7 @@ AC_PREFIX_DEFAULT([/usr])
 AC_PROG_SED
 AC_PROG_MKDIR_P
 
-PKG_CHECK_MODULES(LIBNL3, [libnl-3.0 >= 3.1 libnl-genl-3.0 >= 3.1], [have_libnl3=yes], [have_libnl3=no])
+PKG_CHECK_MODULES(LIBNL3, [libnl-3.0 >= 3.1 libnl-genl-3.0 >= 3.1])
 
 AC_CHECK_FUNCS([ \
 	__secure_getenv \
-- 
1.9.3

