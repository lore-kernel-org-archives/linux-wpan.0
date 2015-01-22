Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:55443 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038AbbAVV2s (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 22 Jan 2015 16:28:48 -0500
Received: by mail-wg0-f52.google.com with SMTP id y19so4122290wgg.11
        for <linux-wpan@vger.kernel.org>; Thu, 22 Jan 2015 13:28:47 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-misc 1/2] website: add irc channel info
Date: Thu, 22 Jan 2015 22:28:21 +0100
Message-Id: <1421962102-20901-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patchs adds information about the official linux-wpan irc chat.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 website/index.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/website/index.txt b/website/index.txt
index 4ccb218..2b4c367 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -2,6 +2,9 @@ linux-wpan
 ==========
 Mailinglist <linux-wpan@vger.kernel.org>
 
+.IRC
+#linux-wpan on irc.freenode.net
+
 wpan-tools
 ----------
 
-- 
2.2.2

