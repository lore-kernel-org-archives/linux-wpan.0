Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:43302 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbbIBJxJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 2 Sep 2015 05:53:09 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 3/5] wpan-ping: fix usage message and mention -h option
Date: Wed,  2 Sep 2015 11:52:55 +0200
Message-Id: <1441187577-12534-4-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1441187577-12534-1-git-send-email-stefan@osg.samsung.com>
References: <1441187577-12534-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 wpan-ping/wpan-ping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wpan-ping/wpan-ping.c b/wpan-ping/wpan-ping.c
index e0ec399..7b53373 100644
--- a/wpan-ping/wpan-ping.c
+++ b/wpan-ping/wpan-ping.c
@@ -107,7 +107,7 @@ void usage(const char *name) {
 	"--size | -s packet length\n"
 	"--interface | -i listen on this interface (default wpan0)\n"
 	"--version | -v print out version\n"
-	"--help This usage text\n", name);
+	"--help | -h this usage text\n", name);
 }
 
 static int nl802154_init(struct config *conf)
-- 
2.4.3

