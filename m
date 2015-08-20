Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36531 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229AbbHTQv3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 20 Aug 2015 12:51:29 -0400
Received: by wicja10 with SMTP id ja10so150526693wic.1
        for <linux-wpan@vger.kernel.org>; Thu, 20 Aug 2015 09:51:28 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFCv2 bluetooth-next 05/16] ieee802154: 6lowpan: remove EXPORT_SYMBOL
Date: Thu, 20 Aug 2015 18:47:34 +0200
Message-Id: <1440089265-23366-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1440089265-23366-1-git-send-email-alex.aring@gmail.com>
References: <1440089265-23366-1-git-send-email-alex.aring@gmail.com>
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
2.5.0

