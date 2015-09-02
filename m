Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36738 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754315AbbIBMWI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 2 Sep 2015 08:22:08 -0400
Received: by wibz8 with SMTP id z8so63880999wib.1
        for <linux-wpan@vger.kernel.org>; Wed, 02 Sep 2015 05:22:07 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 05/16] ieee802154: 6lowpan: remove EXPORT_SYMBOL
Date: Wed,  2 Sep 2015 14:21:20 +0200
Message-Id: <1441196491-25013-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1441196491-25013-1-git-send-email-alex.aring@gmail.com>
References: <1441196491-25013-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This function is used internally inside of ieee802154 6lowpan module
only and not outside of any other module. We don't need to export this
function then.

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/reassembly.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index 60d6df7..0fc3350 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -387,7 +387,6 @@ err:
 	kfree_skb(skb);
 	return -1;
 }
-EXPORT_SYMBOL(lowpan_frag_rcv);
 
 #ifdef CONFIG_SYSCTL
 static int zero;
-- 
2.5.1

