Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:60906 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbbHUIjw (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 21 Aug 2015 04:39:52 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH 2/2] ieee802154: af_ieee802154: fix typo in comment.
Date: Fri, 21 Aug 2015 10:39:40 +0200
Message-Id: <1440146380-12066-2-git-send-email-stefan@osg.samsung.com>
In-Reply-To: <1440146380-12066-1-git-send-email-stefan@osg.samsung.com>
References: <1440146380-12066-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>

Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
---
 include/net/af_ieee802154.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/af_ieee802154.h b/include/net/af_ieee802154.h
index 7d38e2f..a5563d2 100644
--- a/include/net/af_ieee802154.h
+++ b/include/net/af_ieee802154.h
@@ -1,5 +1,5 @@
 /*
- * IEEE 802.15.4 inteface for userspace
+ * IEEE 802.15.4 interface for userspace
  *
  * Copyright 2007, 2008 Siemens AG
  *
-- 
2.4.3

