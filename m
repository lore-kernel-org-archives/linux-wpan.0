Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:44857 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883AbaHTXSX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 Aug 2014 19:18:23 -0400
Received: by mail-wi0-f169.google.com with SMTP id n3so7319697wiv.4
        for <linux-wpan@vger.kernel.org>; Wed, 20 Aug 2014 16:18:22 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 3/8] gitignore: add gitignore files
Date: Thu, 21 Aug 2014 01:17:52 +0200
Message-Id: <1408576677-28149-4-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1408576677-28149-1-git-send-email-alex.aring@gmail.com>
References: <1408576677-28149-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 .gitignore     | 11 +++++++++++
 m4/.gitignore  |  5 +++++
 src/.gitignore |  5 +++++
 3 files changed, 21 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 m4/.gitignore
 create mode 100644 src/.gitignore

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 0000000..522b35c
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1,11 @@
+tags
+TAGS
+Makefile
+Makefile.in
+aclocal.m4
+autom4te.cache
+build-aux
+config.*
+configure
+libtool
+stamp-h1
diff --git a/m4/.gitignore b/m4/.gitignore
new file mode 100644
index 0000000..38066dd
--- /dev/null
+++ b/m4/.gitignore
@@ -0,0 +1,5 @@
+libtool.m4
+ltoptions.m4
+ltsugar.m4
+ltversion.m4
+lt~obsolete.m4
diff --git a/src/.gitignore b/src/.gitignore
new file mode 100644
index 0000000..1cc1353
--- /dev/null
+++ b/src/.gitignore
@@ -0,0 +1,5 @@
+.deps
+iwpan
+iwpan-interface.o
+iwpan-iwpan.o
+iwpan-sections.o
-- 
2.0.4

