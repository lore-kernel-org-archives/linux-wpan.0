Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36783 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbaKQHVa (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 17 Nov 2014 02:21:30 -0500
Received: by mail-wi0-f176.google.com with SMTP id ex7so4693021wid.15
        for <linux-wpan@vger.kernel.org>; Sun, 16 Nov 2014 23:21:29 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 06/13] mac802154: remove deprecated linux-zigbee info
Date: Mon, 17 Nov 2014 08:20:48 +0100
Message-Id: <1416208855-8623-7-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1416208855-8623-1-git-send-email-alex.aring@gmail.com>
References: <1416208855-8623-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

We don't and we can't name it zigbee anymore. This patch removes
deprecated information for project website.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 0af1be6..5199f21 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -4,8 +4,6 @@
  * Written by:
  * Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
  *
- * Based on the code from 'linux-zigbee.sourceforge.net' project.
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2
  * as published by the Free Software Foundation.
-- 
2.1.3

