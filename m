Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:33025 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbbCSDlo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 18 Mar 2015 23:41:44 -0400
Received: by pdnc3 with SMTP id c3so62918813pdn.0
        for <linux-wpan@vger.kernel.org>; Wed, 18 Mar 2015 20:41:43 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH wpan-tools] gitignore: add object files
Date: Thu, 19 Mar 2015 09:11:18 +0530
Message-Id: <1426736478-6140-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Varka Bhadram <varkab@cdac.in>


Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 .gitignore |    1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 522b35c..ef71c6a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,4 @@
+*.o
 tags
 TAGS
 Makefile
-- 
1.7.9.5

