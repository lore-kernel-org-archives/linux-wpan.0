Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:43295 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753547AbbIBJxI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 2 Sep 2015 05:53:08 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 1/5] wpan-ping: align wpan-ping version with the general wpan-tools version
Date: Wed,  2 Sep 2015 11:52:53 +0200
Message-Id: <1441187577-12534-2-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1441187577-12534-1-git-send-email-stefan@osg.samsung.com>
References: <1441187577-12534-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

As we have it shipped with wpan-tools now we do not have a reason to go for a
different version scheme.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 wpan-ping/wpan-ping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wpan-ping/wpan-ping.c b/wpan-ping/wpan-ping.c
index 6607474..d514fe3 100644
--- a/wpan-ping/wpan-ping.c
+++ b/wpan-ping/wpan-ping.c
@@ -474,7 +474,7 @@ int main(int argc, char *argv[]) {
 			conf->interface = optarg;
 			break;
 		case 'v':
-			fprintf(stdout, "wpan-ping 0.1\n");
+			fprintf(stdout, "wpan-ping " PACKAGE_VERSION "\n");
 			return 1;
 		case 'h':
 			usage(argv[0]);
-- 
2.4.3

