Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:55601 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751712AbcHGPeC (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Aug 2016 11:34:02 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH wpan-misc 5/5] website: add SOB for sending patches
Date: Sun,  7 Aug 2016 17:33:24 +0200
Message-Id: <20160807153324.9642-5-aar@pengutronix.de>
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
index 5b2f7d5..1c414bd 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -271,7 +271,7 @@ cd wpan-misc/website
 git checkout -b myproposal
 # Change this page to whatever you like.
 $EDITOR index.txt
-git commit -a
+git commit -s -a
 # be sure to be registered to linux-wpan@vger.kernel.org before sending the
 # patch
 git send-email --to linux-wpan@vger.kernel.org -1
-- 
2.9.2

