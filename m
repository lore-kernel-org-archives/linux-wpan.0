Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:56626 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbaLGOWf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Dec 2014 09:22:35 -0500
Received: by mail-wi0-f180.google.com with SMTP id n3so2594918wiv.13
        for <linux-wpan@vger.kernel.org>; Sun, 07 Dec 2014 06:22:34 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 1/4] iwpan: use autoconf version defines
Date: Sun,  7 Dec 2014 15:21:41 +0100
Message-Id: <1417962104-9412-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch use the autoconf VERSION defines instead hardcoded version
strings.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/iwpan.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/iwpan.c b/src/iwpan.c
index 1e0b162..e988703 100644
--- a/src/iwpan.c
+++ b/src/iwpan.c
@@ -17,6 +17,7 @@
 
 #include "nl802154.h"
 #include "iwpan.h"
+#include "config.h"
 
 /* TODO libnl 1.x compatibility code */
 
@@ -173,8 +174,7 @@ static void usage(int argc, char **argv)
 
 	printf("Usage:\t%s [options] command\n", argv0);
 	usage_options();
-	/* TODO */
-	printf("\t--version\tshow version (0.1)\n");
+	printf("\t--version\tshow version (" PACKAGE_VERSION ")\n");
 	printf("Commands:\n");
 	for_each_cmd(section) {
 		if (section->parent)
@@ -215,8 +215,7 @@ static void usage_cmd(const struct cmd *cmd)
 
 static void version(void)
 {
-	/* TODO */
-	printf("iwpan version 0.1\n");
+	printf("iwpan version " PACKAGE_VERSION "\n");
 }
 
 static int phy_lookup(char *name)
-- 
2.1.3

