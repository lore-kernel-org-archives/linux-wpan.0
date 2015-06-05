Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:54280 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932602AbbFENc0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 5 Jun 2015 09:32:26 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH wpan-tools 2/3] gitignore: add generated iwpan-info
Date: Fri,  5 Jun 2015 15:32:11 +0200
Message-Id: <1433511132-15818-3-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1433511132-15818-1-git-send-email-stefan@osg.samsung.com>
References: <1433511132-15818-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>, Stefan Schmidt <stefan@osg.samsung.com>

From: Stefan Schmidt <s.schmidt@samsung.com>

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 src/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/.gitignore b/src/.gitignore
index d0989d6..356ac21 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -1,5 +1,6 @@
 .deps
 iwpan
+iwpan-info.o
 iwpan-interface.o
 iwpan-iwpan.o
 iwpan-sections.o
-- 
2.1.0

