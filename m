Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:43307 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440AbbIBJxL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 2 Sep 2015 05:53:11 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 5/5] wpan-ping: fix segfault for accessing invalid address
Date: Wed,  2 Sep 2015 11:52:57 +0200
Message-Id: <1441187577-12534-6-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1441187577-12534-1-git-send-email-stefan@osg.samsung.com>
References: <1441187577-12534-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

If only given the -e/--extended option we would fail due to the assumption
that arg would contain the address to be parsed. Make sure we check for NULL
here instead of segfault.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 wpan-ping/wpan-ping.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/wpan-ping/wpan-ping.c b/wpan-ping/wpan-ping.c
index 9f01ae6..5429ca3 100644
--- a/wpan-ping/wpan-ping.c
+++ b/wpan-ping/wpan-ping.c
@@ -385,6 +385,9 @@ static int parse_dst_addr(struct config *conf, char *arg)
 {
 	int i;
 
+	if (!arg)
+		return -1;
+
 	/* PAN ID is filled from netlink in get_interface_info */
 	conf->dst.family = AF_IEEE802154;
 
@@ -422,7 +425,7 @@ static int parse_dst_addr(struct config *conf, char *arg)
 int main(int argc, char *argv[]) {
 	int c, ret;
 	struct config *conf;
-	char *dst_addr;
+	char *dst_addr = NULL;
 
 	conf = malloc(sizeof(struct config));
 
-- 
2.4.3

