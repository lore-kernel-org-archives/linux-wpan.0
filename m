Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44292 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932311AbcDGSym (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 7 Apr 2016 14:54:42 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFCv2 bluetooth-next 14/21] 6lowpan: remove ipv6 module request
Date: Thu,  7 Apr 2016 20:54:15 +0200
Message-Id: <1460055262-4330-15-git-send-email-aar@pengutronix.de>
In-Reply-To: <1460055262-4330-1-git-send-email-aar@pengutronix.de>
References: <1460055262-4330-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, Alexander Aring <aar@pengutronix.de>

Since we use exported function from ipv6 kernel module we don't need to
request the module anymore to have ipv6 functionality.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 net/6lowpan/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
index fbae31e..824d1bc 100644
--- a/net/6lowpan/core.c
+++ b/net/6lowpan/core.c
@@ -158,8 +158,6 @@ static int __init lowpan_module_init(void)
 		return ret;
 	}
 
-	request_module_nowait("ipv6");
-
 	request_module_nowait("nhc_dest");
 	request_module_nowait("nhc_fragment");
 	request_module_nowait("nhc_hop");
-- 
2.8.0

