Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:56283 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbbKJVmr (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 10 Nov 2015 16:42:47 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 3/4] wpan-ping: do not try to send data back to origin if we got an error from recvfrom
Date: Tue, 10 Nov 2015 22:42:35 +0100
Message-Id: <1447191756-15928-4-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1447191756-15928-1-git-send-email-stefan@osg.samsung.com>
References: <1447191756-15928-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

In the case of a length of -1 from recvfrom we print out the error code but we
never left the current loop iteration. That might be problematic when we try to
send the data back with sendto. Instead we now continue with the next iteration
from now on if we get an error.

CID: 32115
Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 wpan-ping/wpan-ping.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/wpan-ping/wpan-ping.c b/wpan-ping/wpan-ping.c
index 8f4c13c..616e0dd 100644
--- a/wpan-ping/wpan-ping.c
+++ b/wpan-ping/wpan-ping.c
@@ -345,12 +345,14 @@ static void init_server(struct config *conf, int sd) {
 		len = recvfrom(sd, buf, MAX_PAYLOAD_LEN, 0, (struct sockaddr *)&src, &addrlen);
 		if (len < 0) {
 			perror("recvfrom");
+			continue;
 		}
 		//dump_packet(buf, len);
 		/* Send same packet back */
 		len = sendto(sd, buf, len, 0, (struct sockaddr *)&src, addrlen);
 		if (len < 0) {
 			perror("sendto");
+			continue;
 		}
 	}
 	free(buf);
-- 
2.4.3

