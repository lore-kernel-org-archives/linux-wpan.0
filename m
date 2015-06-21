Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37465 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbbFUPLo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 21 Jun 2015 11:11:44 -0400
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next] 6lowpan: add request for ipv6 module
Date: Sun, 21 Jun 2015 17:11:19 +0200
Message-Id: <1434899479-22310-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de, jukka.rissanen@linux.intel.com, Alexander Aring <alex.aring@gmail.com>

The iphc module depends on CONFIG_IPV6, because it's not very useful to
build the module without IPv6 support. Recently an user reported about
issues for setting an IPv6 address to a 6LoWPAN interface. The issues
was solved by modprobe the ipv6 module before. To avoid such user issues
we try to request the ipv6 module when the 6LoWPAN module is loaded.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/6lowpan/iphc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 94a375c..9055d7b 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -613,6 +613,8 @@ EXPORT_SYMBOL_GPL(lowpan_header_compress);
 
 static int __init lowpan_module_init(void)
 {
+	request_module_nowait("ipv6");
+
 	request_module_nowait("nhc_dest");
 	request_module_nowait("nhc_fragment");
 	request_module_nowait("nhc_hop");
-- 
2.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
