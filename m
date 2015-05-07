Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38733 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbbEGLwv (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 7 May 2015 07:52:51 -0400
Received: by wiun10 with SMTP id n10so56686083wiu.1
        for <linux-wpan@vger.kernel.org>; Thu, 07 May 2015 04:52:49 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv wpan-tools] inteface: use hexadecimal for print extended addr
Date: Thu,  7 May 2015 13:52:41 +0200
Message-Id: <1430999561-28790-1-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>

This patch prints the extended addr in hexadecimal value. This is what
the "0x...." prefix suggested.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Cc: Guido Günther <agx@sigxcpu.org>
---
 src/interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/interface.c b/src/interface.c
index 5e0ef89..e501763 100644
--- a/src/interface.c
+++ b/src/interface.c
@@ -203,7 +203,7 @@ static int print_iface_handler(struct nl_msg *msg, void *arg)
 		printf("%s\twpan_dev 0x%llx\n", indent,
 		       (unsigned long long)nla_get_u64(tb_msg[NL802154_ATTR_WPAN_DEV]));
 	if (tb_msg[NL802154_ATTR_EXTENDED_ADDR])
-		printf("%s\textended_addr 0x%016" PRIu64 "\n", indent,
+		printf("%s\textended_addr 0x%016" PRIx64 "\n", indent,
 		       le64toh(nla_get_u64(tb_msg[NL802154_ATTR_EXTENDED_ADDR])));
 	if (tb_msg[NL802154_ATTR_SHORT_ADDR])
 		printf("%s\tshort_addr 0x%04x\n", indent,
-- 
2.3.7

