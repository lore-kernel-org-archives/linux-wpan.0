Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35286 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbbE0IwE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 27 May 2015 04:52:04 -0400
Received: by pdea3 with SMTP id a3so5611652pde.2
        for <linux-wpan@vger.kernel.org>; Wed, 27 May 2015 01:52:04 -0700 (PDT)
From: Varka Bhadram <varkabhadram@gmail.com>
Subject: [PATCH bluetooth-next] ieee802154: fix typo for file name
Date: Wed, 27 May 2015 14:21:06 +0530
Message-Id: <1432716666-23737-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, Varka Bhadram <varkab@cdac.in>


Signed-off-by: Varka Bhadram <varkab@cdac.in>
---
 net/ieee802154/trace.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/trace.h b/net/ieee802154/trace.h
index 5ac25eb..144de54 100644
--- a/net/ieee802154/trace.h
+++ b/net/ieee802154/trace.h
@@ -1,4 +1,4 @@
-/* Based on net/wireless/tracing.h */
+/* Based on net/wireless/trace.h */
 
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM cfg802154
-- 
1.7.9.5

