Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36704 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbbDTQPp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Apr 2015 12:15:45 -0400
Received: by wizk4 with SMTP id k4so105987632wiz.1
        for <linux-wpan@vger.kernel.org>; Mon, 20 Apr 2015 09:15:44 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-misc] website: add mailinglist archive information
Date: Mon, 20 Apr 2015 18:15:34 +0200
Message-Id: <1429546534-7952-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

This patch adds mailinglist archive information. This is a general
information and several people asking if there is any mailinglist archive.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 website/index.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/website/index.txt b/website/index.txt
index 0a135e2..2dfa962 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -1,6 +1,9 @@
 linux-wpan
 ==========
-Mailinglist <linux-wpan@vger.kernel.org>
+Mailinglist
+
+<linux-wpan@vger.kernel.org>
+http://www.spinics.net/lists/linux-wpan[Mailinglist-Archive]
 
 .IRC
 #linux-wpan on irc.freenode.net
-- 
2.3.5

