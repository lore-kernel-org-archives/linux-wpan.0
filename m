Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:63471 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665AbaLGOWi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Dec 2014 09:22:38 -0500
Received: by mail-wg0-f50.google.com with SMTP id k14so4312680wgh.23
        for <linux-wpan@vger.kernel.org>; Sun, 07 Dec 2014 06:22:37 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 4/4] configure: version bump
Date: Sun,  7 Dec 2014 15:21:44 +0100
Message-Id: <1417962104-9412-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1417962104-9412-1-git-send-email-alex.aring@gmail.com>
References: <1417962104-9412-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Bump version for release 0.3

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index bb17e08..f0d6f5d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,6 +1,6 @@
 AC_PREREQ(2.60)
 AC_INIT([Userspace tools for Linux IEEE 802.15.4 stack],
-	[0.1], [linux-wpan@vger.kernel.org], [wpan-tools],
+	[0.3], [linux-wpan@vger.kernel.org], [wpan-tools],
 	[https://github.com/linux-wpan/wpan-tools])
 AC_CONFIG_SRCDIR([src/iwpan.c])
 AC_CONFIG_AUX_DIR([build-aux])
-- 
2.1.3

