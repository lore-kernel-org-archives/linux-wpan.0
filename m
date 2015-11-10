Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:56277 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbbKJVmp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 10 Nov 2015 16:42:45 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 1/4] wpan-ping: remove unused struct sockaddr_nl variable
Date: Tue, 10 Nov 2015 22:42:33 +0100
Message-Id: <1447191756-15928-2-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1447191756-15928-1-git-send-email-stefan@osg.samsung.com>
References: <1447191756-15928-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 wpan-ping/wpan-ping.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/wpan-ping/wpan-ping.c b/wpan-ping/wpan-ping.c
index 5429ca3..8f781c1 100644
--- a/wpan-ping/wpan-ping.c
+++ b/wpan-ping/wpan-ping.c
@@ -151,7 +151,6 @@ static void nl802154_cleanup(struct config *conf)
 static int nl_msg_cb(struct nl_msg* msg, void* arg)
 {
 	struct config *conf = arg;
-	struct sockaddr_nl nla;
 	struct nlmsghdr *nlh = nlmsg_hdr(msg);
 	struct nlattr *attrs[NL802154_ATTR_MAX+1];
 	uint64_t temp;
-- 
2.4.3

