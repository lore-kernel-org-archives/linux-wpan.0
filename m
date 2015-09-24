Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:34456 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbbIXHhT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 24 Sep 2015 03:37:19 -0400
Received: by wicfx3 with SMTP id fx3so15658715wic.1
        for <linux-wpan@vger.kernel.org>; Thu, 24 Sep 2015 00:37:18 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/2] ieee802154: remove unnecessary includes
Date: Thu, 24 Sep 2015 09:37:10 +0200
Message-Id: <1443080231-6416-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes some unnecessary includes from ieee802154 header,
which was introduced by commit b609fb54adfa ("ieee802154: add helpers for
frame control checks").

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/linux/ieee802154.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index aca228b..d3e4156 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -25,9 +25,6 @@
 
 #include <linux/types.h>
 #include <linux/random.h>
-#include <linux/skbuff.h>
-#include <linux/unaligned/memmove.h>
-#include <asm/byteorder.h>
 
 #define IEEE802154_MTU			127
 #define IEEE802154_ACK_PSDU_LEN		5
-- 
2.5.2

