Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:43298 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753548AbbIBJxI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 2 Sep 2015 05:53:08 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 2/5] wpan-ping: remove no longer used b option from getopt string
Date: Wed,  2 Sep 2015 11:52:54 +0200
Message-Id: <1441187577-12534-3-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1441187577-12534-1-git-send-email-stefan@osg.samsung.com>
References: <1441187577-12534-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

We used that earlier for the bind command which we now longer need and have
removed already.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 wpan-ping/wpan-ping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/wpan-ping/wpan-ping.c b/wpan-ping/wpan-ping.c
index d514fe3..e0ec399 100644
--- a/wpan-ping/wpan-ping.c
+++ b/wpan-ping/wpan-ping.c
@@ -443,9 +443,9 @@ int main(int argc, char *argv[]) {
 	while (1) {
 #ifdef HAVE_GETOPT_LONG
 		int opt_idx = -1;
-		c = getopt_long(argc, argv, "b:a:ec:s:i:dvh", perf_long_opts, &opt_idx);
+		c = getopt_long(argc, argv, "a:ec:s:i:dvh", perf_long_opts, &opt_idx);
 #else
-		c = getopt(argc, argv, "b:a:ec:s:i:dvh");
+		c = getopt(argc, argv, "a:ec:s:i:dvh");
 #endif
 		if (c == -1)
 			break;
-- 
2.4.3

