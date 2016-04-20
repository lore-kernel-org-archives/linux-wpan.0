Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44103 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754505AbcDTIUK (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 20 Apr 2016 04:20:10 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCHv2 bluetooth-next 03/10] 6lowpan: remove ipv6 module request
Date: Wed, 20 Apr 2016 10:19:35 +0200
Message-Id: <1461140382-4784-4-git-send-email-aar@pengutronix.de>
In-Reply-To: <1461140382-4784-1-git-send-email-aar@pengutronix.de>
References: <1461140382-4784-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, marcel@holtmann.org, jukka.rissanen@linux.intel.com, hannes@stressinduktion.org, stefan@osg.samsung.com, mcr@sandelman.ca, werner@almesberger.net, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, Alexander Aring <aar@pengutronix.de>

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

