Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:41973 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602AbaJYDZl (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Oct 2014 23:25:41 -0400
Received: by mail-lb0-f173.google.com with SMTP id 10so3438990lbg.4
        for <linux-wpan@vger.kernel.org>; Fri, 24 Oct 2014 20:25:39 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 6/6] ieee802154: wpan-class: fix trailing semicolon
Date: Sat, 25 Oct 2014 05:25:12 +0200
Message-Id: <1414207512-10281-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414207512-10281-1-git-send-email-alex.aring@gmail.com>
References: <1414207512-10281-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

This patch removes an unnecessary tailing semicolon after macro
define. Otherwise we get a trailing semicolon while using this macro.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/wpan-class.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ieee802154/wpan-class.c b/net/ieee802154/wpan-class.c
index 9a2dfab..e4c6fb3 100644
--- a/net/ieee802154/wpan-class.c
+++ b/net/ieee802154/wpan-class.c
@@ -33,7 +33,7 @@ static ssize_t name ## _show(struct device *dev,			\
 	mutex_unlock(&phy->pib_lock);					\
 	return ret;							\
 }									\
-static DEVICE_ATTR_RO(name);
+static DEVICE_ATTR_RO(name)
 
 #define MASTER_SHOW(field, format_string)				\
 	MASTER_SHOW_COMPLEX(field, format_string, phy->field)
-- 
2.1.2

