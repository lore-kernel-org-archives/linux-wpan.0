Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:45841 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751699AbcHGPeC (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Aug 2016 11:34:02 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH wpan-misc 3/5] website: fix typo
Date: Sun,  7 Aug 2016 17:33:22 +0200
Message-Id: <20160807153324.9642-3-aar@pengutronix.de>
In-Reply-To: <20160807153324.9642-1-aar@pengutronix.de>
References: <20160807153324.9642-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 website/index.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/website/index.txt b/website/index.txt
index 5d9793a..1dcdf32 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -81,7 +81,7 @@ ip link add link wpan0 name lowpan0 type lowpan
 That's it! Now you have some lowpan0 interface with a 6LoWPAN 1280 MTU which runs on top the wpan interface.
 As default you have a default link-local address based on the MAC (extended address).
 
-Setup a 6LowPAN test network
+Setup a 6LoWPAN test network
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Let's assume you want to setup a 6lowpan test network of six nodes.
-- 
2.9.2

