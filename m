Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:46131 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbaHTXS1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 Aug 2014 19:18:27 -0400
Received: by mail-wi0-f172.google.com with SMTP id n3so7855671wiv.5
        for <linux-wpan@vger.kernel.org>; Wed, 20 Aug 2014 16:18:26 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-tools 8/8] gitignore: add phy and mac object files
Date: Thu, 21 Aug 2014 01:17:57 +0200
Message-Id: <1408576677-28149-9-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1408576677-28149-1-git-send-email-alex.aring@gmail.com>
References: <1408576677-28149-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 src/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/.gitignore b/src/.gitignore
index 1cc1353..d0989d6 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -3,3 +3,5 @@ iwpan
 iwpan-interface.o
 iwpan-iwpan.o
 iwpan-sections.o
+iwpan-mac.o
+iwpan-phy.o
-- 
2.0.4

