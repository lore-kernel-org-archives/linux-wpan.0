Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:55372 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966399AbaLLOV4 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Dec 2014 09:21:56 -0500
Received: by mail-wg0-f45.google.com with SMTP id b13so9213038wgh.4
        for <linux-wpan@vger.kernel.org>; Fri, 12 Dec 2014 06:21:54 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH wpan-misc 2/2] website: change dependency to libnl-3
Date: Fri, 12 Dec 2014 15:21:46 +0100
Message-Id: <1418394106-12799-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1418394106-12799-1-git-send-email-alex.aring@gmail.com>
References: <1418394106-12799-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 website/index.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/website/index.txt b/website/index.txt
index 5a3252b..c730a86 100644
--- a/website/index.txt
+++ b/website/index.txt
@@ -9,7 +9,7 @@ To access the nl802154 netlink inteface you will need the wpan-tools.
 
 Dependencies:
 
-- netlink library http://www.infradead.org/~tgr/libnl/[libnl].
+- netlink library http://www.infradead.org/~tgr/libnl/[libnl-3].
 
 These tools contains:
 
-- 
2.1.3

