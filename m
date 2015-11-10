Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:56286 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758AbbKJVms (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 10 Nov 2015 16:42:48 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 4/4] wpan-ping: avoid leaking socket handle on error path
Date: Tue, 10 Nov 2015 22:42:36 +0100
Message-Id: <1447191756-15928-5-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1447191756-15928-1-git-send-email-stefan@osg.samsung.com>
References: <1447191756-15928-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

If the bind failed we would return without closing the socket. Better do
so now.

CID: 32116
Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 wpan-ping/wpan-ping.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/wpan-ping/wpan-ping.c b/wpan-ping/wpan-ping.c
index 616e0dd..b454ddb 100644
--- a/wpan-ping/wpan-ping.c
+++ b/wpan-ping/wpan-ping.c
@@ -372,6 +372,7 @@ static int init_network(struct config *conf) {
 	ret = bind(sd, (struct sockaddr *)&conf->src, sizeof(conf->src));
 	if (ret) {
 		perror("bind");
+		close(sd);
 		return 1;
 	}
 
-- 
2.4.3

