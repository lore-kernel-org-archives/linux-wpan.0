Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:49308 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490AbaLGOWh (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Dec 2014 09:22:37 -0500
Received: by mail-wi0-f180.google.com with SMTP id n3so2594982wiv.13
        for <linux-wpan@vger.kernel.org>; Sun, 07 Dec 2014 06:22:36 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 3/4] configure: change archive generation
Date: Sun,  7 Dec 2014 15:21:43 +0100
Message-Id: <1417962104-9412-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1417962104-9412-1-git-send-email-alex.aring@gmail.com>
References: <1417962104-9412-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch changes the archive generation for "make distcheck".

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 configure.ac | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 16a8b97..bb17e08 100644
--- a/configure.ac
+++ b/configure.ac
@@ -12,8 +12,7 @@ AM_INIT_AUTOMAKE([
 	-Wno-portability
 	silent-rules
 	tar-pax
-	no-dist-gzip
-	dist-xz
+	dist-bzip2
 	subdir-objects
 ])
 AC_PROG_CC_STDC
-- 
2.1.3

