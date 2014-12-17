Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:63596 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbaLQI6K (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 17 Dec 2014 03:58:10 -0500
Received: by mail-pd0-f179.google.com with SMTP id fp1so15805073pdb.38
        for <linux-wpan@vger.kernel.org>; Wed, 17 Dec 2014 00:58:09 -0800 (PST)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH wpan-misc] website: change theme to 'volnitsky'
Date: Wed, 17 Dec 2014 14:24:00 +0530
Message-Id: <1418806440-7768-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Varka Bhadram <varkab@cdac.in>


Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 website/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/website/Makefile b/website/Makefile
index cc090bc..41a152b 100644
--- a/website/Makefile
+++ b/website/Makefile
@@ -1,5 +1,5 @@
 all:
-	asciidoc -b html5 -a icons -a toc2 -a theme=flask index.txt
+	asciidoc -b html5 -a icons -a toc2 -a theme=volnitsky index.txt
 
 clean:
 	rm index.html
-- 
1.7.9.5

