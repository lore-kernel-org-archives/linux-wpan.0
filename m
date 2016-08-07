Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:52622 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751693AbcHGPeC (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Aug 2016 11:34:02 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH wpan-misc 2/5] website: remove note about missing short address functionality
Date: Sun,  7 Aug 2016 17:33:21 +0200
Message-Id: <20160807153324.9642-2-aar@pengutronix.de>
In-Reply-To: <20160807153324.9642-1-aar@pengutronix.de>
References: <20160807153324.9642-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 website/index.txt | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/website/index.txt b/website/index.txt
index 1438c6e..5d9793a 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -81,11 +81,6 @@ ip link add link wpan0 name lowpan0 type lowpan
 That's it! Now you have some lowpan0 interface with a 6LoWPAN 1280 MTU which runs on top the wpan interface.
 As default you have a default link-local address based on the MAC (extended address).
 
-Note: we don't support any case of short-addresses right now. This is a complicated issue with the IPv6 neighbour discovery cache.
-Of course we supporting broadcast frames via short-addresses but nothing more in 802.15.4 6LoWPAN.
-Only extended address handling is supported right now.
-
-
 Setup a 6LowPAN test network
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.9.2

