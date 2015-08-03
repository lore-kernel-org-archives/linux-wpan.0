Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:36526 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735AbbHCGXp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 3 Aug 2015 02:23:45 -0400
Received: by wicgj17 with SMTP id gj17so89914818wic.1
        for <linux-wpan@vger.kernel.org>; Sun, 02 Aug 2015 23:23:44 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [RFC 03/16] ieee802154: 6lowpan: remove EXPORT_SYMBOL
Date: Mon,  3 Aug 2015 08:23:42 +0200
Message-Id: <1438583035-6287-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This function is used internally inside of ieee802154 6lowpan module
only and not outside of any other module. We don't need to export this
function then.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/6lowpan/reassembly.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index c9f77f7..cfb8443 100644
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

