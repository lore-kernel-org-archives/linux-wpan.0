Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:33589 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423AbaLDK6Q (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Dec 2014 05:58:16 -0500
From: Stefan Schmidt <s.schmidt@samsung.com>
Subject: [PATCH bluetooth-next 2/5] net/ieee802154: Make sure alignment matches parenthesis..
Date: Thu,  4 Dec 2014 11:51:58 +0100
Message-Id: <1417690321-19450-2-git-send-email-s.schmidt@samsung.com>
In-Reply-To: <1417690321-19450-1-git-send-email-s.schmidt@samsung.com>
References: <1417690321-19450-1-git-send-email-s.schmidt@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>

Follow coding style of the kernel.

Signed-off-by: Stefan Schmidt <s.schmidt@samsung.com>
---
 net/ieee802154/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/netlink.c b/net/ieee802154/netlink.c
index 6ad0da3..3cdfa78 100644
--- a/net/ieee802154/netlink.c
+++ b/net/ieee802154/netlink.c
@@ -73,7 +73,7 @@ out:
 }
 
 struct sk_buff *ieee802154_nl_new_reply(struct genl_info *info,
-		int flags, u8 req)
+					int flags, u8 req)
 {
 	void *hdr;
 	struct sk_buff *msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
-- 
1.9.3

