Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:39585 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751686AbcHGPeC (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Aug 2016 11:34:02 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH wpan-misc 4/5] website: add boards with transceiver section
Date: Sun,  7 Aug 2016 17:33:23 +0200
Message-Id: <20160807153324.9642-4-aar@pengutronix.de>
In-Reply-To: <20160807153324.9642-1-aar@pengutronix.de>
References: <20160807153324.9642-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 website/index.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/website/index.txt b/website/index.txt
index 1dcdf32..5b2f7d5 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -52,6 +52,13 @@ Supported Hardware
 |Xbee        |no |https://github.com/joaopedrotaveira/linux-rpl/blob/master/mainline-3.12.y/0001-Added-XBee-driver-support.patch[out of tree]| ?? | https://www.sparkfun.com/pages/xbee_guide[sparkfun]
 |=============================================================
 
+.Boards with Transceivers
+|=============================================================
+|Name        | Transceiver |Website
+|Ci40        | ca8210      |https://www.kickstarter.com/projects/imgtec/creator-ci40-the-ultimate-iot-in-a-box-dev-kit[kickstarter]
+|blixten     | cc2520      |https://jopee.wordpress.com/6lowpan-gateway/[jopee]
+|=============================================================
+
 How-To's
 --------
 
-- 
2.9.2

