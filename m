Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:50607 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490AbaLGOWg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Dec 2014 09:22:36 -0500
Received: by mail-wg0-f41.google.com with SMTP id y19so4333178wgg.14
        for <linux-wpan@vger.kernel.org>; Sun, 07 Dec 2014 06:22:35 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 2/4] configure: fix CFLAGS definition
Date: Sun,  7 Dec 2014 15:21:42 +0100
Message-Id: <1417962104-9412-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1417962104-9412-1-git-send-email-alex.aring@gmail.com>
References: <1417962104-9412-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch fix the CFLAGS definition from my_CFLAGS to
WPAN_TOOLS_CFLAGS.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 9aa6330..16a8b97 100644
--- a/configure.ac
+++ b/configure.ac
@@ -37,7 +37,7 @@ AC_CHECK_FUNCS([ \
 	secure_getenv\
 ])
 
-my_CFLAGS="\
+WPAN_TOOLS_CFLAGS="\
 -Wall \
 -Wchar-subscripts \
 -Wformat-security \
-- 
2.1.3

