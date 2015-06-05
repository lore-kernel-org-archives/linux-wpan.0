Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:56460 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbbFEVrc (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 5 Jun 2015 17:47:32 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 2/3] gitignore: use wildcard to ignore object files
Date: Fri,  5 Jun 2015 23:47:24 +0200
Message-Id: <1433540844-19413-1-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <20150605160835.GA5850@bogon.m.sigxcpu.org>
References: <20150605160835.GA5850@bogon.m.sigxcpu.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>, Stefan Schmidt <stefan@osg.samsung.com>

From: Stefan Schmidt <s.schmidt@samsung.com>

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 src/.gitignore | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/src/.gitignore b/src/.gitignore
index d0989d6..a0a601d 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -1,7 +1,3 @@
 .deps
 iwpan
-iwpan-interface.o
-iwpan-iwpan.o
-iwpan-sections.o
-iwpan-mac.o
-iwpan-phy.o
+*.o
-- 
2.1.0

