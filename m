Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:40007 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbbK3LVc (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 30 Nov 2015 06:21:32 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 3/4] wpan-ping: remove unused parameter from init_server()
Date: Mon, 30 Nov 2015 12:21:21 +0100
Message-Id: <1448882482-20784-3-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1448882482-20784-1-git-send-email-stefan@osg.samsung.com>
References: <1448882482-20784-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

The conf struct was used before but no longer since some refactoring. Remove
the need for this left-over.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 wpan-ping/wpan-ping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/wpan-ping/wpan-ping.c b/wpan-ping/wpan-ping.c
index 665ed93..edba8dd 100644
--- a/wpan-ping/wpan-ping.c
+++ b/wpan-ping/wpan-ping.c
@@ -333,7 +333,7 @@ static int measure_roundtrip(struct config *conf, int sd) {
 	return 0;
 }
 
-static void init_server(struct config *conf, int sd) {
+static void init_server(int sd) {
 	ssize_t len;
 	unsigned char *buf;
 	struct sockaddr_ieee802154 src;
@@ -383,7 +383,7 @@ static int init_network(struct config *conf) {
 	}
 
 	if (conf->server)
-		init_server(conf, sd);
+		init_server(sd);
 	else
 		measure_roundtrip(conf, sd);
 
-- 
2.4.3

