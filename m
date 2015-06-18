Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:53698 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbbFRW1v (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Jun 2015 18:27:51 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 1/3] wpan-ping: Reduce packet recv timeout to 500ms from 2s
Date: Fri, 19 Jun 2015 00:27:37 +0200
Message-Id: <1434666459-27827-2-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1434666459-27827-1-git-send-email-stefan@osg.samsung.com>
References: <1434666459-27827-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

Under normal condistions a full length 802154 frame takes areound 18ms rtt.
Setting the timeout to 2s is way to high so we reduce it to 500ms.

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 wpan-ping/wpan-ping.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/wpan-ping/wpan-ping.c b/wpan-ping/wpan-ping.c
index c83a0ad..d3f44f1 100644
--- a/wpan-ping/wpan-ping.c
+++ b/wpan-ping/wpan-ping.c
@@ -248,9 +248,9 @@ static int measure_roundtrip(struct config *conf, int sd) {
 			conf->dst_addr, conf->pan_id, conf->packet_len);
 	buf = (unsigned char *)malloc(MAX_PAYLOAD_LEN);
 
-	/* 2 seconds packet receive timeout */
-	timeout.tv_sec = 2;
-	timeout.tv_usec = 0;
+	/* 500ms seconds packet receive timeout */
+	timeout.tv_sec = 0;
+	timeout.tv_usec = 500000;
 	setsockopt(sd, SOL_SOCKET, SO_RCVTIMEO, (struct timeval *)&timeout,sizeof(struct timeval));
 
 	count = 0;
@@ -295,7 +295,7 @@ static int measure_roundtrip(struct config *conf, int sd) {
 				fprintf(stdout, "%i bytes from 0x%04x seq=%i time=%.1f ms\n", ret,
 					conf->dst_addr, (int)seq_num, (float)usec/1000);
 		} else
-			fprintf(stderr, "Hit 2s packet timeout\n");
+			fprintf(stderr, "Hit 500 ms packet timeout\n");
 	}
 
 	if (count)
-- 
2.4.3

