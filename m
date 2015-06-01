Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from box.christofferholmstedt.se ([188.166.68.52]:45672 "EHLO
	box.christofferholmstedt.se" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751201AbbFAJE0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Jun 2015 05:04:26 -0400
Received: from authenticated-user (unknown [127.0.0.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by box.christofferholmstedt.se (Postfix) with ESMTPSA id 9608B140D95
	for <linux-wpan@vger.kernel.org>; Mon,  1 Jun 2015 05:04:24 -0400 (EDT)
Date: Mon, 1 Jun 2015 09:04:15 +0000
From: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
Subject: [PATCH wpan-tools] info: fix printf taking the wrong amount of
 arguments
Message-ID: <20150601090407.GA2974@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Signed-off-by: Christoffer Holmstedt <christoffer@christofferholmstedt.se>
---
 src/info.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/info.c b/src/info.c
index e8f5dda8da94..926a63adecce 100644
--- a/src/info.c
+++ b/src/info.c
@@ -54,7 +54,7 @@ static int print_phy_handler(struct nl_msg *msg, void *arg)
 				    rem_page) {
 			channel = nla_get_u32(nl_page);
 			if (channel) {
-				printf("\tpage %d: ", page, channel);
+				printf("\tpage %d: ", page);
 				for (i = 0; i <= 31; i++) {
 					if (channel & 0x1)
 						printf("%d,", i);
-- 
1.7.10.4


-- 
Christoffer Holmstedt
