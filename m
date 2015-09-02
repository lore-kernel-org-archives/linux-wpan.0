Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:43305 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600AbbIBJxK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 2 Sep 2015 05:53:10 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 4/5] wpan-ping: use correct define to fix getopt_long usage
Date: Wed,  2 Sep 2015 11:52:56 +0200
Message-Id: <1441187577-12534-5-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1441187577-12534-1-git-send-email-stefan@osg.samsung.com>
References: <1441187577-12534-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

HAVE_GETOPT_LONG is never defined here and seems to be obsolete. Use
_GNU_SOURCE here as getopt_long is a GNU extension. This fixes long
options to work properly.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 wpan-ping/wpan-ping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/wpan-ping/wpan-ping.c b/wpan-ping/wpan-ping.c
index 7b53373..9f01ae6 100644
--- a/wpan-ping/wpan-ping.c
+++ b/wpan-ping/wpan-ping.c
@@ -69,7 +69,7 @@ struct sockaddr_ieee802154 {
 	struct ieee802154_addr_sa addr;
 };
 
-#ifdef HAVE_GETOPT_LONG
+#ifdef _GNU_SOURCE
 static const struct option perf_long_opts[] = {
 	{ "daemon", no_argument, NULL, 'd' },
 	{ "address", required_argument, NULL, 'a' },
@@ -441,7 +441,7 @@ int main(int argc, char *argv[]) {
 	}
 
 	while (1) {
-#ifdef HAVE_GETOPT_LONG
+#ifdef _GNU_SOURCE
 		int opt_idx = -1;
 		c = getopt_long(argc, argv, "a:ec:s:i:dvh", perf_long_opts, &opt_idx);
 #else
-- 
2.4.3

