Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:56280 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbbKJVmq (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 10 Nov 2015 16:42:46 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 2/4] wpan-ping: check return value for setsockopt
Date: Tue, 10 Nov 2015 22:42:34 +0100
Message-Id: <1447191756-15928-3-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1447191756-15928-1-git-send-email-stefan@osg.samsung.com>
References: <1447191756-15928-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

In case we fail to set the receive timeout print the error.

CID: 32113
Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 wpan-ping/wpan-ping.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/wpan-ping/wpan-ping.c b/wpan-ping/wpan-ping.c
index 8f781c1..8f4c13c 100644
--- a/wpan-ping/wpan-ping.c
+++ b/wpan-ping/wpan-ping.c
@@ -254,7 +254,10 @@ static int measure_roundtrip(struct config *conf, int sd) {
 	/* 500ms seconds packet receive timeout */
 	timeout.tv_sec = 0;
 	timeout.tv_usec = 500000;
-	setsockopt(sd, SOL_SOCKET, SO_RCVTIMEO, (struct timeval *)&timeout,sizeof(struct timeval));
+	ret = setsockopt(sd, SOL_SOCKET, SO_RCVTIMEO, (struct timeval *)&timeout,sizeof(struct timeval));
+	if (ret < 0) {
+		perror("setsockopt receive timeout");
+	}
 
 	count = 0;
 	for (i = 0; i < conf->packets; i++) {
-- 
2.4.3

